math = require("math")
world = require("world")

-- Can't use "bumpers" because for some reason it is considered a boolean value
bumps = {}

function initBumper(x, y)
    local world = getWorld()
    table.insert(bumps, {
    x = x,
    y = y,
    radius = 15,
    color = {1,0,0},
    bounce = 1.5,
    body = love.physics.newBody(world, x, y, "static"),
    shape = nil,
    fixture = nil,
    force = 750,
    scoreVal = 100
})

    bumps[#bumps].body = love.physics.newBody(world, x, y, "static")
    bumps[#bumps].shape = love.physics.newCircleShape(bumps[#bumps].radius)
    bumps[#bumps].fixture = love.physics.newFixture(bumps[#bumps].body, bumps[#bumps].shape,100)
    bumps[#bumps].body:setMass(100)
    bumps[#bumps].body:setFixedRotation(true)
    -- bumps[#bumps].fixture:setRestitution(bumps[#bumps].bounce)
    bumps[#bumps].fixture:setUserData("bumper")
    
end

function drawBumpers()
    for i, bumper in ipairs(bumps) do
        love.graphics.setColor(bumper.color)
        love.graphics.circle("fill", bumper.x, bumper.y, bumper.radius)
    end
end

function getBumperAppliedVel(ballVelX, ballVelY)
    if math.abs(ballVelX) > math.abs(ballVelY) then
        divisor = math.abs(ballVelX)
    else
        divisor = math.abs(ballVelY)
        
    end
    ix = ballVelX / divisor * bumps[1].force
    iy = ballVelY / divisor * bumps[1].force
    return ix, iy
end