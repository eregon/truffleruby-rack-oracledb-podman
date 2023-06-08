puts "Starting"

require 'oci8'

puts "required"

# OCI = OCI8.new('sys', 'Welcome1', '//localhost:1521/FREE', :SYSDBA)
OCI = OCI8.new('sys/Welcome1@//localhost:1521/FREE as sysdba')
puts "connected"

OCI.exec('SELECT sysdate') { |r| p r }

begin
  OCI.exec('CREATE TABLE articles(title VARCHAR2(200) NOT NULL)')
rescue OCIError
  # already exists
end

OCI.exec("INSERT INTO articles(title) VALUES ('TruffleRuby running in podman')")
OCI.exec("INSERT INTO articles(title) VALUES ('with OracleDB ruby-oci8 database connector')")
OCI.exec("INSERT INTO articles(title) VALUES ('on Puma + NGINX on Oracle Linux 8')")

class App
  def call(env)
    headers = {
      'Content-Type' => 'text/html'
    }

    response = ['<h1>Hello World</h1>', '<ol>']
    OCI.exec('select title from articles') do |r|
      r.each do |i|
        response << "<li>#{i.to_s}</li>"
      end
    end

    response << '</ol>'

    response << "<p>Running on #{RUBY_DESCRIPTION}</p>"

    time = OCI.exec('SELECT sysdate') { |r| break r[0] }
    response << "<p>SELECT sysdate: #{time}</p>"

    [200, headers, response]
  end
 end

puts "Ready!"
run App.new
