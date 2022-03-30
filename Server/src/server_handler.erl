-module(server_handler).
-behavior(cowboy_handler).

-export([init/2, reading/1]).

-define (OVERLOAD_TIMEOUT_MSEC, 50).

init(Req0, State) ->
	Reading_Pid = spawn_link(server_handler, reading, [self()]),
	Req = 
	receive
        {_, finished} -> 
			cowboy_req:reply(200,
			#{<<"content-type">> => <<"text/plain">>},
			<<"OK">>,
			Req0)
    after ?OVERLOAD_TIMEOUT_MSEC ->
		exit(Reading_Pid, overload),
        cowboy_req:reply(503,
			#{<<"content-type">> => <<"text/plain">>},
			<<"Overload">>,
			Req0)
	end,
	{ok, Req, State}.

reading(Parent_Pid) ->
	File1 = readlines("index.html"),
	io:format("Reading file... ~w \n\n\n", [File1]),
	case File1 of
		error ->
			error;
		_->	
			Parent_Pid ! {self(), finished}
	end.

readlines(FileName) ->
	case file:open(FileName, [read]) of
    	{ok, Device} ->
			 try get_all_lines(Device)
      			 after file:close(Device)
    		   end;
		{_, _}  ->
			io:format("Can not read file !!!\n "),
			error
	end.

get_all_lines(Device) ->
    case io:get_line(Device, "") of
        eof  -> [];
        Line -> Line ++ get_all_lines(Device)
    end.