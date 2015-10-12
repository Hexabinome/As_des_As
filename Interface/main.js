var avion1;
var avion2;

function init()
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

function coucou(res)
{
	console.debug(res);
}

function appelerProlog()
{
	console.debug("coucou");
	//TODO trouver un moyen d'utiliser cors
	$.ajax({
		url: "http://localhost:8000/test",
		type: "GET",
		dataType: "jsonp",
		success: function (data) {
			data;
		}
	});
}

$(function() {
	init();
    avion1 = new Avion('avions1', 3, 3, 1);
    avion1.deplacer(3, 3);

    avion2 = new Avion('avions2', 5, 5, 2);
    avion2.deplacer(5, 5);

    setInterval(appelerProlog, 2000);
    //appelerProlog();
});