% server(8000). pour lancer le server
:- use_module(library('http/thread_httpd')).
:- use_module(library('http/http_dispatch')).
:- use_module(library('http/http_files')).
:- use_module(library('http/http_parameters')).

:- use_module('game').

%lance le server
server(Port) :-
        http_server(http_dispatch, [port(Port)]).

%créer un handler pour le http://localhost:port/init. La méthode init est appelé
:- http_handler(root(.), homePage, []).
:- http_handler(root(initPlane), initPlane, []).
:- http_handler(root(next), next, []).
:- http_handler(root(nextPlayer), nextPlayer, []).
:- http_handler(root(definePlayer), definePlayer, []).

%todo
homePage(Request) :- 
	http_reply_from_files('/Interface/avion.html', [], Request).

initPlane(Request) :-
	game:reset,
	plane:plane(1, X1, Y1, V1, D1),
	plane:plane(2, X2, Y2, V2, D2),
    format('Content-type: text/jsonp~n~n'),
    format('updatePlane({avion1 : {x : ~w, y : ~w, v : ~w, d : "~w"}, 
						avion2 : {x : ~w, y : ~w, v : ~w, d : "~w"}} ~n)', 
						[X1, Y1, V1, D1, X2, Y2, V2, D2] ).

next(Request) :-
	game:stepHttp,
	plane:plane(1, X1, Y1, V1, D1),
	plane:plane(2, X2, Y2, V2, D2),
	game:actionHttp(1, Action1),
	game:actionHttp(2, Action2),
    format('Content-type: text/jsonp~n~n'),
    format('updatePlane({avion1 : {x : ~w, y : ~w, v : ~w, d : "~w"}, 
						avion2 : {x : ~w, y : ~w, v : ~w, d : "~w"},
						move1 : "~w",
						move2 : "~w"} ~n)', 
						[X1, Y1, V1, D1, X2, Y2, V2, D2, Action1, Action2] ).

%TODO player humain
nextPlayer(Request) :-
	http_parameters(Request, 
		[ act1(Act1, []),
		  act2(Act2, []),
		  act3(Act3, [])
		]),
	game:stepHttpPlayer([Act1, Act2, Act3]),
	plane:plane(1, X1, Y1, V1, D1),
	plane:plane(2, X2, Y2, V2, D2),
	game:actionHttp(1, Action1),
	game:actionHttp(2, Action2),
    format('Content-type: text/jsonp~n~n'),
    format('updatePlane({avion1 : {x : ~w, y : ~w, v : ~w, d : "~w"}, 
						avion2 : {x : ~w, y : ~w, v : ~w, d : "~w"},
						move1 : "~w",
						move2 : "~w"} ~n)', 
						[X1, Y1, V1, D1, X2, Y2, V2, D2, Action1, Action2] ).

definePlayer(Request) :-
	http_parameters(Request, [	player(Pl, []),
								value(Val, [])
							]),
	selectPlayer(Pl, Val),
	format('Content-type: text/jsonp~n~n'),
    format('test()').
