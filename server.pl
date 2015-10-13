% server(8000). pour lancer le server

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).

%lance le server
server(Port) :-
        http_server(http_dispatch, [port(Port)]).

%créer un handler pour le http://localhost:port/. La méthode say_hi est appelé
:- http_handler(root('.'), say_hi, []).


say_hi(Request) :-
		%http_parameters(Request,
		%	[ title(Title, [ optional(true) ]),
		%	  name(Name,   [ length >= 2 ]),
		%	  age(Age,     [ between(0, 150) ])
		%	]),
        format('Content-type: text/jsonp~n~n'),
        format(' coucou({ret : "~w"}) ~n', ['Hello toi']).

