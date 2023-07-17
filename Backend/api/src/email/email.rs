use std::env;
use actix::Response;
use dotenv::dotenv;
use lettre::transport::smtp::authentication::Credentials;
use lettre::{SmtpTransport, Transport, Message};
use std::io;
use std::collections::HashMap;


use crate::api::models::users_structs::{get_error_response, get_response, ResponseCustom};
use crate::utilities::structs::EmailPassword;
use crate::utilities::env::{read_env_value, read_env_values};



pub fn send_email(sent_email: String, number: i32) -> Result<ResponseCustom, io::Error> {
    // Load the dotenv file
    dotenv().ok();
    // Check if env load
    let LIST: &[&str] = &["EMAIL", "PASSWORD"];
    let ENV_VALUES: HashMap<&str, String> = read_env_values(LIST);
    
    let email_identifier = match EmailPassword::from_dictionary(ENV_VALUES) {
        Some(identifier) => identifier,
        None => return Err(io::Error::new(io::ErrorKind::Other, "Email identifier not set")),
    };

    let from_email_string = format!("ME <{}>", email_identifier.email);
    let sent_email_string = format!("YOU <{}>", sent_email);
    let message = format!("Hello World! \nYour code is: {}", number);
    let email_message = Message::builder()
        .from(from_email_string.parse().unwrap())
        .to(sent_email_string.parse().unwrap())
        .subject("Hello")
        .body(message.to_string())
        .unwrap();

    let creds = Credentials::new(
        email_identifier.email.to_string(),
        email_identifier.password.to_string(),
    );

    let mailer = SmtpTransport::relay("ssl0.ovh.net")
        .unwrap()
        .credentials(creds)
        .build();

    match mailer.send(&email_message) {
        Ok(_) => Ok((get_response(200u32, "Email sent successfully".to_string()))),
        Err(_) => Err(io::Error::new(io::ErrorKind::InvalidData, "Failed to send email")),
        //get_response(409, "Failed to send email".to_string()),

    }
}

