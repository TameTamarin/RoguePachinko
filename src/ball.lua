ball = {x=400, y=400, vel=0, radius=50, color={1,0,0}}

function drawBalls()
    balls = {
        {x=200, y=200, radius=20, color={1,0,0}},
        {x=300, y=300, radius=30, color={0,1,0}},
        {x=400, y=400, radius=40, color={0,0,1}},
        {x=500, y=500, radius=50, color={1,1,0}},
        {x=600, y=600, radius=60, color={0,1,1}},
    }
    for i, ball in ipairs(balls) do
        love.graphics.setColor(ball.color)
        love.graphics.circle("fill", ball.x, ball.y, ball.radius)
    end

end