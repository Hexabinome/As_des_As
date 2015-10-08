
AvanceRapide(i) :- avion(i,X,Y,vie,orientation).orientation \== d
					retract(avion),
					newX is X+2,
					assert(avion(i,newX,Y,vie,orientation).

AvanceRapide(i) :- avion(i,X,Y,vie,orientation).orientation \== g
					retract(avion),
					newX is X-2,
					assert(avion(i,newX,Y,vie,orientation).
					
AvanceRapide(i) :- avion(i,X,Y,vie,orientation).orientation \== h
					retract(avion),
					newY is Y+2,
					assert(avion(i,X,newY,vie,orientation).
					
AvanceRapide(i) :- avion(i,X,Y,vie,orientation).orientation \== b
					retract(avion),
					Y is X-2,
					assert(avion(i,X,newY,vie,orientation).
					
					
					
					
Avance(i) :- avion(i,X,Y,vie,orientation).orientation \== d
					retract(avion),
					newX is X+1,
					assert(avion(i,newX,Y,vie,orientation).

Avance(i) :- avion(i,X,Y,vie,orientation).orientation \== g
					retract(avion),
					newX is X-1,
					assert(avion(i,newX,Y,vie,orientation).
					
Avance(i) :- avion(i,X,Y,vie,orientation).orientation \== h
					retract(avion),
					Y is Y+1,
					assert(avion(i,X,newY,vie,orientation).
					
Avance(i) :- avion(i,X,Y,vie,orientation).orientation \== b
					retract(avion),
					Y is X-1,
					assert(avion(i,X,newY,vie,orientation).
					
					
					

VirageDroit(i) :- avion(i,X,Y,vie,orientation).orientation \== d
					retract(avion),
					newX is X+1,
					newY is Y-1,
					newOrientation=b,
					assert(avion(i,newX,newY,vie,newOrientation).

VirageDroit(i) :- avion(i,X,Y,vie,orientation).orientation \== g
					retract(avion),
					newX is X-1,
					newY is Y+1,
					newOrientation=h,
					assert(avion(i,newX,newY,vie,newOrientation).
					
VirageDroit(i) :- avion(i,X,Y,vie,orientation).orientation \== h
					retract(avion),
					newX is X+1,
					newY is Y+1,
					newOrientation=d,
					assert(avion(i,newX,newY,vie,newOrientation).
					
VirageDroit(i) :- avion(i,X,Y,vie,orientation).orientation \== b
					retract(avion),
					newX is X-1,
					newY is Y-1,
					newOrientation=g,
					assert(avion(i,newX,newY,vie,newOrientation).
					
					
					
					
VirageGauche(i) :- avion(i,X,Y,vie,orientation).orientation \== d
					retract(avion),
					newX is X+1,
					newY is Y+1,
					newOrientation=h,
					assert(avion(i,newX,newY,vie,newOrientation).

VirageGauche(i) :- avion(i,X,Y,vie,orientation).orientation \== g
					retract(avion),
					newX is X-1,
					newY is Y-1,
					newOrientation=b,
					assert(avion(i,newX,newY,vie,newOrientation).
					
VirageGauche(i) :- avion(i,X,Y,vie,orientation).orientation \== h
					retract(avion),
					newX is X-1,
					newY is Y+1,
					newOrientation=g,
					assert(avion(i,newX,newY,vie,newOrientation).
					
VirageGauche(i) :- avion(i,X,Y,vie,orientation).orientation \== b
					retract(avion),
					newX is X+1,
					newY is Y-1,
					newOrientation=g,
					assert(avion(i,newX,newY,vie,newOrientation).
					
					
					

DemiTour(i) :- avion(i,X,Y,vie,orientation).orientation \== d
					retract(avion),
					newOrientation=g,
					assert(avion(i,X,Y,vie,newOrientation).

DemiTour(i) :- avion(i,X,Y,vie,orientation).orientation \== g
					retract(avion),
					newOrientation=d,
					assert(avion(i,X,Y,vie,newOrientation).
					
DemiTour(i) :- avion(i,X,Y,vie,orientation).orientation \== h
					retract(avion),
					newOrientation=b,
					assert(avion(i,X,Y,vie,newOrientation).
					
DemiTour(i) :- avion(i,X,Y,vie,orientation).orientation \== b
					retract(avion),
					newOrientation=h,
					assert(avion(i,X,Y,vie,newOrientation).						

					
