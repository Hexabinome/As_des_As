% server(8000). pour lancer le server

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_cors)).

%lance le server
server(Port) :-
        http_server(http_dispatch, [port(Port)]).

%créer un handler pour le http://localhost:port/. La méthode say_hi est appelé
:- http_handler(root('test'), say_hi, []).


say_hi(Request) :-
        format('Content-type: text/plain~n~n'),
        format('coucou({ret : "Hello_World"})~n').
