use std::env;
use dotenv::dotenv;
use lettre::transport::smtp::authentication::Credentials;
use lettre::{SmtpTransport, Transport, Message};

fn main() {
    // Load the dotenv file
    dotenv().ok();

    let email = env::var("EMAIL").unwrap_or_else(|_| {
        panic!("Error: EMAIL environment variable not found in .env file");
    });
    let password = env::var("PASSWORD").unwrap_or_else(|_| {
        panic!("Error: PASSWORD environment variable not found in .env file");
    });
    let email_message = Message::builder()
        .from("ME <thomas.derudder@kodelab.fr>".parse().unwrap())
        .to("YOU <morgan@kodelab.fr>".parse().unwrap())
        .subject("Hello")
        .body("Hello World!".to_string())
        .unwrap();

    let creds = Credentials::new(email.clone(), password);

    let mailer = SmtpTransport::relay("ssl0.ovh.net")
        .unwrap()
        .credentials(creds)
        .build();

    match mailer.send(&email_message) {
        Ok(_) => println!("Email sent successfully!"),
        Err(e) => panic!("Could not send email: {:?}", e),
    }
}

