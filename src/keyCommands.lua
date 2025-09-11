function getKeypress()
    down = love.keyboard.isScancodeDown( "a" )
    if down then return "a" else return "" end
end

function moveCircle(coordinates, speed)
    --These are commands are used for getting the events for when the arrow keys are pressed
    downPressed = love.keyboard.isScancodeDown( "down" )
    upPressed = love.keyboard.isScancodeDown( "up" )
    rightPressed = love.keyboard.isScancodeDown( "right" )
    leftPressed = love.keyboard.isScancodeDown( "left" )
   
    if downPressed then return  {coordinates[1], coordinates[2] + speed}
    elseif upPressed then return  {coordinates[1], coordinates[2] - speed}
    elseif rightPressed then return  {coordinates[1] + speed, coordinates[2]}
    elseif leftPressed then return  {coordinates[1] - speed, coordinates[2]}
    else return coordinates end
    return coordinates
end
