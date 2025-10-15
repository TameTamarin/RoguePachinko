leftFlipper = {
    h = 20,
    w = 150,
    x = 800,
    y = 800,
    bounce = 0.5,
    color = "red",
    angle = 0,
    speed = 5,
    activated = 0,
    stopAngle = 0.5
}

rightFlipper = {
    h = 20,
    w = 150,
    x = 200,
    y = 800,
    bounce = 0.5,
    color = "red",
    angle = 3,
    speed = 5,
    activated = 0,
    stopAngle = 3.5

}


function initFlippers(world)
    rightFlipper.body = love.physics.newBody(world, rightFlipper.x, rightFlipper.y, "dynamic")
    rightFlipper.shape = love.physics.newRectangleShape(rightFlipper.w,rightFlipper.h)
    rightFlipper.fixture = love.physics.newFixture(rightFlipper.body, rightFlipper.shape, 100)
    rightFlipper.body:setFixedRotation(true)
    rightFlipper.fixture:setRestitution(rightFlipper.bounce)
    
    leftFlipper.body = love.physics.newBody(world, leftFlipper.x, leftFlipper.y, "dynamic")
    leftFlipper.shape = love.physics.newRectangleShape(leftFlipper.w,leftFlipper.h)
    leftFlipper.fixture = love.physics.newFixture(leftFlipper.body, leftFlipper.shape, 100)
    leftFlipper.body:setFixedRotation(true)
    leftFlipper.fixture:setRestitution(leftFlipper.bounce)
end

function drawRotatedRectangle(mode, x, y, width, height, angle)
	-- We cannot rotate the rectangle directly, but we
	-- can move and rotate the coordinate system.
	love.graphics.push()
	love.graphics.translate(x, y)
	love.graphics.rotate(angle)
	love.graphics.rectangle(mode, 0, 0, width, height) -- origin in the top left corner
--	love.graphics.rectangle(mode, -width/2, -height/2, width, height) -- origin in the middle
	love.graphics.pop()
end

function drawLeftFlipper(angle)
    drawRotatedRectangle("fill", leftFlipper.x, leftFlipper.y, leftFlipper.w, leftFlipper.h, angle)
end

function drawRightFlipper(angle)
    drawRotatedRectangle("fill", rightFlipper.x, rightFlipper.y, rightFlipper.w, rightFlipper.h, angle)
end


function activateFlipper()
    return
end

function updateLeftFlipper(dt)   
    if leftKeyCheck() == 1 or leftFlipper.activated == 1 then
        leftFlipper.activated = 1
        if leftFlipper.angle >= -leftFlipper.stopAngle then
            leftFlipper.angle = leftFlipper.angle - dt * leftFlipper.speed
        elseif leftFlipper.angle <= leftFlipper.stopAngle then
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
        if rightFlipper.angle <= rightFlipper.stopAngle then
            rightFlipper.angle = rightFlipper.angle + dt * rightFlipper.speed
        elseif rightFlipper.angle >= rightFlipper.stopAngle then
            rightFlipper.activated = 0
        end
    elseif rightKeyCheck() == 0 then
        rightFlipper.angle = 3
    end
    return rightFlipper.angle
end
    
