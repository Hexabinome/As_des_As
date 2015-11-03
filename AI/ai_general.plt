:- use_module(ai_general).

:- begin_tests(testsAiGeneral).

test(aiGeneralCoupleActions) :-
	findall(OneAction, coupleAction(OneAction, _), Actions),
	length(Actions, NbAction),
	assertion(NbAction == 25)
	.
	
:- end_tests(testsAiGeneral).
