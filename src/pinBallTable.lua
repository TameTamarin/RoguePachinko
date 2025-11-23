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

