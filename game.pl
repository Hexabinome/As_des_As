:- dynamic round/1.
% Load files
:- ['Game/plane'].
:- ['Game/board'].
:- ['Game/human_player'].
:- ['AI/ai_general'].
:- ['AI/ai_random'].
:- ['AI/ai_offensive'].
:- ['AI/ai_defensive'].
:- ['AI/ai_probabilistic'].
:- ['Simulation/simulation'].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				FAITS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Round counter
round(0).

		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				PREDICATS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Game loop
step :-
	% joueur 1:
	aiRandom(1), %rather defensive
	actions(1, ActionsP1),
	% joueur 2:
	aiDefensiveBest(2), %pretty aggressive
	actions(2, ActionsP2),
	%displayMoves(ActionsP1, ActionsP2), % Affichage des mouvements de chacun
	updatePlanes(ActionsP1, ActionsP2), % Execution des coups de chaque avion
	not(gameoverRound),
	%playerDisplay(1),
	%displayBoard,
	%playerDisplay(2),
	%pressToContinue,
	game.

%game :- gameover, !.
game :- incrementRoundCounter, roundDisplay, step.

% Increment the round counter
incrementRoundCounter :-
	retract(round(X)), 
	Y is X+1, 
	assert(round(Y)).

% If InIdx == 1, OutIdx == 2, else if InIdx == 2, OutIdx == 1
%Depending on the index of the first player, this function return the index of the other one : OutIdx
otherPlayer(InIdx, OutIdx) :- InIdx == 1, OutIdx is 2, !.
otherPlayer(InIdx, OutIdx) :- InIdx == 2, OutIdx is 1, !.
								
pressToContinue :- 	write('** Write any character + "." to go to the next step. **'), nl,
					read(_).
		
% Game reset

reset :-
	retract(plane(1, _, _, _, _)),
	retract(plane(2, _, _, _, _)),
	retractall(round(_)),
	assert(plane(1, 0, 0, 3, 'S')),
	assert(plane(2, 15, 15, 3, 'W')),
	assert(round(0)).
	
% ----------------------------- Server exchange section 
% Game loop

stepHttp :-
	incrementRoundCounter,
	aiDefensiveBest(1),
	actions(1, ActionsP1),
	aiRandom(2),
	actions(2, ActionsP2),
	
	retractall(actionHttp(_, _)),
	
	assert(actionHttp(1, ActionsP1)),
	assert(actionHttp(2, ActionsP2)),
	
	updatePlanesHttp(ActionsP1, ActionsP2).
	
stepHttpPlayer(list):-
	incrementRoundCounter,
	aiOffensive(2),
	actions(2, ActionsP2),
	retract(actions(1, _)),
	assert(actions(1, list)),
	updatePlanesHttp(list, ActionsP2),
	not(gameoverRound).