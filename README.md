# TestExercise

About Server:
Server can be builded and started by 'make run'.\n
Server can be available by http://localhost:8080 in your browser.\n 
In a case of "get" request server reads the file "index.html".\n
Server sends "OK" responce in a case it can read this file during 50 milliseconds.\n 
Server sends "Overload" responce in a case of impossibility to read the file during 50 milliseconds.\n


About Client:
Client sends one or more "get" requests to the server http://localhost:8080/. 
Sending can be performed by using the command in Erlang shell: client:send(IntegerNumber). IntegerNumber - number of requests you need to send.
Server responces are displyed on the same Erlang shell.
