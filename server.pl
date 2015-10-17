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

%indexPage(Request):- 
%	http_reply_from_files('C:\\Temp\\As_des_As\\Interface\\avion.html', [], Request).

%todo
homePage(Request) :- 
	http_reply_from_files('/Interface/avion.html', [], Request).

initPlane(Request) :-
	plane(1, X1, Y1, V1, D1),
	plane(2, X2, Y2, V2, D2),
    format('Content-type: text/jsonp~n~n'),
    format('initPlane({avion1 : {x : ~w, y : ~w, v : ~w, d : "~w"}, 
						avion2 : {x : ~w, y : ~w, v : ~w, d : "~w"}} ~n)', [X1, Y1, V1, D1, X2, Y2, V2, D2] ).

next(Request) :-
	stepHttp,
	plane(1, X1, Y1, V1, D1),
	plane(2, X2, Y2, V2, D2),
    format('Content-type: text/jsonp~n~n'),
    format('initPlane({avion1 : {x : ~w, y : ~w, v : ~w, d : "~w"}, 
						avion2 : {x : ~w, y : ~w, v : ~w, d : "~w"}} ~n)', [X1, Y1, V1, D1, X2, Y2, V2, D2] ).



		%http_parameters(Request,
		%	[ title(Title, [ optional(true) ]),
		%	  name(Name,   [ length >= 2 ]),
		%	  age(Age,     [ between(0, 150) ])
		%	]),
