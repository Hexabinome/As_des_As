var Avion = function (nom, x, y, player, orientation) {
	this.nom = nom;
	this.x = x;
	this.y = y;
	this.vie = 12;
	this.color = (player == 1) ? "vert" : "rouge";
	this.orientation = orientation;
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
	$("#" + this.nom).remove();
	position.append("<img id='" + this.nom + "' src='avion.png' class='avion " + this.orientation + "'/>");
};

Avion.prototype.supprimerCasesVertes = function() {
	$("."+this.color).removeClass( this.color );
};

Avion.prototype.afficherCasesVertes = function() {
	for (var i = 1; i < 4; i++) {
		for (var j = i; j < 4; j++) {
			var position = $("div").find("[data-x='" + (this.x + i-1) + "'][data-y='" + (this.y + i-j) + "']");
			position.addClass(this.color);

			var position = $("div").find("[data-x='" + (this.x + i-1) + "'][data-y='" + (this.y - i+j) + "']");
			position.addClass(this.color);

			var position = $("div").find("[data-x='" + (this.x - i+1) + "'][data-y='" + (this.y + i-j) + "']");
			position.addClass(this.color);

			var position = $("div").find("[data-x='" + (this.x - i+1) + "'][data-y='" + (this.y - i+j) + "']");
			position.addClass(this.color);

		};
	};
};
