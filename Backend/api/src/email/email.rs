use dotenv::dotenv;
use lettre::transport::smtp::authentication::Credentials;
use lettre::{SmtpTransport, Transport, Message};
use std::collections::HashMap;


use crate::api::models::users_structs::{get_response, ResponseCustom};
use crate::utilities::structs::EmailPassword;
use crate::utilities::env::read_env_values;



pub fn send_email(sent_email: String, number: i32) -> Result<ResponseCustom, ResponseCustom> {
    // Load the dotenv file
    dotenv().ok();
    // Check if env load
    let list: &[&str] = &["EMAIL", "PASSWORD"];
    let env_values: HashMap<&str, String> = read_env_values(list);
    
    let email_identifier = match EmailPassword::from_dictionary(env_values) {
        Some(identifier) => identifier,
        None => return Err(get_response(500u32, "Environements Values not set".to_string())), 
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
        Ok(_) => Ok(get_response(200u32, "Email sent successfully".to_string())),
        Err(_) => Err(get_response(500u32, "Failed to send email".to_string())),
        //get_response(409, "Failed to send email".to_string()),

    }
}

