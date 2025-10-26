function updateRightFlipper(dt)
    -- want to apply a force if the right key is pressed
    
    if rightFlipper.activated == 1 then
        if rightFlipper.body:getAngle()*180/3.14 >= rightFlipper.upperStopAngle and rightKeyCheck() == 1 then
            rightFlipper.body:setFixedRotation(true)
            return
        end

        elseif rightFlipper.body:getAngle()*180/3.14 >= rightFlipper.upperStopAngle then
            rightFlipper.activated = 0
            rightFlipper.body:setFixedRotation(false)
            rightFlipper.body:applyLinearImpulse(-100000,100000)
            return
        end
    end

    elseif rightKeyCheck() == 1 then
        rightFlipper.activated = 1
        rightFlipper.body:setFixedRotation(false)
        rightFlipper.body:applyLinearImpulse(-100000,-100000)
        return
    end

    -- elseif rightKeyCheck() == 0 then
    --     rightFlipper.body:setFixedRotation(false)
    --     rightFlipper.body:applyLinearImpulse(-100000,100000)
    --     if rightFlipper.body:getAngle()*180/3.14 <= rightFlipper.lowerStopAngle then
    --         rightFlipper.body:setFixedRotation(true)
    --     end
    -- end
    -- return rightFlipper.angle
end