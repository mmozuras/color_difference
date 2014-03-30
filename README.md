# Color Difference

[![Code Climate](https://codeclimate.com/github/mmozuras/color_difference.png)](https://codeclimate.com/github/mmozuras/color_difference)
[![Build Status](https://travis-ci.org/mmozuras/color_difference.png)](https://travis-ci.org/mmozuras/color_difference)
[![Gem Version](https://badge.fury.io/rb/color_difference.png)](http://badge.fury.io/rb/color_difference)
[![Dependency Status](https://gemnasium.com/mmozuras/color_difference)](https://gemnasium.com/mmozuras/color_difference)

Implementation of [CIEDE2000 color-difference formula](http://www.ece.rochester.edu/~gsharma/ciede2000/ciede2000noteCRNA.pdf), which, unlike, something simpler, like Euclidean distance, takes into account subjective visual perception.

## Usage

```ruby
difference = ColorDifference.cie2000({ r: 255, g: 25, b: 31 },
                                     { r: 251, g: 34, b: 89 })
```
