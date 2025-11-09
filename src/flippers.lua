require "utilities"


----------------------------------------------------------------
-- 
-- Data structure for each flippers attributes
--
----------------------------------------------------------------
leftFlipper = {
    h = 15,
    w = 150,
    -- the anchor is the axis of rotation and the origin of the flipper
    anchorRadius = 10,
    anchorh = 20,
    anchorw = 200,
    anchorx = 200,
    anchory = 720,
    anchorAngle = 45,
    bounce = 0.5,
    color = "red",
    angle = 0,
    angularVelocity = -45,
    activated = 0,
    upperStopAngle = -385,
    lowerStopAngle = -335,
    keyCommand = leftKeyCheck,
    mass = 10
}

rightFlipper = {
    h = 0,
    w = 150,
    -- the anchor is the axis of rotation and the origin of the flipper
    anchorRadius = 10,
    anchorh = 20,
    anchorw = 200,
    anchorx = 700,
    anchory = 720,
    anchorAngle = 0,
    bounce = 0.5,
    color = "red",
    angle = 0,
    angularVelocity = 45,
    activated = 0,
    upperStopAngle = 25,
    lowerStopAngle = -25,
    keyCommand = rightKeyCheck,
    mass = 10

}

function setLeftFlipperDim(h, w, x, y)
    leftFlipper.h = h
    leftFlipper.w = w
    leftFlipper.anchorx = x
    leftFlipper.anchory = y
end


function setRightFlipperDim(h, w, x, y)
    rightFlipper.h = h
    rightFlipper.w = w
    rightFlipper.anchorx = x
    rightFlipper.anchory = y
end


----------------------------------------------------------------
-- 
-- Initialization of each flipper
--
----------------------------------------------------------------
function initFlippers(world)

    rightFlipper.anchor = love.physics.newBody(world, rightFlipper.anchorx, rightFlipper.anchory + rightFlipper.anchorRadius, "static")
    rightFlipper.body = love.physics.newBody(world, rightFlipper.anchorx - rightFlipper.w/2, rightFlipper.anchory + rightFlipper.h/2 - rightFlipper.anchorRadius, "dynamic")
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
    rightFlipper.body:setAngle(rightFlipper.lowerStopAngle * 3.14 / 180)
    rightFlipper.body:setMass(rightFlipper.mass)
    rightFlipper.anchor:setMass(rightFlipper.mass)
    -- set to category 2 for flippers, will be used in collision filtering
    rightFlipper.fixture:setCategory(2)
    rightFlipper.fixture:setMask(3)  -- ignore collisions with walls (category 3)

    leftFlipper.anchor = love.physics.newBody(world, leftFlipper.anchorx, leftFlipper.anchory + leftFlipper.anchorRadius, "static")
    leftFlipper.body = love.physics.newBody(world, leftFlipper.anchorx + leftFlipper.w/2, leftFlipper.anchory + leftFlipper.h/2 - leftFlipper.anchorRadius, "dynamic")
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
    -- set user data, tag to be used for collision detections
    leftFlipper.fixture:setUserData("leftFlipper")
    leftFlipper.body:setAngle(leftFlipper.lowerStopAngle * 3.14 / 180)
    leftFlipper.body:setMass(leftFlipper.mass)
    leftFlipper.anchor:setMass(leftFlipper.mass)
    -- set to category 2 for flippers, will be used in collision filtering
    leftFlipper.fixture:setCategory(2)
    leftFlipper.fixture:setMask(3)  -- ignore collisions with walls (category 3)
end

function initSpnningObject(world)
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

function getRgtFlipAngle()
    return rightFlipper.body:getAngle()
end

function getLftFlipAngle()
    return leftFlipper.body:getAngle()
end


function getRgtFlipAnchorCorner()
    return
end

----------------------------------------------------------------
-- 
-- Drawing flippers
--
----------------------------------------------------------------
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


----------------------------------------------------------------
-- 
-- Returning the data structure for each flipper
--
----------------------------------------------------------------
function getLeftFlipper()
    return leftFlipper
end

function getRightFlipper()
    return rightFlipper
end


----------------------------------------------------------------
-- 
-- Returning each flipper position
--
----------------------------------------------------------------
function getLeftFlipperPos()
    return leftFlipper.x, leftFlipper.y
end

function getRightFlipperPos()
    return rightFlipper.x, rightFlipper.y
end



----------------------------------------------------------------
-- 
-- Updating the flippers after they have been
-- activated by the cooresponding command
--
----------------------------------------------------------------
function updateRightFlipper()
    -- check if the flipper has been activated
    if rightFlipper.activated == 1 then
        -- if the angle of the flipper has met its maximum angle and the key is still pressed
        -- then hold the flipper at that angle
        if rightFlipper.body:getAngle()*180/3.14 >= rightFlipper.upperStopAngle and rightFlipper.keyCommand() == 1 then
            rightFlipper.body:setFixedRotation(true)
            rightFlipper.body:setAngle(rightFlipper.upperStopAngle * 3.14 / 180)
            return  
        
        -- if the flipper has reached its max point WITHOUT the key still pressed
        -- then deactivate the flipper, make sure its rotation is not frozen, and set the velocity to reverse
        elseif rightFlipper.body:getAngle()*180/3.14 >= rightFlipper.upperStopAngle then
            rightFlipper.activated = 0
            rightFlipper.body:setFixedRotation(false)
            rightFlipper.body:setAngularVelocity(-rightFlipper.angularVelocity)
            return

        else
            -- if the flipper has been activated then this is here to ensure that the flipper continues
            -- rotating till it reaches its max angle
            rightFlipper.body:setAngularVelocity(rightFlipper.angularVelocity)
        end
    
    -- when the key is pressed and we are below the max angle then activate the flipper and ensure that rotation is not frozen
    elseif rightFlipper.keyCommand() == 1 and rightFlipper.body:getAngle()*180/3.14 < rightFlipper.upperStopAngle - 5 then
        rightFlipper.activated = 1
        rightFlipper.body:setFixedRotation(false)
        rightFlipper.body:setAngularVelocity(rightFlipper.angularVelocity)
        return
    
    -- if the flipper is ever lower than the lower stop angle then freeze it in place
    elseif rightFlipper.body:getAngle()*180/3.14 <= rightFlipper.lowerStopAngle then
        rightFlipper.body:setFixedRotation(true)
        rightFlipper.body:setAngle(rightFlipper.lowerStopAngle * 3.14 / 180)
    
    -- if the flipper ever reaches an angle above the upper stop angle then reverse the velocity
    elseif rightFlipper.body:getAngle()*180/3.14 > rightFlipper.upperStopAngle then
        rightFlipper.body:setAngularVelocity(-rightFlipper.angularVelocity)
        
    -- if there is non of the other logic is tripped then ensure that the flipper is deactivated
    else
        rightFlipper.activated = 0
    end
end


function updateLeftFlipper()
    -- check if the flipper has been activated
    if leftFlipper.activated == 1 then
        -- if the angle of the flipper has met its maximum angle and the key is still pressed
        -- then hold the flipper at that angle
        if leftFlipper.body:getAngle()*180/3.14 <= leftFlipper.upperStopAngle and leftFlipper.keyCommand() == 1 then
            leftFlipper.body:setFixedRotation(true)
            leftFlipper.body:setAngle(leftFlipper.upperStopAngle * 3.14 / 180)
            return  
        
        -- if the flipper has reached its max point WITHOUT the key still pressed
        -- then deactivate the flipper, make sure its rotation is not frozen, and set the velocity to reverse
        elseif leftFlipper.body:getAngle()*180/3.14 <= leftFlipper.upperStopAngle then
            leftFlipper.activated = 0
            leftFlipper.body:setFixedRotation(false)
            leftFlipper.body:setAngularVelocity(-leftFlipper.angularVelocity)
            return

        else
            -- if the flipper has been activated then this is here to ensure that the flipper continues
            -- rotating till it reaches its max angle
            leftFlipper.body:setAngularVelocity(leftFlipper.angularVelocity)
        end
    
    -- when the key is pressed and we are below the max angle then activate the flipper and ensure that rotation is not frozen
    elseif leftFlipper.keyCommand() == 1 and leftFlipper.body:getAngle()*180/3.14 > leftFlipper.upperStopAngle - 5 then
        leftFlipper.activated = 1
        leftFlipper.body:setFixedRotation(false)
        leftFlipper.body:setAngularVelocity(leftFlipper.angularVelocity)
        return
    
    -- if the flipper is ever lower than the lower stop angle then freeze it in place
    elseif leftFlipper.body:getAngle()*180/3.14 >= leftFlipper.lowerStopAngle then
        leftFlipper.body:setFixedRotation(true)
        leftFlipper.body:setAngle(leftFlipper.lowerStopAngle * 3.14 / 180)
    
    -- if the flipper ever reaches an angle above the upper stop angle then reverse the velocity
    elseif leftFlipper.body:getAngle()*180/3.14 < leftFlipper.upperStopAngle then
        leftFlipper.body:setAngularVelocity(-leftFlipper.angularVelocity)
        
    -- if there is non of the other logic is tripped then ensure that the flipper is deactivated
    else
        leftFlipper.activated = 0
    end
end


------ This code doesn't work properly when calling the left flipper

function updateFlipper(flipper)
    -- check if the flipper has been activated
    if flipper.activated == 1 then
        -- if the angle of the flipper has met its maximum angle and the key is still pressed
        -- then hold the flipper at that angle
        if flipper.body:getAngle()*180/3.14 >= flipper.upperStopAngle and flipper.keyCommand() == 1 then
            flipper.body:setFixedRotation(true)
            return  
        
        -- if the flipper has reached its max point WITHOUT the key still pressed
        -- then deactivate the flipper, make sure its rotation is not frozen, and set the velocity to reverse
        elseif flipper.body:getAngle()*180/3.14 <= flipper.upperStopAngle then
            flipper.activated = 0
            flipper.body:setFixedRotation(false)
            flipper.body:setAngularVelocity(-flipper.angularVelocity)
            return

        else
            -- if the flipper has been activated then this is here to ensure that the flipper continues
            -- rotating till it reaches its max angle
            flipper.body:setAngularVelocity(flipper.angularVelocity)
        end
    
    -- when the key is pressed and we are below the max angle then activate the flipper and ensure that rotation is not frozen
    elseif flipper.keyCommand() == 1 and flipper.body:getAngle()*180/3.14 > flipper.upperStopAngle - 5 then
        flipper.activated = 1
        flipper.body:setFixedRotation(false)
        flipper.body:setAngularVelocity(flipper.angularVelocity)
        return
    
    -- if the flipper is ever lower than the lower stop angle then freeze it in place
    elseif flipper.body:getAngle()*180/3.14 >= flipper.lowerStopAngle then
        flipper.body:setFixedRotation(true)
    
    -- if the flipper ever reaches an angle above the upper stop angle then reverse the velocity
    elseif flipper.body:getAngle()*180/3.14 < flipper.upperStopAngle then
        flipper.body:setAngularVelocity(-flipper.angularVelocity)
        
    -- if there is non of the other logic is tripped then ensure that the flipper is deactivated
    else
        flipper.activated = 0
    end
end