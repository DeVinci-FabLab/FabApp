use std::env;
use dotenv::dotenv;
use lettre::transport::smtp::authentication::Credentials;
use lettre::{SmtpTransport, Transport, Message};

pub fn send_email(sent_email: String, number: i32) {
    // Load the dotenv file
    dotenv().ok();

    let from_email = env::var("EMAIL").unwrap_or_else(|_| {
        panic!("Error: EMAIL environment variable not found in .env file");
    });
    let from_email_string = format!("ME <{}>",from_email);
    let sent_email_string = format!("YOU <{}>",sent_email);
    let password = env::var("PASSWORD").unwrap_or_else(|_| {
        panic!("Error: PASSWORD environment variable not found in .env file");
    });
    let message = format!("Hello World! \nYour code is: {}", number);
    let email_message = Message::builder()
        .from(from_email_string.parse().unwrap())
        .to(sent_email_string.parse().unwrap())
        .subject("Hello")
        .body(message.to_string())
        .unwrap();

    let creds = Credentials::new(from_email.clone(), password);

    let mailer = SmtpTransport::relay("ssl0.ovh.net")
        .unwrap()
        .credentials(creds)
        .build();

    match mailer.send(&email_message) {
        Ok(_) => println!("Email sent successfully!"),
        Err(e) => panic!("Could not send email: {:?}", e),
    }
}

