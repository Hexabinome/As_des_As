var avion;

function init()
{
	$(".carre").bind("click", function(e)
	{
		if($(this).hasClass("vert"))
		{
			//TODO appeler le prolog
			avion.deplacer($(this).data("x"), $(this).data("y"));

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
    avion = new Avion('avions1', 5, 5);
    avion.deplacer(5, 5);

    setInterval(appelerProlog, 2000);
    //appelerProlog();
});