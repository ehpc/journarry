use std::net::{TcpListener, TcpStream};
use std::io::prelude::*;

fn main() {
    let listener = TcpListener::bind("127.0.0.1:3042").expect("Failed to bind to port 3042");
    println!("TCP Server listening on 127.0.0.1:3042");

    for stream in listener.incoming() {
        match stream {
            Ok(stream) => {
                handle_connection(stream);
            }
            Err(e) => {
                eprintln!("Connection failed: {}", e);
            }
        }
    }
}

fn handle_connection(mut stream: TcpStream) {
    let mut buffer = [0; 1024];
    
    match stream.read(&mut buffer) {
        Ok(bytes_read) => {
            println!("Received connection from: {:?}", stream.peer_addr());
            
            // Echo the received data back to the client
            if bytes_read > 0 {
                let received_data = &buffer[..bytes_read];
                println!("Echoing {} bytes back to client", bytes_read);
                
                if let Err(e) = stream.write_all(received_data) {
                    eprintln!("Failed to echo data back: {}", e);
                }
            }
        }
        Err(e) => {
            eprintln!("Failed to read from connection: {}", e);
        }
    }
}
