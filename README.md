8 - Bit Pong
=============
Pong is one of the first computer games that has ever been created.
This simple game consists mainly of two paddles and a ball.
Pushing the paddles allows to block the ball from falling into the whole and to get a higher score.
The player has to receive a higher number of points than his opponent after a timeframe of two minutes.

It is possible to play “Pong” with two human players or one player and a computer controlled pair of paddles.


Requirements
------------

* [Ruby Processing](https://github.com/jashkenas/ruby-processing/wiki/getting-started)
* [Processing library minim](http://code.compartmental.net/tools/minim/) (normally preinstalled)
* Install font "Nokia Cellphone FC" (Path: "font/nokiafc22.ttf")



Start
-----
	rp5 run pong.rb
    
About
---------
The Game Pong has an 8 - Bit Look and the well known sounds.
It runs after opening "pong.rb" in the full-screen-mode. There will be three select options to press:


* 1. Second Player: computer or human
* 2. Difficulty: easy, medium, hard
* 3. Start game

After pressing the start button the pitch will appear and the game starts.
The actual score will be shown to the player for a few seconds after the other player missed the ball.
The game finishes after two minutes playing and saves a highscore.


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
The Ball moves at a speed of 20 pixels per frame in direction and turns direction after reaching x-coordinate of a controller if it hits. 
If the player misses the ball it will move out of the screen and stop after that. 
In case of hitting the borders (top and down) the ball will be deflected according to the law of reflection. This implies the angle of incidence and is equal to the angle of reflection.
 
The deflecting angle grows in distance to the middle point of a paddle. This process finishes until the player misses the ball.


### Computer
The computer is not unbeatable because of adding or subtracting random digits to y-coordinate of the ball, which is the anchor point. 
By a growing stage of difficulty the random digits are going to decrease.
Furthermore the computer paddles are centred automatically at the hardest difficulty.

### Highscore
Highscore is calculated by the difference of losses between the human and the computer. 
It calculates a highscore for each stage of difficulty.
