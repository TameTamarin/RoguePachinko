require("math")
world = require("world")
utilities = require('utilities')


balls = {}


function initBall(xInit, yInit)
    local world = getWorld()
    table.insert(balls, {
        x = xInit,
        y = yInit,
        radius = 12,
        color = {1,0,0},
        bounce = 0.5,
        body = love.physics.newBody(world, xInit, yInit, "dynamic"),
        shape = nil,
        fixture = nil,
        mass = 100,
        friction = 0.1
    })
    for i, ball in ipairs(balls) do
        balls[#balls].body = love.physics.newBody(world, xInit, yInit, "dynamic")
        balls[#balls].shape = love.physics.newCircleShape(balls[#balls].radius)
        balls[#balls].fixture = love.physics.newFixture(balls[#balls].body, balls[#balls].shape,100)
        balls[#balls].body:setMass(balls[#balls].mass)
        balls[#balls].body:setFixedRotation(false)
        balls[#balls].fixture:setRestitution(balls[#balls].bounce)
        balls[#balls].fixture:setFriction(balls[#balls].friction)
        balls[#balls].fixture:setUserData("ball")
        balls[#balls].fixture:setCategory(1)  -- set to category 1 for balls
        
    end
end

image = love.graphics.newImage("images/8-bit-pokeball.png")
function spawnBallAtPlunger()
    local xInit = 476
    local yInit = 872
    local world = getWorld()
   
    table.insert(balls, {
        x = xInit,
        y = yInit,
        radius = 12,
        color = {1,0,0},
        bounce = 0.5,
        body = love.physics.newBody(world, xInit, yInit, "dynamic"),
        shape = nil,
        fixture = nil,
        mass = 100,
        friction = 0.1
    })
    
    -- for i, ball in ipairs(balls) do
        balls[#balls].body = love.physics.newBody(world, xInit, yInit, "dynamic")
        balls[#balls].shape = love.physics.newCircleShape(balls[#balls].radius)
        balls[#balls].fixture = love.physics.newFixture(balls[#balls].body, balls[#balls].shape,100)
        balls[#balls].body:setMass(balls[#balls].mass)
        balls[#balls].body:setFixedRotation(false)
        balls[#balls].fixture:setRestitution(balls[#balls].bounce)
        balls[#balls].fixture:setFriction(balls[#balls].friction)
        balls[#balls].fixture:setUserData("ball")
        balls[#balls].fixture:setCategory(1)  -- set to category 1 for balls
        
    -- end


    writeToLogFile("spawnBallAtPlunger", nil)
end

function drawBalls()
    for i, ball in ipairs(balls) do
        love.graphics.setColor(ball.color)
        love.graphics.circle("fill", ball.x, ball.y, ball.radius)
        local rot = ball.body:getAngle()
        love.graphics.draw(image, ball.x, ball.y, rot, 1, 1, ball.radius, ball.radius)
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

function getNumBalls()
    return #balls
end

function ballApplyForce(ballIndex, forceVal, angle)
    radAngle = math.rad(angle)    
    iy = math.sin(radAngle)*forceVal
    ix = math.cos(radAngle)*forceVal
    balls[ballIndex].body:applyLinearImpulse(ix, iy)
end

function ballSetVelocityWAngle(ballIndex, forceVal, angle)
    -- This function is used to set the linear velocity of a ball
    -- with a specific angle and from the index of the balls table
    radAngle = math.rad(angle)    
    iy = math.sin(radAngle)*forceVal
    ix = math.cos(radAngle)*forceVal
    balls[ballIndex].body:setLinearVelocity(ix, iy)
end

function ballSetBodyVelocityWAngle(ballBody, forceVal, angle)
    -- This function is used to set the linear velocity of a ball
    -- with a specific angle and from the index of the balls table
    radAngle = math.rad(angle)    
    iy = math.sin(radAngle)*forceVal
    ix = math.cos(radAngle)*forceVal
    ballBody:setLinearVelocity(ix, iy)
end

function ballSetVelocityWComponents(ballIndex, ix, iy)
    balls[ballIndex].body:setLinearVelocity(ix, iy)
end

function ballSetBodyVelocityWComponents(ballBody, ix, iy)
    -- This function is used to set the linear velocity of a ball's
    -- body with a set of x and y vel components
    ballBody:setLinearVelocity(ix, iy)
end

function getBallVelocity(ballIndex)
    return balls[ballIndex].body:getLinearVelocity()
end


function getBallVelocityFromBody(ballBody)
    return ballBody:getLinearVelocity()
end


function resetBallPosition()
    for i, ball in ipairs(balls) do
        balls[i].body:setLinearVelocity( 1, 1 )
        balls[i].x, balls[i].y = 476, 872
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

function destroyBall(i)
    balls[i].body:release()
    balls[i].fixture:destroy()
    table.remove(balls,i)
end

function destroyAllBalls()
    for i = 1, #balls do
        destroyBall(i)
    end
end

function setAllBallSleep(sleep)
    for i, ball in ipairs(balls) do
        balls[i].body:setAwake(sleep)
    end
end