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

Avion.prototype.debug_ihm = function() {
	$("#debug_" + this.nom + "_nom").remove();
	$("#debug_" + this.nom + "_x").remove();
	$("#debug_" + this.nom + "_y").remove();
	$("#debug_" + this.nom + "_orientation").remove();


	$("#debug_" + this.nom ).append(
	 "<div class='col-xs-3' id='debug_" + this.nom+ "_nom' > Avion 1: </div>"
	+	"<div class='col-xs-2 ' id='debug_" + this.nom + "_x'> x : " + this.x + "</div>"
	+ "<div class='col-xs-2 ' id='debug_" + this.nom + "_y'> y : " + this.y + "</div>"
	+ "<div class='col-xs-5 ' id='debug_" + this.nom + "_orientation'> orientation : " + this.orientation + "</div>");
};

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

Avion.prototype.tentativeDeTir= function(avion)
{
	var distance;
	var testEnLigne;
	switch(this.orientation){
		case 'N':
			distance = this.y - avion.y;
			testEnLigne = this.x - avion.x;
			break;
		case 'S':
			distance = avion.y - this.y;
			testEnLigne = this.x - avion.x;
			break;
		case 'E':
			distance = avion.x - this.x;
			testEnLigne = avion.y - this.y;
			break;
		case 'W':
			distance = this.x - avion.x;
			testEnLigne = avion.y - this.y;
			break;
	}
	//console.debug(this.nom + ' ' + distance);
	if ( (distance < 5) && (distance > 0) && (testEnLigne === 0) )
	{
		this.tirer(distance);
	}
};

Avion.prototype.tirer= function(distance)
{
	//Because this will change in then(function)
	var $this = this;

	var def = $.Deferred();
	$this.afficherTir().then(function() {
		$this.deplacerTir(distance)
			.then(function() {
				 $this.supprimerTir();
				def.resolve();
		});
	});
	return def.promise();
};

Avion.prototype.afficherTir = function() {
	var def = $.Deferred();
	$("div").find("[data-x='" + this.x + "'][data-y='" + this.y + "']").append("<img id='bullet' src='bullet.png' class='avion " + this.orientation + "'/>");
	def.resolve();
	return def.promise();
};

Avion.prototype.deplacerTir = function(distance) {
	var def = $.Deferred();

	var direction = '';
	var operation = '';

	switch(this.orientation){
		case 'N':
			toTest = "top";
			signe = "-";
			$("#bullet").animate({ "top" : "-=" + ($("div").find("[data-x='1'][data-y='1']").height() + 2.7) * distance }, "fast" );
			break;
		case 'W':
			toTest = "right";
			signe = "";
			$("#bullet").animate({ "right" : "+=" + ($("div").find("[data-x='1'][data-y='1']").height() + 2.7) * distance }, "fast" );
			break;
		case 'E':
			toTest = "right";
			signe = "-";
			$("#bullet").animate({ "right" : "-=" + ($("div").find("[data-x='1'][data-y='1']").height() + 2.7) * distance }, "fast" );
			break;
		case 'S':
			toTest = "top";
			signe = "";
			$("#bullet").animate({ "top" : "+=" + ($("div").find("[data-x='1'][data-y='1']").height() + 2.7) * distance }, "fast" );
			break;
	}


  var timer = setInterval(function() {
  	//console.log(( $('#bullet').css(toTest)));
  	//console.log((signe + Math.round( ($("div").find("[data-x='1'][data-y='1']").height() + 2.7) * distance * 10)+ "px") );
		if ( $('#bullet').css(toTest) === (signe + Math.round( ($("div").find("[data-x='1'][data-y='1']").height() + 2.7) * distance * 10)/10 + "px") ){
			clearInterval(timer);
			def.resolve();
		}
  },1);

	return def.promise();
};

Avion.prototype.supprimerTir= function()
{
	$("#bullet").remove();
};

Avion.prototype.modifierVie= function(vie)
{
	this.vie = vie;
	$("#vie_"+ this.nom).text(vie);
};

Avion.prototype.afficher = function() {
	var position = $("div").find("[data-x='" + this.x + "'][data-y='" + this.y + "']");

	$("#" + this.nom).remove();
	position.append("<img id='" + this.nom + "' src='" + this.nom + ".png' class='avion " + this.orientation + "'/>");
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
        degree += direction;

	    $("#" + nom).css({ WebkitTransform: 'rotate(' + degree + 'deg)'});
	    $("#" + nom).css({ '-moz-transform': 'rotate(' + degree + 'deg)'});

	    if(degree === toDegree)
	    {
    		clearInterval(timer);
    		def.resolve();
	    }
    },1);

  	return def.promise();
};
