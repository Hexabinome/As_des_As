var Avion = function (nom, x, y, player, orientation) {
	this.nom = nom;
	this.player = player;
	this.x = x;
	this.y = y;
	this.vie = 0;
	this.modifierVie(3);
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

Avion.prototype.debug_ihm = function() {
	$("#debug_" + this.nom + "_nom").remove();
	$("#debug_" + this.nom + "_x").remove();
	$("#debug_" + this.nom + "_y").remove();
	$("#debug_" + this.nom + "_orientation").remove();


	$("#debug_" + this.nom ).append(
	 "<div class='col-xs-3' id='debug_" + this.nom+ "_nom' > Avion " + this.player+ ": </div>"
	+	"<div class='col-xs-2 ' id='debug_" + this.nom + "_x'> x : " + this.x + "</div>"
	+ "<div class='col-xs-2 ' id='debug_" + this.nom + "_y'> y : " + this.y + "</div>"
	+ "<div class='col-xs-5 ' id='debug_" + this.nom + "_orientation'> orientation : " + this.orientation + "</div>");
};

Avion.prototype.testSortie = function()
{
	
	if(this.x < 1 || this.x > 16 || this.y < 1 || this.x > 16)
		return false;
	return true;
};

// ============================================================================================DEPLACEMENT
Avion.prototype.deplacer= function(move)
{
  var def = $.Deferred();
	var $this = this;

	switch(move)
	{
		case "FF":
			switch($this.orientation)
			{
				case 'N':
					$this.moveTop();
					$this.moveTop();
					$this.y -=2;
					def.resolve();
					break;
				case 'W':
					$this.moveLeft();
					$this.moveLeft();
					$this.x -=2;
					def.resolve();

					break;
				case 'E':
					$this.moveRight();
					$this.moveRight();
					$this.x +=2;
					def.resolve();

					break;
				case 'S':
					$this.moveBottom();
					$this.moveBottom();
					$this.y +=2;
					def.resolve();

					break;
			}
			break;
		case "F":
			switch($this.orientation)
			{
				case 'N':
					$this.moveTop();
					$this.y -=1;
					def.resolve();
					break;
				case 'W':
					$this.moveLeft();
					$this.x -=1;
					def.resolve();
					break;
				case 'E':
					$this.moveRight();
					$this.x +=1;
					def.resolve();
					break;
				case 'S':
					$this.moveBottom();
					$this.y +=1;
					def.resolve();
					break;
			}
			break;
		case "RT":
			$this.deplacer('F').then(function() {
				$this.rotate(1)
					.then(function() {
						$this.deplacer('F');
						def.resolve();
					});
			});
			break;
		case "LT":
			$this.deplacer('F').then(function() {
				$this.rotate(-1)
					.then(function() {
						$this.deplacer('F');
						def.resolve();
					});
			});
			break;
		case "UT":
			$this.rotate(2).then(function()
			{
				def.resolve();
			});
			break;
	}

	return def.promise();
};

Avion.prototype.modifierVie= function(vie)
{
	this.vie = vie;
	$("#vie_"+ this.nom).text(vie);
};

Avion.prototype.afficher = function() {
	var position = $("div").find("[data-x='" + this.x + "'][data-y='" + this.y + "']");

	$("#" + this.nom).remove();
	position.append("<img id='" + this.nom + "' src='image/" + this.nom + ".png' class='avion " + this.orientation + "'/>");
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
  	var def = $.Deferred();
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
        degree += direction * 2 ;

	    $("#" + nom).css({ WebkitTransform: 'rotate(' + degree + 'deg)'});
	    $("#" + nom).css({ '-moz-transform': 'rotate(' + degree + 'deg)'});

	    if(degree === toDegree)
	    {
    		clearInterval(timer);
    		def.resolve();
	    }
    },10);

  	return def.promise();
};

// =========================================================================================== TIRE

Avion.prototype.tentativeDeTir= function(avion)
{
	var distance;
	var testEnLigne;
	var def = $.Deferred();

	switch(this.orientation){
		case 'N':
			distance = this.y - avion.y;
			testEnLigne = (this.x - avion.x === 0);
			break;
		case 'S':
			distance = avion.y - this.y;
			testEnLigne = (this.x - avion.x === 0);
			break;
		case 'E':
			distance = avion.x - this.x;
			testEnLigne = (avion.y - this.y === 0);
			break;
		case 'W':
			distance = this.x - avion.x;
			testEnLigne = (avion.y - this.y === 0);
			break;
	}

	if ( (distance < 5) && (distance >= 0) && testEnLigne)
	{
		avion.modifierVie(avion.vie-1);
		this.tirer(distance).then(function() {
			def.resolve();
		});
	}
	else
	{
		def.resolve();
	}
	return def.promise();
};

Avion.prototype.tirer= function(distance)
{
	//Because this will change in then(function)
	var $this = this;
	var def = $.Deferred();

	var deplacement = Math.round(($("div").find("[data-x='1'][data-y='1']").height()) * distance);

	var x = this.x;
	var y = this.y;
	var i = 1;

	$this.afficherTir();

	switch(this.orientation){
		case 'N':
			$("#bullet").animate({ "top" : "-=" +  deplacement}, "slow", function(){
				$this.supprimerTir();
				y -= distance;

				var inter = setInterval(function(){
					$("#explotion").remove();
					$("div").find("[data-x='" + x + "'][data-y='" + y + "']").append("<img id='explotion' src='image/boum" + i + ".png' class='explotion'/>");

					if(++i === 6)
					{
						$("#explotion").remove();
						clearInterval(inter);
						def.resolve();
					}
				}, 50);
			});
			break;
		case 'W':
			$("#bullet").animate({ "right" : "+=" + deplacement }, "slow", function(){
				$this.supprimerTir();
				direction = "right : ";
				x -= distance;

				var inter = setInterval(function(){
					$("#explotion").remove();
					$("div").find("[data-x='" + x + "'][data-y='" + y + "']").append("<img id='explotion' src='image/boum" + i + ".png' class='explotion'/>");

					if(++i === 6)
					{
						$("#explotion").remove();
						clearInterval(inter);
						def.resolve();
					}
				}, 50);
			});
			break;
		case 'E':
			$("#bullet").animate({ "right" : "-=" + deplacement }, "slow", function(){
				$this.supprimerTir();
				direction = "right : -";
				x += distance;

				var inter = setInterval(function(){
					$("#explotion").remove();
					$("div").find("[data-x='" + x + "'][data-y='" + y + "']").append("<img id='explotion' src='image/boum" + i + ".png' class='explotion'/>");

					if(++i === 6)
					{
						$("#explotion").remove();
						clearInterval(inter);
						def.resolve();
					}
				}, 50);
			});
			break;
		case 'S':
			$("#bullet").animate({ "top" : "+=" + deplacement }, "slow", function(){
				$this.supprimerTir();
				direction = "top : ";
				y += distance;

				var inter = setInterval(function(){
					$("#explotion").remove();
					$("div").find("[data-x='" + x + "'][data-y='" + y + "']").append("<img id='explotion' src='image/boum" + i + ".png' class='explotion'/>");

					if(++i === 6)
					{
						$("#explotion").remove();
						clearInterval(inter);
						def.resolve();
					}
				}, 50);

			});
			break;
	}


	return def.promise();
};

Avion.prototype.afficherTir = function() {
	$("div").find("[data-x='" + this.x + "'][data-y='" + this.y + "']").append("<img id='bullet' src='image/missile.png' class='missile " + this.orientation + "'/>");
};

Avion.prototype.supprimerTir= function()
{
	$("#bullet").remove();
};