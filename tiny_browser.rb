require 'socket'
require 'json'
 
host = 'localhost'     				# The web server
port = 2000                         # Default HTTP port
path = "/index.html"  
patht = "/thanks.html"              # The file we want 
data = {"viking" => {:name => "name", :email => "email"}}

puts "would you like to GET or POST?"
choice = gets.chomp
if choice == "GET"
request = "GET #{path} HTTP/1.0\r\n\r\n"
end

if choice == "POST"
puts "enter a name for your viking:"
data["viking"][:name] = gets.chomp	
puts "enter an email for your viking:"
data["viking"][:email] = gets.chomp	

posted_data = data.to_json
request = "POST #{patht} HTTP/1.0\r\nContent-Length: #{posted_data.length}\r\n\r\n#{posted_data}"	
end
socket = TCPSocket.open(host,port)  # Connect to server
socket.print(request)               # Send request
response = socket.read              # Read complete response


puts response
