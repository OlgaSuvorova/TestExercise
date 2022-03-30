# TestExercise

About Server:
Server can be built and started by 'make run'.
Server can be available by http://localhost:8080 in your browser.
In a case of "get" request server reads the file "index.html"
Server sends "OK" responce in a case it can read this file during 50 milliseconds.
Server sends "Overload" responce in a case of impossibility to read the file during 50 milliseconds.


About Client:
Client sends one or more "get" requests to the server http://localhost:8080/. 
Sending can be performed by using the command in Erlang shell: client:send(RequestCount). RequestCount - number of requests you need to send.
Server responces are displyed on the same Erlang shell.
