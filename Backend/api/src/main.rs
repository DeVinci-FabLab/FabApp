use actix_web::{get, App, HttpServer};
mod api;
use api::user::{
    present
};
// use serde::{Deserialize, Serialize};
// use std::sync::Mutex;

#[get("/")]
async fn index() -> String{
    "Hello World!".to_string()
}

#[actix_web::main]
async fn main() -> std::io::Result<()>{

    HttpServer::new(move || {
        App::new()
            .service(index)
            .service(present)
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}