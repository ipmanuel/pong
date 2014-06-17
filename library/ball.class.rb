## ----- CLASS: BALL ----- ##
class Ball
    attr_reader :coord_x1, :coord_x2, :coord_y1, :coord_y2, :coord_ym, :move_x, :ankle, :radius, :move_x

    # initalize: set ball
    def initialize (coord_x, coord_y, radius=100, speed=20)
        # attributes
        @radius     = radius
        @speed      = speed
        @move_x     = @speed

        # coordinates
        @coord_x1    = coord_x
        @coord_x2    = coord_x + radius
        @coord_y1  	= coord_y
        @coord_y2   = coord_y + radius

        @coord_ym   = @coord_y1 + radius/2

        # start coordinate
        @coord_y0  	= coord_y

        # direction
        @ankle    	= 0
        @slope     	= 1
    end

    # move: move ball two dimensionally
    def move
        @coord_x1    = @coord_x1 + @move_x
        @coord_x2    = @coord_x1 + @radius
        @coord_y1    = @coord_y1 + @slope * @move_x * Math.tan(@ankle)
        @coord_y2    = @coord_y1 + @radius
        @coord_ym    = @coord_y1 + @radius/2

        #draw()
    end 
    
	# change_direction: from left to right and the other way round
    def change_direction
        @move_x = -@move_x
        @speed = -@speed
    end
    
    # change_ankle: set ankle
    def change_ankle (ankle)
        @coord_y0	= @coord_y1
        @ankle 		= ankle
    end
    
    # change_slope: turn up or down
    def change_slope (slope)
        @coord_y0     = @coord_y1
        @slope        = @move_x < 0 ? -slope : slope
    end
    
    # toggle_slope: toggle the current slope
	def toggle_slope
		@coord_y0     = @coord_y1
        @slope        = -@slope
    end

    # stop: stop movement
    def start
        @move_x = @speed
    end

	# stop: stop movement
    def stop
        @move_x = 0
    end
end
