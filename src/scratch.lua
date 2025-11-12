require "math"
utilities = require('utilities')

points = load_xy_from_txt("flipper_coordinates.txt")

print("Loaded " .. tostring(#points) .. " flipper points.")