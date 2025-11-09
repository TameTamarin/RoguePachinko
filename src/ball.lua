require("math")

balls = {}
    

function initBall(world, x, y)
    table.insert(balls, {
    x = x,
    y = y,
    radius = 10,
    color = {1,0,0},
    bounce = 0.5,
    body = love.physics.newBody(world, x, y, "dynamic"),
    shape = nil,
    fixture = nil
})
    for i, ball in ipairs(balls) do
        balls[#balls].body = love.physics.newBody(world, x, y, "dynamic")
        balls[#balls].shape = love.physics.newCircleShape(balls[#balls].radius)
        balls[#balls].fixture = love.physics.newFixture(balls[#balls].body, balls[#balls].shape,100)
        balls[#balls].body:setMass(1)
        balls[#balls].body:setFixedRotation(true)
        balls[#balls].fixture:setRestitution(balls[#balls].bounce)
        balls[#balls].fixture:setUserData("ball")
        balls[#balls].fixture:setCategory(1)  -- set to category 1 for balls
        
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
        balls[i].x, balls[i].y = 578, 880
        balls[i].body:setX(balls[i].x)
        balls[i].body:setY(balls[i].y)
         
    end
end


function resetBallToRandomPos(xMin, xMax, yMin, yMax)
    for i, ball in ipairs(balls) do
        balls[i].body:setLinearVelocity( 1, 1 )
        balls[i].x, balls[i].y = math.random(xMin, xMax), math.random(yMin, yMax)
        balls[i].body:setX(balls[i].x)
        balls[i].body:setY(balls[i].y)
         
    end
end
