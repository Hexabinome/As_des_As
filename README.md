# As_des_As
Prolog program of logic plane board game with multiple IA


###### question reponse avec prof
Principe du jeu a effectue dans prolog
```prolog
play:-gameover, ! 
play:-board(B), --> état actuelle du plateau
display(B), 
ia1(B, I),  --> b état l’état actuelle et I le prochain cout --> doit trouver un cout possible, puis le meilleurs
jouer(B, I, B new)
SaveCout(B, Bnew)
retract(B)
```

###### Etats

###### IA

###### IHM

