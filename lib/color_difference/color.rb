module ColorDifference
  class Color < Struct.new(:red, :green, :blue)
    def l
      @l ||= (116.0 * lab_y) - 16.0
    end

    def a
      @a ||= 500.0 * (lab_x - lab_y)
    end

    def b
      @b ||= 200.0 * (lab_y - lab_z)
    end

    def x
      @x ||= 0.4124 * xyz_r + 0.3576 * xyz_g + 0.1805 * xyz_b
    end

    def y
      @y ||= 0.2126 * xyz_r + 0.7152 * xyz_g + 0.0722 * xyz_b
    end

    def z
      @z ||= 0.0193 * xyz_r + 0.1192 * xyz_g + 0.9505 * xyz_b
    end

    private

    def lab_x
      @lab_x ||= lab(x / 95.047)
    end

    def lab_y
      @lab_y ||= lab(y / 100.000)
    end

    def lab_z
      @lab_z ||= lab(z / 108.883)
    end

    def lab(light)
      if light > 0.008856
        light**(1.0 / 3)
      else
        (7.787 * light) + (16.0 / 116)
      end
    end

    def xyz_r
      @xyz_r ||= xyz(red)
    end

    def xyz_g
      @xyz_g ||= xyz(green)
    end

    def xyz_b
      @xyz_b ||= xyz(blue)
    end

    def xyz(light)
      light = light / 255.0
      result = light <= 0.04045 ? light / 12.92 : ((light + 0.055) / 1.055)**2.4
      result * 100
    end
  end
end
