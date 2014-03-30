require 'color_difference/color'

module ColorDifference
  CIRCLE = 360
  HALF_CIRCLE = 180

  def self.cie2000(color1, color2)
    color1 = ColorDifference::Color.new(color1[:r], color1[:g], color1[:b])
    color2 = ColorDifference::Color.new(color2[:r], color2[:g], color2[:b])

    color_avg = color_avg(color1, color2)
    g = 0.5 * (1 - convert(color_avg))

    a1 = (1.0 + g) * color1.a
    a2 = (1.0 + g) * color2.a
    c1 = Math.sqrt((a1**2) + (color1.b**2))
    c2 = Math.sqrt((a2**2) + (color2.b**2))
    c_avg = (c1 + c2) / 2.0

    hue1 = hue(color1, a1)
    hue2 = hue(color2, a2)
    hue_avg = hue_avg(hue1, hue2)
    hue_delta = hue_delta(hue1, hue2)

    t = 1 - 0.17 * Math.cos(radians(hue_avg - 30)) +
            0.24 * Math.cos(radians(2 * hue_avg)) +
            0.32 * Math.cos(radians(3 * hue_avg + 6)) -
            0.2 * Math.cos(radians(4 * hue_avg - 63))

    delta_l = color2.l - color1.l
    delta_c = c2 - c1
    hue_delta = 2 * Math.sqrt(c2 * c1) * Math.sin(radians(hue_delta) / 2.0)

    l_avg = (color1.l + color2.l) / 2.0
    s_l = 1 + ((0.015 * ((l_avg - 50)**2)) / Math.sqrt(20 + ((l_avg - 50)**2.0)))
    s_c = 1 + 0.045 * c_avg
    s_h = 1 + 0.015 * c_avg * t

    delta_ro = 30 * Math.exp(-((((hue_avg - 275) / 25)**2.0)))
    r_t = -2 * convert(c_avg) * Math.sin(2 * radians(delta_ro))

    difference = Math.sqrt(((delta_l / (s_l))**2) +
                           ((delta_c / (s_c))**2) +
                           ((hue_delta / (s_h))**2) +
                           r_t * (delta_c / (s_c)) * (hue_delta / (s_h)))

    scale(difference)
  end

  private

  def self.scale(number)
    if number <= 0
      0
    elsif number >= 100
      1
    else
      number.to_f / 100
    end
  end

  def self.radians(degrees)
    degrees * Math::PI / HALF_CIRCLE
  end

  def self.degrees(radians)
    radians * HALF_CIRCLE / Math::PI
  end

  def self.color_avg(color1, color2)
    c1 = Math.sqrt((color1.a**2) + (color1.b**2))
    c2 = Math.sqrt((color2.a**2) + (color2.b**2))
    (c1 + c2) / 2.0
  end

  def self.hue(color, a)
    hue = [color.b, a] == [0.0, 0.0] ? 0.0 : degrees(Math.atan2(color.b, a))
    hue += CIRCLE if hue < 0
    hue
  end

  def self.hue_avg(hue1, hue2)
    diff = hue1 - hue2
    sum = hue1 + hue2

    if diff.abs > HALF_CIRCLE
      (sum + CIRCLE) / 2.0
    else
      (sum) / 2.0
    end
  end

  def self.hue_delta(hue1, hue2)
    diff = hue2 - hue1
    if diff.abs <= HALF_CIRCLE
      diff
    elsif diff.abs > HALF_CIRCLE && hue2 <= hue1
      diff + CIRCLE
    else
      diff - CIRCLE
    end
  end

  def self.convert(avg)
    Math.sqrt((avg**7.0) / ((avg**7.0) + (25.0**7.0)))
  end
end
