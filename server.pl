% server(8000). pour lancer le server
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_files)).

:- [game].

%lance le server
server(Port) :-
        http_server(http_dispatch, [port(Port)]).

%créer un handler pour le http://localhost:port/init. La méthode init est appelé
:- http_handler(root(.), homePage, []).
:- http_handler(root(initPlane), initPlane, []).
:- http_handler(root(next), next, []).
:- http_handler(root(nextPlayer), nextPlayer, []).

%todo
homePage(Request) :- 
	http_reply_from_files('/Interface/avion.html', [], Request).

initPlane(Request) :-
	reset,
	plane(1, X1, Y1, V1, D1),
	plane(2, X2, Y2, V2, D2),
    format('Content-type: text/jsonp~n~n'),
    format('updatePlane({avion1 : {x : ~w, y : ~w, v : ~w, d : "~w"}, 
						avion2 : {x : ~w, y : ~w, v : ~w, d : "~w"}} ~n)', 
						[X1, Y1, V1, D1, X2, Y2, V2, D2] ).

next(Request) :-
	stepHttp,
	plane(1, X1, Y1, V1, D1),
	plane(2, X2, Y2, V2, D2),
	actionHttp(1, Action1),
	actionHttp(2, Action2),
    format('Content-type: text/jsonp~n~n'),
    format('updatePlane({avion1 : {x : ~w, y : ~w, v : ~w, d : "~w"}, 
						avion2 : {x : ~w, y : ~w, v : ~w, d : "~w"},
						move1 : "~w",
						move2 : "~w"} ~n)', 
						[X1, Y1, V1, D1, X2, Y2, V2, D2, Action1, Action2] ).

%TODO player humain
nextPlayer(Request) :-
	http_parameters(Request,
		[ action1(action1),
		  action2(action2),
		  action3(action3)
		]),
	stepHttp,
	plane(1, X1, Y1, V1, D1),
	plane(2, X2, Y2, V2, D2),
    format('Content-type: text/jsonp~n~n'),
    format('updatePlane({avion1 : {x : ~w, y : ~w, v : ~w, d : "~w"}, 
						avion2 : {x : ~w, y : ~w, v : ~w, d : "~w"}} ~n)', 
						[X1, Y1, V1, D1, X2, Y2, V2, D2] ).

		
