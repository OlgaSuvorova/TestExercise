{application, 'server', [
	{description, "New project"},
	{vsn, "0.1.0"},
	{modules, ['server_app','server_handler','server_sup']},
	{registered, [server_sup]},
	{applications, [kernel,stdlib,cowboy]},
	{mod, {server_app, []}},
	{env, []}
]}.