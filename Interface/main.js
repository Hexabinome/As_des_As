var avion1;
var avion2;
var boolPlayer = false;
var counter;

function init()
{
	openPopUp();
	$('#Jouer').prop('disabled', true);
	boolPlayer = false;
	
	//TODO se metre d'accord sur les positions de base avec prolog
	avion1 = new Avion('avion1', 3, 3, 1, 'sud');
	avion2 = new Avion('avion2', 5, 5, 2, 'est');
}

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

function bindClickAction()
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
}
function bindKeyAction()
{
	counter = 2;
	$(document).keypress(function( event ) {
		if(boolPlayer)
		{
			//up
			if ( event.keyCode == 38 ) {
				event.preventDefault();
				counter++;
				$("#action_" + counter%3).html('<span class="glyphicon glyphicon-arrow-up"></span>');
			}
			//down
			else if ( event.keyCode == 40 ) {
				event.preventDefault();
				counter++;
				$("#action_" + counter%3).html('<span class="glyphicon glyphicon-arrow-down"></span>');
			}
			//right
			else if ( event.keyCode == 39 ) {
				event.preventDefault();
				counter++;
				$("#action_" + counter%3).html('<span class="glyphicon glyphicon-arrow-right"></span>');
			}
			//left
			else if ( event.keyCode == 37 ) {
				event.preventDefault();
				counter++;
				$("#action_" + counter%3).html('<span class="glyphicon glyphicon-arrow-left"></span>');
			}
			//space
			else if ( event.charCode == 32 ) {
				event.preventDefault();
			}
		}
	});
}

function planeState(param)
{
	avion1.deplacer(param.avion1.x, param.avion1.y, param.avion1.d);
	avion1.modifierVie(param.avion1.v);
	
	avion2.deplacer(param.avion2.x, param.avion2.y, param.avion2.d);
	avion2.modifierVie(param.avion2.v);	
}

function appelerProlog()
{
	$.ajax({
		url: "http://localhost:8000/test",
		type: "GET",
		dataType: "jsonp",
		success: function (data) {
			data;
		}
	});
}

function closePopUp()
{
	$('#fade , .popup_block').fadeOut(function() {
		$('#fade, a.close').remove();  
	});
}

$(function() {
	/* Initialisation des handler*/
	
	$("#PvVIa").bind('click', function() {
		closePopUp();
		$('#Jouer').prop('disabled', false);
		
		boolPlayer = true;
		
		avion1.deplacer(3, 3);
		avion2.deplacer(5, 5);
		
	});
	
	$("#IaVsIa").bind('click', function() {
		closePopUp();
		
		avion1.deplacer(3, 3);
		avion2.deplacer(5, 5);
		
		//setInterval(appelerProlog, 2000);
		appelerProlog();
	});
	
	$("#Play").bind('click', function() {
		
		//setInterval(appelerProlog, 2000);
		appelerProlog();
	});
	
	$("#Reset").bind('click', function() {
		init();
	});
	
	init();
	bindClickAction();
	bindKeyAction();
    
});