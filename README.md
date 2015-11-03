# As_des_As
###### Rules:
As des As (or Ace of Aces originally) is a plane fight board game published in 1980. This program is a playable version with multiple AIs, made with the logical programming langage Prolog.
Each turn the two players will choose three actions that will be executed at the same time. 
During each move, a plane shoots its enemy if he is in range, which makes the latter lose one life point.
A player wins when the other player's life has reached 0.

Beware! If a player is out of the board at the end of the three moves, he loses the game.

### IA:
We provide many IA with different behaviour such as:
- Random.
- Offensive.
- Defensive.
- Hybrid.

### Human Player:
In order to make this program, as ludic as possible, we provide the possibility to switch between an AI and a human player, to challenge each IA.

### IHM:
We have developed a light web interface to show the fight result between 2 AIs or to take part of the battle!

selectPlayers(J1, J2)
-1->Human player
0->aiRandom
1->aiOffensive
2->aiDefensive
3->aiDraw
4->aiOffensiveBest
5->aiDefensiveBest
6->aiDrawBest
7->aiProbab with 0.5 agro
8->aiOrOffensive
9->aiOrDefensive
10->aiOrOffensiveBest
11->aiOrDefensiveBest
12->aiHybride
13->aiHybrideNonDeterministe