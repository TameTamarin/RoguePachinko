utilities = require('utilities')
world = require("world")

local bodies = {}
local fixtures = {}
local radius = 1

function initTable(xOffset, yOffset)
    local points = load_xy_from_txt("edge_coordinates.txt")
    local world = getWorld()
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