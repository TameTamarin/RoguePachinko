require "math"

points = {
		x1 = 1,
		y1 = 0,
		x2 = 2,
		y2 = 0,
		x3 = 0,
		y3 = 0,
		x4 = 0,
		y4 = 0,
		x5 = 0,
		y5 = 0,
		x6 = 0,
		y6 = 0,
		x7 = 0,
		y7 = 0,
		x8 = 0,
		y8 = 0
	}

    points2 = {
		x1,
		y1,
		x2,
		y2,
		x3,
		y3,
		x4,
		y4,
		x5,
		y5,
		x6,
		y6,
		x7,
		y7,
		x8,
		y8
	}


for i = 1, 8 do
    print(math.sin(1))
    
end


balls = {
    {x=250, y=150, radius=10, color={1,0,0}, bounce = 0.5},
    {x=300, y=150, radius=10, color={0,1,0}, bounce = 0.5},
    {x=400, y=150, radius=10, color={0,0,1}, bounce = 0.5},
    {x=500, y=150, radius=10, color={1,1,0}, bounce = 0.5},
    {x=600, y=150, radius=10, color={0,1,1}, bounce = 0.5}
}

print(balls[1])
print(balls[1])
table.insert(balls, {x=250, y=150, radius=10, color={1,0,0}, bounce = 0.5})

print(balls[2])