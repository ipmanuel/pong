8 - Bit Pong
=============

Pong is one of the first computer games that ever created. This simple game consists of two paddles, a ball and the goal that you have more score than the opponent after two minutes playing.
A player score once the opponent missed a ball. 
The game can be played with two human players, or one player against a computer controlled paddle. 


Requirements
------------

* [Ruby Processing](https://github.com/jashkenas/ruby-processing/wiki/getting-started)
* [Processing library minim](http://code.compartmental.net/tools/minim/) (preinstalled)


Start
-----
	rp5 run pong.rb
    
About
---------

The Game Pong has a 8 - Bit Look und the known sounds.

The game runs after opening "pong.rb" in fullscreen mode and there will be three select options:
* 1. Second Player: computer or human
* 2. Difficulty: easy, medium, hard
* 3. Start game

By Pressing the start button the pitch will be shown and the game starts. The actual score will be shown for a few seconds after one player miss ball. The game ends after two minutes playing and save

Keys
----

| Key        	| Action        					| 
| ------------- |:--------------------------------:	| 
| "p"     		| pause and start game 				| 
| "m"      		| return to menu and end game      	|   
| ESC 			| close game     					| 
| "w" 			| player1: move paddle up 			| 
| "s" 			| player1: move paddle down   		| 
| "up" 			| player2: move paddle up    		| 
| "down" 		| player2: move paddle down    		| 


How it works
--------------

### Ball
The Ball moves at a speed of 20 pixel per frame in direction and turns direction after reaching x-coordinate of an controller if it hits. If the player miss the ball it will move out of the screen and stop after that. In case of hitting the borders (top and down) the ball will be deflected according to the law of reflefction that implied the angle of incidence is equal to the angle of reflection. The deflecting ankle grows in distance to middle point of a paddle. This process ends until the ball miss a paddle.

### Computer
The computer is not unbeatable because of adding or subracting random digits to y-coordinate of ball, which is the achor point. By growing age of difficulty the random digits are going to be smaller. Furthermore the computer paddle is auto centred at the hardest difficulty.

### Highscore
Hiscore is calculated by the difference of losts betweend human and computer. It calculates an highscore for each age of difficulty.