ball = {x=400, y=400, vel=0, radius=50, color={1,0,0}}

function drawBalls(world)
    balls = {
        {x=200, y=0, radius=10, color={1,0,0}},
        {x=300, y=0, radius=15, color={0,1,0}},
        {x=400, y=0, radius=20, color={0,0,1}},
        {x=500, y=0, radius=25, color={1,1,0}},
        {x=600, y=0, radius=30, color={0,1,1}},
    }
    for i, ball in ipairs(balls) do
        ball.body = love.physics.newBody(world, ball.x, ball.y, "dynamic")
        ball.shape = love.physics.newCircleShape(ball.radius)
        ball.fixture = love.physics.newFixture(ball.body, ball.shape)
        ball.body:setFixedRotation(true)
        love.graphics.setColor(ball.color)
        love.graphics.circle("fill", ball.x, ball.y, ball.radius)
        
    end

end

