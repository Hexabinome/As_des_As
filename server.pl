% server(8000). pour lancer le server

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).

:- [game].


%lance le server
server(Port) :-
        http_server(http_dispatch, [port(Port)]).

%créer un handler pour le http://localhost:port/. La méthode say_hi est appelé
:- http_handler('/test', say_hi, []).

%indexPage(Request):- 
%	http_reply_from_files('C:\\Temp\\As_des_As\\Interface\\avion.html', [], Request).

say_hi(Request) :-
		%http_parameters(Request,
		%	[ title(Title, [ optional(true) ]),
		%	  name(Name,   [ length >= 2 ]),
		%	  age(Age,     [ between(0, 150) ])
		%	]),
		plane(1, X1, Y1, V1, D1),
		plane(2, X2, Y2, V2, D2),
        format('Content-type: text/jsonp~n~n'),
        format('planeState({avion1 : {x : ~w, y : ~w, v : ~w, d : "~w"}, 
							avion2 : {x : ~w, y : ~w, v : ~w, d : "~w"}}) ~n', [X1, Y1, V1, D1, X2, Y2, V2, D2] ).

