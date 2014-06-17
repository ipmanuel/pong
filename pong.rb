## ---------- 8-BIT PONG ---------- ##
attr_reader :ball_img, :font, :minim
load_library :minim

import 'ddf.minim'
import 'ddf.minim.analysis'

require 'library/controller.class.rb'
require 'library/ball.class.rb'   

## ----- DRAWING CONFIGURATION  ----- ##
## --- setup: initalize ball and controllers  --- ##
def setup
	# screen
    size displayWidth, displayHeight, P3D


    @root_path = File.expand_path File.dirname(__FILE__)

    @ball_img       = load_image(@root_path + "/images/ball.png") #{}"/Users/manuelpauls/projects/samples/contributed/ball.png"

    frame_rate 60
    smooth
    @frame          = 1

    # sounds
    load_sounds

    # text
    @font           = create_font('Nokia Cellphone FC', 40)

    # menu
    @m_active       = 0
    @m_selected     = [0, 0, false]
    @m_text         = [
                        ["Option", ["1 Player + Computer", "2 Player"]],
                        ["Difficulty", ["Easy", "Medium", "Hard"]],
                        ["Start", []]
                    ]

    # game
    @g_paused       = false
    @g_started      = 0
    @g_c_duration   = 2*60
    @g_duration     = @g_p_duration# Actual
    @g_players      = 1
    @g_difficulty   = 1
    @g_score        = [0,0]
    @g_highscore    = get_highscore

    # controller
    @keys1          = ["w","s"]
    @player         = Controller.new(30, width/2, @keys1)
    @keys2          = [38, 40]

    @player2        = Controller.new(width-70, height/2, @keys2)
	
    # ball
    @ball           = Ball.new(@player.coord_x2 + 50, height/2)

    # lost ball
    @g_lost         = false
    @g_lost_time    = 0 

    # random coord for computer controller
    rand_coord
    
    # key pressed 
    @keyup          = false
    @keydown        = false
    @keyup2         = false
    @keydown2       = false
end


## --- draw: output controller and ball  --- ##
def draw
    # fullscreen
    background(-1)

    # background color
    background 0

    # frames
    menu if @frame == 1
    game if @frame == 2
end

## --- sketFullSceen: fullscreen mode  --- ##
def sketchFullScreen
  return true
end



## ----- FRAME1: MENU  ----- ##
## -- menu: draw and calculate menu -- ##
def menu
    # heading
    textFont(font, 150)
    fill(200, 200, 200)
    textAlign(CENTER, CENTER)
    text("Pong", width/2, height/2/3)

    # settings
    draw_settings
end

## -- draw_settings: draw label and selection -- ##
def draw_settings
    # border
    fill 0
    stroke(255, 255, 255)
    strokeWeight(10)
    rect width/6, height/3, width*4/6, height/3

    # text config
    textFont(font, 50)

    # draw menu
    @x = height/2 - 70
    0.upto(@m_text.length-1) do |i|
        # change font color
        if @m_active == i
            fill(232, 252, 98)
        else
            fill(200, 200, 200)
        end

        # option selection
        if !@m_text[i][1].empty?
            textAlign(LEFT)
            content = @m_text[i][0].to_s + ":" + blanks(12- @m_text[i][0].length) + @m_text[i][1][@m_selected[i]].to_s
            text(content, width/2 - 500, @x)
        # button
        else
            textAlign(CENTER)
            text(@m_text[i][0].to_s, width/2,    @x)
        end
        @x += 70
    end
    fill(200, 200, 200)
    text "Highscore: #{@g_highscore}", width/2, height - 20
end


## ----- GAME  ----- ##
## -- game: draw and calculate game -- ##
def game
    # controller
    draw_controller (@player)
    draw_controller (@player2)

    if @g_duration > 0
        # move controller and ball
        if !@g_paused
            now = Time.now
            if now - @g_started >= @g_duration
                @g_duration = 0
            end

            # ball
            draw_ball
            
            # first player
            @player.move(false, @keyup ? "w" : "s", false, height) if @keyup || @keydown

            # second player
            if @g_players == 2
                @player2.move(false, false, @keyup2 ? 38 : 40, height) if @keyup2 || @keydown2

            # computer
            elsif @ball.coord_x1 > width*1/2
                @player2.move(@ball.coord_ym + @coord_random, false, false, height)
            
            # computer: auto centering
            elsif @g_difficulty == 3 && @ball.coord_x1 < width*1/2
                @player2.move(height/2, false, false, height)
            end

            # ball
            @ball.move
            collision

            # scored
            if @g_lost 
                # output score
                if @g_lost_time > millis - 1500
                    draw_score
                # reset ball
                else
                    @ball   = Ball.new(@player.coord_x2 + 50, height/2)
                    @g_lost = false
                end
            end
        # pause game
        else
            @ball.stop 
            textFont(font, 70)
            textAlign(CENTER, CENTER)
            text "PAUSE", width/2, height/2
        end
    else
        draw_score
        save_highscore
    end

end

## --- collision: check collisions with border, controller and walls (behind the controller) --- ##
def collision
    # nearest controller 
    controller = @ball.move_x > 0 ? @player2 : @player

    # x coord of controller
    c_coord_x = @ball.move_x > 0 ? controller.coord_x2 : controller.coord_x1

    # x coord of ball
    b_coord_x = @ball.move_x > 0 ? @ball.coord_x2 : @ball.coord_x1
    
    # ball reach controller x coord
    if @ball.move_x > 0
        c_hit = b_coord_x > c_coord_x - 70 ? true : false
    else
        c_hit = b_coord_x < c_coord_x + 70 ? true : false
    end

    # hit controller or wall
    if c_hit        
        # hit controllers
        if in_n_rage(@ball.coord_y1, controller.coord_y1, controller.coord_y2) || 
            in_n_rage(@ball.coord_y2, controller.coord_y1, controller.coord_y2)
            
            @ball.change_direction()
            @ball.change_ankle(ankle())
            rand_coord()

            @s_plop.play
        # hit wall
        elsif !@g_lost
            @g_score[0]+= 1 if @ball.move_x > 0 
            @g_score[1]+= 1 if @ball.move_x < 0
            @g_lost = true
            @g_lost_time = millis

            @s_peep.loop(1)
        end
        rand_coord
    end

    @ball.stop if @ball.coord_x1 > width || @ball.coord_x2 < 0

    

    # hit border
    @ball.change_slope(-1) if @ball.coord_y2 >= height
    @ball.change_slope(1) if @ball.coord_y1 - 10 < 0

    @s_plop.play if @ball.coord_y2 >= height || @ball.coord_y1 - 10 < 0
end

## --- ankle: get ankle to move forward --- ##
def ankle
    # nearest controller
    distance_p1 = (@ball.coord_x1 - @player.coord_x2).abs
    distance_p2 = (@player2.coord_x1 - @ball.coord_x1).abs
    controller = distance_p1 < distance_p2 ? @player : @player2
    
    # deflect the bullet to top or bottom******************
    distance_c_top 	  = controller.length/2 - (@ball.coord_ym - controller.coord_y1).abs# distance from the middle to ball_y
    distance_c_bottom = controller.length/2 - (@ball.coord_ym - controller.coord_y2).abs
    
    # change slope (up or down)
    if distance_c_top > distance_c_bottom
		distance = distance_c_bottom
		@ball.change_slope(-1)
	else
		distance = distance_c_top
		@ball.change_slope(1)
	end
	
    # ankle relativly to hit point
	ankle = distance.abs / (controller.length/2) * deg2rad(30 + random(0, 5))
    
    return ankle
end

## --- draw_score: draw actual score  --- ##
def draw_score
    fill(232, 252, 98)
    textFont(font, 70)

    textAlign(RIGHT, CENTER)
    text @g_score[0].to_s, width/2-40, height/2

    textAlign(CENTER, CENTER)
    text ":", width/2, height/2

    textAlign(LEFT, CENTER)
    text @g_score[1].to_s, width/2+40, height/2
end

## --- draw_controller: controller should be an instance of controller  --- ##
def draw_controller (controller)
    fill 200, 200, 200

    stroke 200, 200, 200

    rect controller.coord_x1, controller.coord_y1, controller.width, controller.length
end

## --- draw_ball: load image and show  --- ##
def draw_ball 
    @ball_img.resize(@ball.radius, @ball.radius)
        
    image @ball_img, @ball.coord_x1, @ball.coord_y1
end



## ----- KEYBOARD -  CONTROLLING  ----- ##
## --- key_pressed: check if keys are pressed  --- ##
def key_pressed
    if key == CODED
        @keyup2 = true if keyCode == UP
        @keydown2 = true if keyCode == DOWN
    else
        @keyup = true if key == "w"
        @keydown = true if key == "s"
    end
end

## --- keyReleased: handle after key was pressed  --- ##
def keyReleased
    # simultaneity of key
    @keyup2    = false if key == CODED && keyCode == UP
    @keydown2  = false if key == CODED && keyCode == DOWN
    @keyup     = false if key == "w" 
    @keydown   = false if key == "s"

    # game: pause
    if key == "p" 
        @ball.start if @g_paused
        

        @g_duration -= Time.now - @g_started  if !@g_paused
        @g_started = Time.now if @g_paused

        @g_paused = !@g_paused
    end

    # menu: back to menu
    if key == "m" 
        @frame = 1
    end

    # menu: draw selections
    if @frame == 1
        # row selection: hoch
        if key == CODED && keyCode == DOWN && @m_active < @m_text.length - 1
            @m_active += 1 
            @s_beep.play
        end
        
        # row selection: runter
        if key == CODED && keyCode == UP && @m_active > 0
            @m_active -= 1
            @s_beep.play
        end

        # option selection
        options = @m_text[@m_active][1]
        if !options.empty?
            @m_selected[@m_active] += 1 if key == CODED && keyCode == RIGHT && @m_selected[@m_active] < options.length - 1
            
            @m_selected[@m_active] -= 1 if key == CODED && keyCode == LEFT && @m_selected[@m_active] > 0

            @s_plop.play
        # buttons
        elsif key == "\n"
            @m_selected[@m_active] = true
            @s_peep.play
            @g_duration = @g_c_duration
        end
    end

    @g_players      = @m_selected[0] + 1
    @g_difficulty   = @m_selected[1] + 1
    @g_highscore    = get_highscore
    # start game
    if @m_selected[2]
        @frame = 2
        @g_score = [0,0]
        @m_selected[2] = false
        @g_started = Time.now
    end
    # return
    if @m_selected[3]
        @frame = 2
        @m_selected[3] = false
    end
end

## --- save_highscore: new highscore? -> save  --- ##
def save_highscore 
    if @g_players == 1
        score = @g_score[0] - @g_score[1]
        if score > 0 && score > @g_highscore
            File.open("highscore-#{@g_difficulty}.txt", 'w+') do |f| 
                f.write(score.to_s)
            end
            @g_highscore = score
        end
    end
end

## --- get_highscore: get highscore in association of  difficulties --- ##
def get_highscore
    lines = []
    if File.file?("highscore-#{@g_difficulty}.txt")
        f = File.open("highscore-#{@g_difficulty}.txt", "r")
            f.each_line do |line|
            lines << line
        end
        f.close
        return lines[0].to_i
    end
    return 0    
end

## ----- HELPERS  ----- ##
## --- load_sounds: initalize sound Module and sound variables  --- ##
def load_sounds 
    @minim          = Minim.new self
    @s_beep         = @minim.load_file @root_path + "/sounds/beeep.wav", 2048
    @s_peep         = @minim.load_file @root_path + "/sounds/peeeeeep.wav", 2048
    @s_plop         = @minim.load_file @root_path + "/sounds/plop.wav", 2048
end

## --- deg2rad: convert from degrees to radians  --- ##
def deg2rad (degrees)
  degrees * PI / 180
end

## --- in_n_rage: a number in a range?
def in_n_rage (number, small, large)
    if (number >= small && number <= large)
        true
    else 
        false
    end
end

## --- rand_coord: rand coordinate for controller ankle  --- ##
def rand_coord 
    factor = random(0, 2) if @g_difficulty == 1
    factor = random(0, 1.5) if @g_difficulty == 2 || @g_difficulty == 3

    @coord_random = random(-@player2.length*factor, @player2.length*factor)
end

def blanks (amount)
    @blanks = ""
    amount.times do |i|
        @blanks = "#{@blanks} "
    end
    @blanks.to_s
end