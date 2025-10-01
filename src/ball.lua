balls = {
    {x=200, y=0, radius=10, color={1,0,0}},
    {x=300, y=0, radius=10, color={0,1,0}},
    {x=400, y=0, radius=10, color={0,0,1}},
    {x=500, y=0, radius=10, color={1,1,0}},
    {x=600, y=0, radius=10, color={0,1,1}},
}
    

function initBalls(world)
    for i, ball in ipairs(balls) do
        ball.body = love.physics.newBody(world, ball.x, ball.y, "dynamic")
        ball.shape = love.physics.newCircleShape(ball.radius)
        ball.fixture = love.physics.newFixture(ball.body, ball.shape,100)
        ball.body:setFixedRotation(true)
        ball.fixture:setRestitution(0.5)
    end
end


function drawBalls(world)
    for i, ball in ipairs(balls) do
        love.graphics.setColor(ball.color)
        love.graphics.circle("fill", ball.x, ball.y, ball.radius)
    end
end


function updateBallsLocations()
    for i, ball in ipairs(balls) do
        balls[i].x, balls[i].y = balls[i].body:getPosition()
    end
end


function resetBallPosition()
    for i, ball in ipairs(balls) do
        balls[i].body:setLinearVelocity( 1, 1 )
        balls[i].x, balls[i].y = i*100, balls[i].radius
        balls[i].body:setX(i*100)
        balls[i].body:setY(balls[i].radius)
        
        
    end
end
