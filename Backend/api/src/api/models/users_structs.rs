
use serde::{Deserialize, Serialize};
use sqlx::{self, FromRow};
use chrono::NaiveDateTime;

pub fn get_error_response(error: sqlx::Error) -> Response {
    let code= error.as_database_error().unwrap().code().unwrap().to_string();
    let message= error.as_database_error().unwrap().message().to_string();
    Response {
        code,
        message,
    }
}

#[derive(Deserialize)]
pub struct CreateUserBody {
    pub username: String,
    pub email: String,
    pub password: String,
}

#[derive(Serialize, FromRow)]
pub struct UserNoPassword {
    pub username: String,
    pub email: String,
}

#[derive(Serialize, FromRow)]
pub struct AuthUser {
    pub id: i32,
    pub username: String,
    pub password: String,
}

#[derive(Deserialize)]
pub struct CreateArticleBody {
    pub title: String,
    pub content: String,
}

#[derive(Serialize, FromRow)]
pub struct Article {
    pub id: i32,
    pub title: String,
    pub content: String,
    pub published_by: i32,
    pub published_on: Option<NaiveDateTime>,
}

#[derive(Serialize, Deserialize)]
pub struct Response {
    #[serde(rename = "code")]
    pub code: String,
    #[serde(rename = "message")]
    pub message: String,
}


