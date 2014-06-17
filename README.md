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
    
Structure
---------

Das Spiel Pong wurde im 8 Bit Stil erstellt und die dazugehörige Musik wurde ebenfalls verwendet.

Beim Aufruf der Datei "pong.rb" wird ein Vollbild Fenster geöffnet und man hat drei Auswahlmöglichkeiten: 
1. Ob man gegen einen Computer oder einer weiteren Person spielen möchte
2. Man kann den Schwierigkeitsgrad für das Spiel gegen den Computer einstellen
3. Start Knopf durch die Taste "Enter" betätigen.

Durch das Betätigen der Start Taste wird das Spielfeld angezeigt und das Spielen beginnt sofort. Die Controller werden über die Pfeiltasten nach unten und oben sowie "w" und "s" nach unten bzw. nach oben bewegt.

Der aktuelle Punktestand wird bei jedem Verlust des Balls für wenige Sekunden angezeigt. Daraufhin geht das Spiel normal weiter.

Mit der Taste "p" kann das Spiel pausiert werden und mit der selben Taste kann man das Spiel auch fortführen. Um zum Menü zurückzukehren muss man die Taste "m" betätigen. Außerdem wird das Spiel mit ESC beendet.

Funktionsweise
--------------

### Ball
Der Ball bewegt sich immer mit einer Schnelligkeit von 20 Pixel pro Frame in einer Richtigung bis der die X-Koordinate eines Controllers erreicht. Im Fall, dass Der Ball auf einen Controller trifft wirde die Richtung geändert und er bewegt sich mit der selben Geschwindigkeit in entgegensetzer Richtung. Andernfalls bewegt er sich aus der Bildfläche und stopt daraufhin seine Bewegung. Bei Kollision mit einem Controller oder der Bande wird der Ball abegelenkt. An der Bande wird er wie üblich mit dem gleichen Winkel abgelenkt wie er darauftrifft. Im Bezug auf den den Berühpunkt wird das Spielobjekt am Controller abgelenkt. Je größer der Abstand zum Mittelpunkt ist, desto größer ist die Ablenkung nach Oben bzw. nach unten je nachdem welche Hälfte getroffen wird. Daraufhin führt der Ball seine Bewegung mit dem errechneten Winkel fort. Dieser Prozess läuft solange Controller den Ball nicht trifft.


### Computer
Die Y-Koordinate des Balls ist ein Ankerpunkt des Computer - Controllers. Dadurch wäre der Computer jedoch unschlagbar, daher musste der COmputer die Eigenschaft erhalten Fehler machen zu können. Dies konnte durch Zufallszahlen umgesetzt werden, die der Y-Koordinate des Balls addiert oder subtrahiert wurden. Je größer der Schwierigkeitsgrad, desto geringer wird das Ausmaß des Fehlers. Außerdem wird beim höchsten Schwierigkeitsgrad der Computer COntroller auto zentriert. 

### Highscore
Der Highscore bezieht sich auf die Differenz zwischen den Losts zwischen Computer und Spieler. Außerdem besteht ein Highscore für jeden Schwierigkeitsgrad.