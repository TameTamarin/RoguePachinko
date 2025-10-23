leftFlipper = {
    h = 20,
    w = 200,
    x = 300,
    y = 800,
    anchorh = 20,
    anchorw = 200,
    anchorx = 300,
    anchory = 800,
    anchorAngle = 45,
    bounce = 0.5,
    color = "red",
    angle = 0,
    speed = 5,
    activated = 0,
    stopAngle = 0.5
}

rightFlipper = {
    h = 20,
    w = 200,
    x = 400,
    y = 500,
    anchorh = 20,
    anchorw = 200,
    anchorx = 400,
    anchory = 500,
    anchorAngle = -45,
    bounce = 0.5,
    color = "red",
    angle = 0,
    speed = 5,
    activated = 0,
    stopAngle = 0.5

}


function initFlippers(world)
    rightFlipper.body = love.physics.newBody(world, rightFlipper.x, rightFlipper.y, "dynamic")
    rightFlipper.anchor = love.physics.newBody(world, rightFlipper.anchorx, rightFlipper.anchory, "static")
    rightFlipper.anchor:setAngle(rightFlipper.anchorAngle)
    rightFlipper.joint = love.physics.newRevoluteJoint(rightFlipper.anchor,rightFlipper.body, rightFlipper.x + rightFlipper.w/2, rightFlipper.y+rightFlipper.h/2, true)
    rightFlipper.shape = love.physics.newRectangleShape(rightFlipper.w,rightFlipper.h)
    rightFlipper.anchorShape = love.physics.newRectangleShape(rightFlipper.anchorw,rightFlipper.anchorh)
    rightFlipper.fixture = love.physics.newFixture(rightFlipper.body, rightFlipper.shape, 100)
    rightFlipper.anchorFixture = love.physics.newFixture(rightFlipper.anchor, rightFlipper.anchorShape, 50)
    rightFlipper.fixture:setRestitution(rightFlipper.bounce)
    
    leftFlipper.body = love.physics.newBody(world, leftFlipper.x, leftFlipper.y, "dynamic")
    leftFlipper.shape = love.physics.newRectangleShape(leftFlipper.w,leftFlipper.h)
    leftFlipper.fixture = love.physics.newFixture(leftFlipper.body, leftFlipper.shape, 100)
    leftFlipper.fixture:setRestitution(leftFlipper.bounce)
end

function drawRotatedRectangle(mode, x, y, width, height, angle)
	-- We cannot rotate the rectangle directly, but we
	-- can move and rotate the coordinate system.
	love.graphics.push()
	love.graphics.translate(x, y)
	love.graphics.rotate(angle)
	-- love.graphics.rectangle(mode, 0, 0, width, height) -- origin in the top left corner
	love.graphics.rectangle(mode, -width/2, -height/2, width, height) -- origin in the middle
	love.graphics.pop()
end

function getRgtFlipAnchorCorner()
    return
end

function drawLeftFlipper(angle)
    drawRotatedRectangle("fill", leftFlipper.x, leftFlipper.y, leftFlipper.w, leftFlipper.h, angle)
    leftFlipper.body:setAngle(angle)
    leftFlipper.body:setPosition(leftFlipper.x, leftFlipper.y)
    -- bx, by = leftFlipper.body:getPosition()
end

function drawRightFlipper(angle)
    -- rightFlipper.body:setAngle(angle)
    -- bx, by = rightFlipper.body:getPosition()
    -- drawRotatedRectangle("fill", bx, by, rightFlipper.w, rightFlipper.h, angle)
    
    bx, by = rightFlipper.body:getPosition()
    drawRotatedRectangle("fill", bx, by, rightFlipper.w, rightFlipper.h, rightFlipper.body:getAngle())
    bx, by = rightFlipper.anchor:getPosition()
    drawRotatedRectangle("fill", bx, by, rightFlipper.anchorw, rightFlipper.anchorh, rightFlipper.anchor:getAngle())
    
end

function getLeftFlipperPos()
    return leftFlipper.x, leftFlipper.y
end

function getRightFlipperPos()
    return rightFlipper.x, rightFlipper.y
end

function activateFlipper()
    if rightKeyCheck() == 1 or rightFlipper.activated == 1 then
        -- rightFlipper.activated = 1
        rightFlipper.body:applyLinearImpulse(-100000,-100000)

    end
end

function updateLeftFlipper(dt)
    -- check if the key for flipper has been pressed
    -- or is still pressed
    -- we keep the flipper activated until full activation angle achieved
    -- similar to how a normal pinball machine works   
    if leftKeyCheck() == 1 or leftFlipper.activated == 1 then
        leftFlipper.activated = 1
        if leftFlipper.angle >= -leftFlipper.stopAngle then
            leftFlipper.angle = leftFlipper.angle - dt * leftFlipper.speed
        elseif leftFlipper.angle <= leftFlipper.stopAngle then
            -- deactivate the flipper if key depressed
            leftFlipper.activated = 0
        end
    elseif leftKeyCheck() == 0 then
        leftFlipper.angle = 0
    end
    return leftFlipper.angle
end

function updateRightFlipper(dt)
    if rightKeyCheck() == 1 or rightFlipper.activated == 1 then
        rightFlipper.activated = 1
        if rightFlipper.angle >= -rightFlipper.stopAngle then
            rightFlipper.angle = rightFlipper.angle - dt * rightFlipper.speed
        elseif rightFlipper.angle <= rightFlipper.stopAngle then
            rightFlipper.activated = 0
        end
    elseif rightKeyCheck() == 0 then
        rightFlipper.angle = 0
    end
    return rightFlipper.angle
end
    
