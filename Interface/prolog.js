
// ----------------------------------------  Appelle prolog et callback
//Appeller par prolog
function updatePlane(param)
{
	avion1.modifierVie(param.avion1.v);
	avion2.modifierVie(param.avion2.v);	

	console.debug(param.move1);
	console.debug(param.move2);

	console.debug((param.avion1.x+1) + ' ' + (param.avion1.y+1) + ' ' + param.avion1.d);
	console.debug((param.avion2.x+1) + ' ' + (param.avion2.y+1) + ' ' +param.avion2.d);


	if(param.move1 === undefined)
	{
		avion1.positionner((param.avion1.x+1), (param.avion1.y+1), param.avion1.d);
		avion2.positionner((param.avion2.x+1), (param.avion2.y+1), param.avion2.d);
	}
	else
	{
		avion1.deplacer(param.move1.substring(1, 3));
		avion2.deplacer(param.move2.substring(1, 3));
		
		avion1.deplacer(param.move1.substring(4, 6));
		avion2.deplacer(param.move2.substring(4, 6));
		avion1.deplacer(param.move1.substring(7, 9));
		avion2.deplacer(param.move2.substring(7, 9));
		
		//TODO à effacer quand tous fonctionnera
		timeout = setTimeout(function()
		{
			avion1.positionner((param.avion1.x+1), (param.avion1.y+1), param.avion1.d);
			avion2.positionner((param.avion2.x+1), (param.avion2.y+1), param.avion2.d);
		}, 3000);
	}

	if(avion1.vie <= 0 || avion2.vie <= 0)
	{
		score2 += (avion1.vie <= 0)?1:0;
		score1 += (avion2.vie <= 0)?1:0;

		$("#score1").text(score1);
		$("#score2").text(score2);

		clearInterval(interval);
		
		timeout = setTimeout(function()
		{
			openPopUp("popupScore");
		}, 1000);
	}
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
	$.ajax({
		url: "http://localhost:8000/next",
		type: "GET",
		dataType: "jsonp",
		success: function (data) {
			data;
		}, 
		error: function(e)
		{
			//On passe bisarement dans erreur même quand on a un http 200
			if(e.status != 200)
				clearInterval(interval);
		}
	});
}

//Fonction appellant le prolog. Le callback est sur planeState
function appelerPrologWithParam(param)
{
	//TODO
}
