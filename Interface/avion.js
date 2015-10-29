var Avion = function (nom, x, y, player, orientation) {
	this.nom = nom;
	this.x = x;
	this.y = y;
	this.vie = 0;
	this.modifierVie(12);
	this.color = (player == 1) ? "vert" : "rouge";
	this.orientation = orientation;
};

Avion.prototype.positionner= function(x, y, orientation)
{
	this.x = x;
	this.y = y;
	this.orientation = orientation; 
	
	this.afficher();
};

Avion.prototype.deplacer= function(move)
{
	switch(move)
	{
		case "FF":
			switch(this.orientation)
			{
				case 'N':
					this.moveTop();
					this.moveTop();
					break;
				case 'W':
					this.moveLeft();
					this.moveLeft();
					break;
				case 'E':
					this.moveRight();
					this.moveRight();
					break;
				case 'S':
					this.moveBottom();
					this.moveBottom();
					break;
			}
			break;
		case "F":
			switch(this.orientation)
			{
				case 'N':
					this.moveTop();
					break;
				case 'W':
					this.moveLeft();
					break;
				case 'E':
					this.moveRight();
					break;
				case 'S':
					this.moveBottom();
					break;
			}
			break;
		case "RT":
			this.deplacer('F');
			this.rotate(1);
			this.deplacer('F');
			break;
		case "LT":
			this.deplacer('F');
			this.rotate(-1);
			this.deplacer('F');
			break;
		case "UT":
			this.rotate(2);
			break;
	}
};

Avion.prototype.modifierVie= function(vie)
{
	this.vie = vie;
	$("#vie_"+ this.nom).text(vie);
};

Avion.prototype.afficher = function() {
	var position = $("div").find("[data-x='" + this.x + "'][data-y='" + this.y + "']");

	$("#" + this.nom).remove();
	position.append("<img id='" + this.nom + "' src='avion.png' class='avion " + this.orientation + "'/>");
};

Avion.prototype.moveRight = function() {
	$("#" + this.nom).animate({ "right": "-=" + ($("div").find("[data-x='1'][data-y='1']").height() + 2.7) }, "fast" );
};

Avion.prototype.moveLeft = function() {
	$("#" + this.nom).animate({ "right": "+=" + ($("div").find("[data-x='1'][data-y='1']").height() + 2.7) }, "fast" );
};

Avion.prototype.moveTop = function() {
	$("#" + this.nom).animate({ "top": "-=" + ($("div").find("[data-x='1'][data-y='1']").height() + 2.7) }, "fast" );
};

Avion.prototype.moveBottom = function() {
	$("#" + this.nom).animate({ "top": "+=" + ($("div").find("[data-x='1'][data-y='1']").height() + 2.7) }, "fast" );
};

Avion.prototype.rotate = function(direction) {  
	var degree;
	var toDegree;
	var nom = this.nom;
	if(direction === 2)
	{
		switch(this.orientation)
		{
			case 'N':
				degree = 0;
				toDegree = 180;
				direction = 1;
				this.orientation = 'S';
				break;
			case 'W':
				degree = 270;
				toDegree = 90;
				direction = -1;
				this.orientation = 'E';
				break;
			case 'S':
				degree = 180;
				toDegree = 0;
				direction = -1;
				this.orientation = 'N';
				break;
			case 'E':
				degree = 90;
				toDegree = 270;
				direction = 1;
				this.orientation = 'W';
				break;
		}
	}
	else
	{
		switch(this.orientation)
		{
			case 'N':
				degree = 0;
				toDegree = direction*90;
				this.orientation = (direction === 1)?'E':'W';
				break;
			case 'W':
				degree = 270;
				toDegree = 270 + direction*90;
				this.orientation = (direction === 1)?'N':'S';
				break;
			case 'S':
				degree = 180;
				toDegree = 180 + direction*90;
				this.orientation = (direction === 1)?'W':'E';
				break;
			case 'E':
				degree = 90;
				toDegree = 90 + direction*90;
				this.orientation = (direction === 1)?'S':'N';
				break;
		}

	}
	
    var timer = setInterval(function() {
        degree += direction; 

	    $("#" + nom).css({ WebkitTransform: 'rotate(' + degree + 'deg)'});  
	    $("#" + nom).css({ '-moz-transform': 'rotate(' + degree + 'deg)'});
	    
	    if(degree === toDegree)
	    	clearInterval(timer);
    },1);
}