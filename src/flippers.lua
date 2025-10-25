leftFlipper = {
    h = 20,
    w = 100,
    x = 300,
    y = 800,
    anchorRadius = 10,
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
    w = 100,
    x = 400,
    y = 500,
    anchorRadius = 10,
    anchorh = 20,
    anchorw = 200,
    anchorx = 600,
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
    -- create teh bodies for the flipper and anchor
    rightFlipper.anchor = love.physics.newBody(world, rightFlipper.anchorx, rightFlipper.anchory, "static")
    rightFlipper.body = love.physics.newBody(world, rightFlipper.anchorx - rightFlipper.w/2 + rightFlipper.anchorRadius, rightFlipper.anchory + rightFlipper.h/2 - rightFlipper.anchorRadius, "dynamic")
    -- set the flipper angle
    rightFlipper.anchor:setAngle(rightFlipper.anchorAngle)
    -- create the shapes of each body
    rightFlipper.shape = love.physics.newRectangleShape(rightFlipper.w,rightFlipper.h)
    rightFlipper.anchorShape = love.physics.newCircleShape(rightFlipper.anchorRadius)
    -- add shapes to fixtures
    rightFlipper.fixture = love.physics.newFixture(rightFlipper.body, rightFlipper.shape, 100)
    rightFlipper.anchorFixture = love.physics.newFixture(rightFlipper.anchor, rightFlipper.anchorShape, 50)
    -- create the joint that the flipper will rotate around based on the location of the anchor
    rightFlipper.joint = love.physics.newRevoluteJoint(rightFlipper.anchor, rightFlipper.body, rightFlipper.anchorx, rightFlipper.anchory, false)
    -- set bouncyness of the flipper
    rightFlipper.fixture:setRestitution(rightFlipper.bounce)
    
    leftFlipper.anchor = love.physics.newBody(world, leftFlipper.anchorx, leftFlipper.anchory, "static")
    leftFlipper.body = love.physics.newBody(world, leftFlipper.anchorx - leftFlipper.w/2 + leftFlipper.anchorRadius, leftFlipper.anchory + leftFlipper.h/2 - leftFlipper.anchorRadius, "dynamic")
    -- set the flipper angle
    leftFlipper.anchor:setAngle(leftFlipper.anchorAngle)
    -- create the shapes of each body
    leftFlipper.shape = love.physics.newRectangleShape(leftFlipper.w,leftFlipper.h)
    leftFlipper.anchorShape = love.physics.newCircleShape(leftFlipper.anchorRadius)
    -- add shapes to fixtures
    leftFlipper.fixture = love.physics.newFixture(leftFlipper.body, leftFlipper.shape, 100)
    leftFlipper.anchorFixture = love.physics.newFixture(leftFlipper.anchor, leftFlipper.anchorShape, 50)
    -- create the joint that the flipper will rotate around based on the location of the anchor
    leftFlipper.joint = love.physics.newRevoluteJoint(leftFlipper.anchor, leftFlipper.body, leftFlipper.anchorx, leftFlipper.anchory, false)
    -- set bouncyness of the flipper
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
    bx, by = leftFlipper.body:getPosition()
    drawRotatedRectangle("fill", bx, by, leftFlipper.w, leftFlipper.h, leftFlipper.body:getAngle())
    bx, by = leftFlipper.anchor:getPosition()
    love.graphics.circle("fill", bx, by, leftFlipper.anchorRadius)
end

function drawRightFlipper(angle)
    bx, by = rightFlipper.body:getPosition()
    drawRotatedRectangle("fill", bx, by, rightFlipper.w, rightFlipper.h, rightFlipper.body:getAngle())
    bx, by = rightFlipper.anchor:getPosition()
    love.graphics.circle("fill", bx, by, rightFlipper.anchorRadius)
    
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

    if leftKeyCheck() == 1 or leftFlipper.activated == 1 then
        -- leftFlipper.activated = 1
        leftFlipper.body:applyLinearImpulse(-100000,-100000)

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
    
