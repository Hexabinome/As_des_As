var Orientation = {
  nord: 'nord',
  est: 'est',
  sud: 'sud',
  ouest: 'ouest'
}

var Avion = function (nom, x, y, player, cardinalite) {
	this.nom = nom;
	this.x = x;
	this.y = y;
	this.vie = 12;
	this.player = player;
	this.color = (player == 1) ? "vert" : "rouge";
	this.orientation = Orientation[cardinalite];
};

Avion.prototype.deplacer= function(x, y, cardinalite)
{
	this.x = x;
	this.y = y;
	this.orientation = Orientation[cardinalite];

	this.afficher();
	this.supprimerCouleurCases();
	this.afficherCouleurCases();
};

Avion.prototype.afficher = function() {
	var position = $("div").find("[data-x='" + this.x + "'][data-y='" + this.y + "']");
	var vie = $("#vie-player" + this.player);

	$("#" + this.nom).remove();
	position.append("<img id='" + this.nom + "' src='avion.png' class='avion " + this.orientation + "'/>");
	vie.html("Vie : " + this.vie);

};

Avion.prototype.supprimerCouleurCases = function() {
	$("."+this.color).removeClass( this.color );
};

Avion.prototype.afficherCouleurCases = function() {
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
