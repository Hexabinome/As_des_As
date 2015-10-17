var avion1;
var avion2;
var boolPlayer = false;
var counter;
var tabActionUser = [];

$(function() {
	init();
	bindClick();
	bindKeyAction();
    
});

//Initialisation de divers paramètres.
function init()
{
	openPopUp();
	$('#Jouer').prop('disabled', true);
	boolPlayer = false;
	
	//TODO se metre d'accord sur les positions de base avec prolog
	avion1 = new Avion('avion1', 3, 3, 1, 'sud');
	avion2 = new Avion('avion2', 5, 5, 2, 'est');
}

//Ouvre la popup
function openPopUp()
{
	var popID = "popup";
	var popWidth = 500;
	
	$('#' + popID).fadeIn().css({ 'width': popWidth}).prepend('<a href="#" class="close"><span class=" glyphicon glyphicon-remove"></span></a>');
		
	//Récupération du margin, qui permettra de centrer la fenêtre - on ajuste de 80px en conformité avec le CSS
	var popMargTop = ($('#' + popID).height() + 80) / 2;
	var popMargLeft = ($('#' + popID).width() + 80) / 2;
	
	//Apply Margin to Popup
	$('#' + popID).css({ 
		'margin-top' : -popMargTop,
		'margin-left' : -popMargLeft
	});
	
	//Apparition du fond - .css({'filter' : 'alpha(opacity=80)'}) pour corriger les bogues d'anciennes versions de IE
	$('body').append('<div id="fade"></div>');
	$('#fade').css({'filter' : 'alpha(opacity=80)'}).fadeIn();
	
	$('body').on('click', 'a.close, #fade', function() { //Au clic sur le body...
		closePopUp();
	});
}

function closePopUp()
{
	$('#fade , .popup_block').fadeOut(function() {
		$('#fade, a.close').remove();  
	});
}

//Gestion de la toltips sur le bouton play lorsque le joueur n'a pas fait aux moins trois action
$(function() {
	$('#Play').popover({
	    html: true,
	    content: 'Select at least 3 actions to realize',
	});
});

function viderActionFaites()
{
	for(var i = 0; i <3; i++)
	{
		$("#action_" + i).html('');
	}	
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

//TODO a supprimer si plus utile
function bindClick()
{
	$(".carre").bind("click", function(e)
	{
		if($(this).hasClass("vert"))
		{
			//TODO appeler le prolog
			avion1.deplacer($(this).data("x"), $(this).data("y"));
		}
		if($(this).hasClass("rouge"))
		{
			//TODO appeler le prolog
			avion2.deplacer($(this).data("x"), $(this).data("y"));
		}
	});

	$("#PvVIa").bind('click', function() {
		closePopUp();
		$('#Jouer').prop('disabled', false);
		
		boolPlayer = true;
		
		initPlaneProlog();
	});
	
	$("#IaVsIa").bind('click', function() {
		closePopUp();
		
		initPlaneProlog();
		
		setInterval(nextProlog, 1000 * 1 );
	});
	
	$("#Play").bind('click', function(e) 
	{
		e.stopPropagation();
		console.debug(tabActionUser.length);
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
			$("#Play").popover('enable');
			$("#Play").popover('show');
		}
		appelerProlog();
	});
	
	$("#Reset").bind('click', function() {
		init();
	});
}

// ----------------------------------------  Appelle prolog et callback
//Appeller par prolog
function initPlane(param)
{
	console.debug(param);
	avion1.deplacer((param.avion1.x+1), (param.avion1.y+1), param.avion1.d);
	avion1.modifierVie(param.avion1.v);
	
	avion2.deplacer((param.avion2.x+1), (param.avion2.y+1), param.avion2.d);
	avion2.modifierVie(param.avion2.v);	
}


//Function appellant le prolog. Le callback est sur planeState
function initPlaneProlog()
{
	$.ajax({
		url: "http://localhost:8000/initPlane",
		type: "GET",
		dataType: "jsonp",
		success: function (data) {
			data;
		}
	});
}

function nextProlog()
{
	console.debug('ho');
	$.ajax({
		url: "http://localhost:8000/next",
		type: "GET",
		dataType: "jsonp",
		success: function (data) {
			data;
		}
	});
}

//Fonction appellant le prolog. Le callback est sur planeState
function appelerPrologWithParam(param)
{
	//TODO
}

