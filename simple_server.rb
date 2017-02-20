require 'socket'  				# Get sockets from stdlib
require 'json'             

server = TCPServer.open(2000)  	# Socket to listen on port 2000
params = {}

loop {                         	# Servers run forever
	      # Wait for a client to connect
client = server.accept       # Wait for a client to connect
puts "Listening on port 2000..."

  method, path = client.gets.split 
  if method == "POST"                   # In this case, method = "POST" and path = "/"
  headers = {}
  while line = client.gets.split(' ', 2)              # Collect HTTP headers
    break if line[0] == ""                            # Blank line means no more headers
    headers[line[0].chop] = line[1].strip             # Hash headers by type
  end
  data = client.read(headers["Content-Length"].to_i)  # Read the POST data as specified in the header


    
		params = JSON.parse(data)	
	end	

file = path[1..-1]

puts "REQUEST:#{method } #{path} #{data}"
 if File.exists?(file)
 	
if method == "POST"
	text = ""
 	
params["viking"].each do |k,v|

 text += "<li>#{k}:#{v}</li>\n"

end
  	client.puts "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\nFile size: #{File.size(file)}kb\r\n\r\n#{File.read(file).gsub!(/^\s*<%= yield %>\s*\n/,text)}"
  	end
 if method == "GET"
 client.puts "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\nFile size: #{File.size(file)}kb\r\n\r\n#{File.read(file)}"
 end 	

  	else
	client.puts "HTTP/1.1 404 Not Found\r\n\r\n"
  	end

client.close                   # Disconnect from the client
}
