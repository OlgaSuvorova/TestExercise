-module(client).

-define (TIME_TO_WAIT_RESPONCES_SEC, 3).

-export([start/0, send/1, stop/0, flush/0]).

start() ->
    inets:start().
   

send(Count) when is_integer(Count) ->
    start(),
    PidRead = spawn(client, flush, []), %create the process for reading incoming responces
    register(reading, PidRead),
    io:format("Registering the process for reading the server responces... PID = ~w \n", [PidRead]),
    send_helper(Count, Count, PidRead),
    timer:sleep(timer:seconds(?TIME_TO_WAIT_RESPONCES_SEC)), % wait for the all responces from server before stopping the client
    stop();

send(Count) ->
    io:format("Incorrect function parameter: \"~w\", it should be integer! \n", [Count]).

send_helper(StartingCount, Count, PidRead)->
    SendInfo = send_request_to_http_server(PidRead),
    io:format("Send the request #: ~w : ~w \n", [StartingCount-Count+1, SendInfo]),
    case Count-1 of
       0 -> 
            ok;
        _->
            send_helper(StartingCount, Count-1, PidRead)
    end,
    finished.

send_request_to_http_server(PidRead) ->
    {ok, _RequestId1} = httpc:request(get, {"http://localhost:8080/", []}, [], [{sync, false}, {receiver, PidRead}]).

flush() ->
    receive
        M -> 
            io:format("Got the responce ~p~n",[M])
    end,
    flush().

stop() ->
    PidRead = whereis(reading),
    io:format("Stopping the reading process with pid.. ~w\n",[PidRead]),
    exit(PidRead, finished),
    inets:stop().