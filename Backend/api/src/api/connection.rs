use actix_web::{get, post,  HttpResponse, Responder};
use actix_web::web::Data;
use actix_web::web::Json;
use actix_web_httpauth::extractors::basic::BasicAuth;
use hmac::{Hmac, Mac};
use sha2::Sha256;
use crate::{AppState, TokenClaims};
use sqlx::{self};
use jwt::SignWithKey;
use argonautica::{Hasher, Verifier};

use super::models::users_structs::{get_error_response, CreateUserBody, UserNoPassword, AuthUser};


#[post("/user")]
async fn create_user(state: Data<AppState>, body: Json<CreateUserBody>) -> impl Responder {
    let user: CreateUserBody = body.into_inner();

    let hash_secret = std::env::var("HASH_SECRET").expect("HASH_SECRET must be set!");
    let mut hasher = Hasher::default();
    let hash = hasher
        .with_password(user.password)
        .with_secret_key(hash_secret)
        .hash()
        .unwrap();
    match sqlx::query_as::<_, UserNoPassword>(
        "INSERT INTO users (username, email,password)
        VALUES ($1, $2,$3)
        RETURNING username, email",
    )
    .bind(user.username)
    .bind(user.email)
    .bind(hash)
    .fetch_one(&state.db)
    .await
    {
        Ok(user) => {
            println!("User created successfully");

            HttpResponse::Ok().json(user)
        }
        Err(error) => {
            let error_response = get_error_response(error);
            HttpResponse::Conflict().json(error_response)
            //HttpResponse::Unauthorized().json("Unable to create user")
        }
    }
}

#[get("/auth")]
async fn basic_auth(state: Data<AppState>, credentials: BasicAuth) -> impl Responder {
    let jwt_secret: Hmac<Sha256> = Hmac::new_from_slice(
        std::env::var("JWT_SECRET")
            .expect("JWT_SECRET must be set!")
            .as_bytes(),
    )
    .unwrap();
    let username = credentials.user_id();
    let password = credentials.password();

    match password {
        None => HttpResponse::Unauthorized().json("Must provide username and password"),
        Some(pass) => {
            match sqlx::query_as::<_, AuthUser>(
                "SELECT id, username, password FROM users WHERE username = $1 OR email = $1",
            )
            .bind(username.to_string())
            .fetch_one(&state.db)
            .await
            {
                Ok(user) => {
                    println!("User found");
                    let hash_secret =
                        std::env::var("HASH_SECRET").expect("HASH_SECRET must be set!");
                    let mut verifier = Verifier::default();
                    let is_valid = verifier
                        .with_hash(user.password)
                        .with_password(pass)
                        .with_secret_key(hash_secret)
                        .verify()
                        .unwrap();

                    if is_valid {
                        let claims = TokenClaims { id: user.id };
                        let token_str = claims.sign_with_key(&jwt_secret).unwrap();
                        HttpResponse::Ok().json(token_str)
                    } else {
                        HttpResponse::Unauthorized().json("Incorrect username or password")
                    }
                }
                Err(error) => {
                    //print type of error_code
                    eprintln!("Error type: {:?}", error);
                    println!("Error type: {:?}", error.to_string());
                    if error.to_string() == "RowNotFound" {
                        HttpResponse::Unauthorized().json("Incorrect username or password")
                    } else {
                        HttpResponse::InternalServerError().json("incorrect username or password")
                    }
                    //println!("{:?}", error);
                    //HttpResponse::InternalServerError().json(format!("{:?}", error))},
                }
            }
        }
    }
}
