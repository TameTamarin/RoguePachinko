math = require('math')
utilities = require('utilities')
world = require("world")

local bodies = {}
local fixtures = {}
local radius = 1

function initTable(xOffset, yOffset)
    local world = getWorld()
    local points = load_xy_from_txt("edge_coordinates.txt")
    for _, pt in ipairs(points) do
        -- Create a static body at each point
        local body = love.physics.newBody(world, pt.x + xOffset, pt.y + yOffset, "static")
        -- Attach a circle fixture to the body
        local shape = love.physics.newCircleShape(radius)
        local fixture = love.physics.newFixture(body, shape)
        fixture:setCategory(3)  -- set to category 3 for walls
        table.insert(bodies, body)
        table.insert(fixtures, fixture)
    end
end

function drawTable()
    -- love.graphics.setColor(0, 0.5, 1)
    for _, body in ipairs(bodies) do
        local x, y = body:getPosition()
        love.graphics.circle("fill", x, y, radius)
    end
end



function initPlunger()
    local xInit = 475
    local yInit = 950
    local world = getWorld()
    plunger = {
        x = xInit,
        y = yInit,
        h = 20,
        w = 20,
        color = {1,0,0},
        bounce = 0.5,
        body = nil,
        shape = nil,
        fixture = nil,
        mass = 1000
    }
  
    plunger.body = love.physics.newBody(world, xInit, yInit, "static")
    plunger.shape = love.physics.newRectangleShape(plunger.w , plunger.h)
    plunger.fixture = love.physics.newFixture(plunger.body, plunger.shape, 100)
    plunger.fixture:setUserData("plunger")
end

function drawPlunger()
    plunger.x, plunger.y = plunger.body:getPosition()
    love.graphics.rectangle('fill', plunger.x - plunger.w/2, plunger.y - plunger.h/2, plunger.w, plunger.h)
end


function initOutOfBounds()
    -- Out of bounds detector that is used to detect when the ball falls out of the play area on collision
    local xInit = 400
    local yInit = 1100
    local world = getWorld()
    outOfBounds = {
        x = xInit,
        y = yInit,
        h = 10,
        w = 1000,
        color = {1,0,0},
        body = nil,
        shape = nil,
        fixture = nil,
        mass = 10
    }
  
    outOfBounds.body = love.physics.newBody(world, xInit, yInit, "static")
    outOfBounds.shape = love.physics.newRectangleShape(outOfBounds.w , outOfBounds.h)
    outOfBounds.fixture = love.physics.newFixture(outOfBounds.body, outOfBounds.shape, 100)
    outOfBounds.fixture:setUserData("outOfBounds")
end

function drawOutOfBounds()
    outOfBounds.x, outOfBounds.y = outOfBounds.body:getPosition()
    love.graphics.rectangle('fill', outOfBounds.x - outOfBounds.w/2, outOfBounds.y - outOfBounds.h/2, outOfBounds.w, outOfBounds.h)
end


function initUpgradeTarget()
    local xInit = love.math.random(50, 300)
    -- local yInit = love.math.random(350, 500)
    local yInit = 800
    local world = getWorld()
    upgradeTarget = {
        x = xInit,
        y = yInit,
        h = 20,
        w = 20,
        color = {0,1,0},
        body = nil,
        shape = nil,
        fixture = nil,
        mass = 10
    }
  
    upgradeTarget.body = love.physics.newBody(world, xInit, yInit, "static")
    upgradeTarget.shape = love.physics.newRectangleShape(upgradeTarget.w , upgradeTarget.h)
    upgradeTarget.fixture = love.physics.newFixture(upgradeTarget.body, upgradeTarget.shape, 100)
    upgradeTarget.fixture:setUserData("upgradeTarget")
end

function drawUpgradeTarget()
    upgradeTarget.x, upgradeTarget.y = upgradeTarget.body:getPosition()
    love.graphics.rectangle('fill', upgradeTarget.x - upgradeTarget.w/2, upgradeTarget.y - upgradeTarget.h/2, upgradeTarget.w, upgradeTarget.h)
end

function destroyUpgradeTarget()
    upgradeTarget.body:release()
    upgradeTarget.fixture:destroy()
end

scoreBuckets = {}

function initScoreBuckets(x, y, w)
    local world = getWorld()
    table.insert(scoreBuckets, {
    x = x,
    y = y,
    h = 5,
    w = w,
    color = {1,0,0},
    bounce = 1.5,
    body = nil,
    sideWallBody = nil,
    sideWallH = 50,
    sideWallW = 5,
    shape = nil,
    fixture = nil,
    force = 150,
    scoreVal = 100
})

    scoreBuckets[#scoreBuckets].body = love.physics.newBody(world, x + scoreBuckets[#scoreBuckets].w/2, y, "static")
    scoreBuckets[#scoreBuckets].shape = love.physics.newRectangleShape(scoreBuckets[#scoreBuckets].w - scoreBuckets[#scoreBuckets].sideWallW, scoreBuckets[#scoreBuckets].h)
    scoreBuckets[#scoreBuckets].fixture = love.physics.newFixture(scoreBuckets[#scoreBuckets].body, scoreBuckets[#scoreBuckets].shape,100)
    scoreBuckets[#scoreBuckets].body:setMass(100)
    scoreBuckets[#scoreBuckets].body:setFixedRotation(true)
    -- scoreBuckets[#scoreBuckets].fixture:setRestitution(scoreBuckets[#scoreBuckets].bounce)
    scoreBuckets[#scoreBuckets].fixture:setUserData("scoreBucket" .. #scoreBuckets)

    scoreBuckets[#scoreBuckets].sideWallBody = love.physics.newBody(world, x + scoreBuckets[#scoreBuckets].w/2 + scoreBuckets[#scoreBuckets].sideWallW/2, y - scoreBuckets[#scoreBuckets].sideWallH/2, "static")
    scoreBuckets[#scoreBuckets].shape = love.physics.newRectangleShape(scoreBuckets[#scoreBuckets].sideWallW, scoreBuckets[#scoreBuckets].sideWallH)
    scoreBuckets[#scoreBuckets].fixture = love.physics.newFixture(scoreBuckets[#scoreBuckets].sideWallBody, scoreBuckets[#scoreBuckets].shape,100)
end

function editScoreBucketValue(index, newScoreVal)
    scoreBuckets[index].scoreVal = newScoreVal
end

function drawScoreBuckets()
    for i, bucket in ipairs(scoreBuckets) do
        love.graphics.setColor(bucket.color)
        love.graphics.rectangle("fill", bucket.x - bucket.w/2, bucket.y - bucket.h/2, bucket.w, bucket.h)
        love.graphics.rectangle("fill", bucket.sideWallBody:getX() - bucket.sideWallW/2, bucket.sideWallBody:getY() - bucket.sideWallH/2, bucket.sideWallW, bucket.sideWallH)
        love.graphics.print("" .. tostring(bucket.scoreVal), bucket.x, bucket.y - 20)
    end
end