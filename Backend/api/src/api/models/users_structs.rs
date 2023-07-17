
use serde::{Deserialize, Serialize};
use sqlx::{self, FromRow};
use chrono::NaiveDateTime;

pub trait ToResponse {
    fn to_response(&self) -> ResponseCustom;
}

impl ToResponse for sqlx::Error {
    fn to_response(&self) -> ResponseCustom {
        let code : u32 = self.as_database_error().unwrap().code().unwrap().parse().unwrap_or(500u32);
        let message = self.as_database_error().unwrap().message().to_string();
        ResponseCustom {
            code,
            message,
        }
    }
}

impl ToResponse for (u32, String) {
    fn to_response(&self) -> ResponseCustom {
        let code = self.0.clone();
        let message = self.1.clone();
        ResponseCustom {
            code,
            message,
        }
    }
}

pub fn get_error_response(error: impl ToResponse) -> ResponseCustom {
    error.to_response()
}

pub fn get_response(code: u32, message: String) -> ResponseCustom {
    (code, message).to_response()
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
    pub id: u32,
    pub title: String,
    pub content: String,
    pub published_by: u32,
    pub published_on: Option<NaiveDateTime>,
}

#[derive(Serialize, Deserialize)]
pub struct ResponseCustom {
    #[serde(rename = "code")]
    pub code: u32,
    #[serde(rename = "message")]
    pub message: String,
}

impl std::fmt::Debug for ResponseCustom {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("ResponseCustom")
            .field("code", &self.code)
            .field("message", &self.message)
            .finish()
    }
}

