
## ----- CLASS: CONTROLLER  ----- ##
class Controller
    include Math
    attr_reader :coord_x1, :coord_x2, :coord_y1, :coord_y2, :coord_m, :length, :width

    attr_writer :speed

    # initialize: set controller
    def initialize (coord_x, coord_y, keys, speed=20, length=200, width=40)
        # cordinastes of edges
        @coord_x1 = coord_x
        @coord_x2 = coord_x + width
        @coord_y1 = coord_y - length/2
        @coord_y2 = coord_y + length/2

        @move_y   = @speed
        @move_y   = speed

        @coord_m  = coord_y
        
        @keys       = keys
        
        # attributes
        @length 	= length
        @width      = width
    end
    
    # move: move by mouse or calculation
    def move (coord_y=false, key_=false, key_code_=false, max_height=1080, min_height=0)           
        if !coord_y
            @coord_m  = @coord_y1 > min_height  ? @coord_m - @move_y : @coord_m if key_ == @keys[0] || key_code_ == @keys[0]
            @coord_m  = @coord_y2 < max_height  ? @coord_m + @move_y : @coord_m if key_ == @keys[1] || key_code_ == @keys[1]
        elsif coord_y >=  min_height && coord_y <= max_height && (@coord_m - coord_y).abs > @move_y.abs 
            @coord_m = @coord_m + (coord_y > @coord_m ? @move_y : -@move_y)
        end

        @coord_y1   = @coord_m - @length / 2
        @coord_y2   = @coord_m + @length / 2
    end
end