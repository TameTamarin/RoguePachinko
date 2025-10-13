rightFlipper = {
    h = 20,
    w = 50,
    x = 800,
    y = 800,
    bounce = 0.5,
    color = "red"
}

leftFlipper = {
    h = 20,
    w = 50,
    x = 200,
    y = 800,
    bounce = 0.5,
    color = "red"
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

function drawFlippers()
    love.graphics.rectangle("fill", rightFlipper.x, rightFlipper.y, rightFlipper.w, rightFlipper.h)
    love.graphics.rectangle("fill", leftFlipper.x, leftFlipper.y, leftFlipper.w, leftFlipper.h)
end


function activateFlipper()
    return
end