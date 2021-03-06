//Ouvre la popup
function openPopUp(popupID)
{
	var popID;
	if(popupID === undefined)
		popID = "popup";
	else
		popID = popupID;

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

}

function closePopUp()
{
	$('#fade , .popup_block').fadeOut(function() {
		$('#fade, a.close').remove();
	});
};

//nerver used
function disablePlayButton()
{
	$('#Play').removeClass('btn-primary').addClass('btn-default').addClass('disabled');
};

function enableAutoButton(){
	$('#Auto').removeClass('hide');
};

function enableIaPlayButton()
{
	$('#Play').removeClass('disabled').addClass('btn-primary').removeClass('btn-default');
};

function enableHumanPlayButton()
{
	$('#Play').removeClass('disabled').addClass('btn-primary').removeClass('btn-default');
};

function viderActionFaites()
{
	for(var i = 0; i <3; i++)
	{
		$("#action_" + i).html('');
	}
};