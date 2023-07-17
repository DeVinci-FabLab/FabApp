use serde::Serialize;
use std::collections::HashMap;
#[derive(Serialize)]
pub struct EmailPassword {
    pub email: String,
    pub password: String,
}

impl EmailPassword {
    pub fn from_dictionary(dictionary: HashMap<&str, String>) -> Option<Self> {
        let email = match dictionary.get("EMAIL") {
            Some(value) => value.clone(),
            None => return None, // or handle the missing field case
        };

        let password = match dictionary.get("PASSWORD") {
            Some(value) => value.clone(),
            None => return None, // or handle the missing field case
        };

        // Create and return the struct
        Some(Self { email, password})
    }
}
