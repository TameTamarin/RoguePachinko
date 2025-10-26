require "math"


balls = {
    {x=250, y=150, radius=10, color={1,0,0}, bounce = 0.5},
    {x=300, y=150, radius=10, color={0,1,0}, bounce = 0.5},
    {x=400, y=150, radius=10, color={0,0,1}, bounce = 0.5},
    {x=500, y=150, radius=10, color={1,1,0}, bounce = 0.5},
    {x=600, y=150, radius=10, color={0,1,1}, bounce = 0.5},
}
    

function initBalls(world)
    for i, ball in ipairs(balls) do
        ball.body = love.physics.newBody(world, ball.x, ball.y, "dynamic")
        ball.shape = love.physics.newCircleShape(ball.radius)
        ball.fixture = love.physics.newFixture(ball.body, ball.shape,100)
        ball.body:setMass(100)
        ball.body:setFixedRotation(true)
        ball.fixture:setRestitution(ball.bounce)
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

function updateBallParameter(i, param, val)
    balls[i][param] = val
end

function updateBallBounce(i, val)
    balls[i].fixture:setRestitution(val)
end

function getBallPos(ballIndex)
    return balls[ballIndex].x, balls[ballIndex].y
end

function ballApplyForce(ballIndex, forceVal, angle)
    radAngle = math.rad(angle)    
    iy = math.sin(radAngle)*forceVal
    ix = math.cos(radAngle)*forceVal
    balls[ballIndex].body:applyLinearImpulse(ix, iy)
end

function resetBallPosition()
    for i, ball in ipairs(balls) do
        balls[i].body:setLinearVelocity( 1, 1 )
        balls[i].x, balls[i].y = i*100, balls[i].radius +150
        balls[i].body:setX(i*100)
        balls[i].body:setY(balls[i].y)
        
        
    end
end
