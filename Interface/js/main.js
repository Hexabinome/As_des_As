var avion1;
var avion2;

var boolPlayer = false;
var counter;

var tabActionUser = [];
var interval; 

var score1 = 0;
var score2 = 0;

$(function() {
	init();
	bindClick();
	bindKeyAction();

	//Gestion de la toltips sur le bouton play lorsque le joueur n'a pas fait aux moins trois action
    $('#Play').popover({
	    html: true,
	    content: 'Select at least 3 actions to realize',
	});
});

//Initialisation de divers paramètres.
function init()
{
	//TODO se metre d'accord sur les positions de base avec prolog
	avion1 = new Avion('avion1', 3, 3, 1, 'sud');
	avion2 = new Avion('avion2', 5, 5, 2, 'est');

	initPlaneProlog();

	openPopUp();
	disablePlayButton();
	boolPlayer = false;
}

//---------------------------------- Bind js 
//Bind les divers actions à réaliser sur l'évenement clique
function bindKeyAction()
{
	//initialiser à 2 car ++ puis % 3 pour la première action
	counter = 2;
	$(document).keypress(function( event ) {
		if(boolPlayer)
		{
			//up
			if ( event.keyCode == 38 ) {
				event.preventDefault();
				counter++;
				$("#action_" + counter%3).html('<i class="glyphicon glyphicon-arrow-up"></i>');

				tabActionUser.push("F");
			}
			//down
			else if ( event.keyCode == 40 ) {
				event.preventDefault();
				counter++;
				$("#action_" + counter%3).html('<i class="glyphicon glyphicon-arrow-down"></i>');

				tabActionUser.push("UT");
			}
			//right
			else if ( event.keyCode == 39 ) {
				event.preventDefault();
				counter++;
				$("#action_" + counter%3).html('<i class="glyphicon glyphicon-arrow-right"></i>');

				tabActionUser.push("RT");
			}
			//left
			else if ( event.keyCode == 37 ) {
				event.preventDefault();
				counter++;
				$("#action_" + counter%3).html('<i class="glyphicon glyphicon-arrow-left"></i>');

				tabActionUser.push("LT");
			}
			//space
			else if ( event.charCode == 32 ) {
				event.preventDefault();
				counter++;
				$("#action_" + counter%3).html('<i class="glyphicon glyphicon-backward icon-flipped"></i>');

				tabActionUser.push("FF");
			}
		}
	});
}

function bindClick()
{
	$("#PlVsIa").bind('click', function() {
		closePopUp();
		enablePlayButton();
		
		boolPlayer = true;
	});
	
	$("#startGame").bind('click', function() {
		var p1 = $("#player1Choice").val();
		var p2 = $("#player2Choice").val();
		
		if (p1 == -1) { // Human player
			boolPlayer = true;
		}
		else {
			boolPlayer = false;
			definiJoueur(1, p1);
		}
		definiJoueur(2, p2);
		
		enablePlayButton();
		closePopUp();
	});
	
	$("#IaVsIa").bind('click', function() {
		closePopUp();
		
		//nextProlog();

		//interval = setInterval(nextProlog, 1000 * 3);
	});
	
	$("#Play").bind('click', function(e) 
	{
		e.stopPropagation();

		if(tabActionUser.length >=3)
		{
			$("#Play").popover('disable');
			//récupère les trois dernières action faites
			var action = tabActionUser.slice(tabActionUser.length - 3, tabActionUser.length);
			tabActionUser = [];
			viderActionFaites();
			
			appelerPrologWithParam(action);
		}
		else
		{
			$("#Play").popover('enable').popover('show');
		}
	});
	
	$("#Reset").bind('click', function() {
		init();
	});
	
	$("#PlayAgain").bind('click', function() {
		closePopUp();
		init();
	});
}

