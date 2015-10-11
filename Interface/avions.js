var Avion = function (nom, x, y) {
	this.nom = nom;
	this.x = x;
	this.y = y;
	this.vie = 12;
};

Avion.prototype.deplacer= function(x, y)
{
	this.x = x;
	this.y = y;

	this.afficher();
	this.supprimerCasesVertes();
	this.afficherCasesVertes();
};

Avion.prototype.afficher = function() {
	var position = $("div").find("[data-x='" + this.x + "'][data-y='" + this.y + "']");

	//TODO remplacer par l'affichage de l'avions
	$(".avion").remove();
	position.append("<img id='avion' src='avion.png' class='avion'/>");
};

Avion.prototype.supprimerCasesVertes = function() {
	$(".vert").removeClass("vert");
};

Avion.prototype.afficherCasesVertes = function() {
	for (var i = 1; i < 4; i++) {
		for (var j = i; j < 4; j++) {
			var position = $("div").find("[data-x='" + (this.x + i-1) + "'][data-y='" + (this.y + i-j) + "']");

			position.addClass("vert");
			
			var position = $("div").find("[data-x='" + (this.x + i-1) + "'][data-y='" + (this.y - i+j) + "']");

			position.addClass("vert");

			var position = $("div").find("[data-x='" + (this.x - i+1) + "'][data-y='" + (this.y + i-j) + "']");

			position.addClass("vert");
			
			var position = $("div").find("[data-x='" + (this.x - i+1) + "'][data-y='" + (this.y - i+j) + "']");

			position.addClass("vert");
			
		};
	};
};
