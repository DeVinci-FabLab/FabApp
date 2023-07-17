use std::collections::HashMap;
use std::env;


pub fn read_env_value(key: &str) -> String {

    let value = env::var(key).unwrap_or_else(|_| {
        panic!("Error: {} environment variable not found in .env file", key);
    });

    value
}
pub fn read_env_values<'a>(list: &[&'a str]) -> HashMap<&'a str, String> {
    let mut dictionary = HashMap::new();

    for &key in list {
        let value = env::var(key).unwrap_or_else(|_| {
            panic!("Error: {} environment variable not found in .env file", key);
        });
        dictionary.insert(key, value);
    }

    dictionary
}

