-- if arg[2] == "debug" then
--     require("lldebugger").start()
-- end

-- print("it's Wednesday ma dudes")

-----------------------------------------------------
-- Load Function callback, called when program starts
-----------------------------------------------------
local world = love.physics.newWorld(0, 100, true)

function love.load()
    -- load in submodules
    timing = require('timing')
    keyCommands = require('keyCommands')
    cursor = require('cursor')
    board = require('board')
    ball = require('ball')
    
    -- Setup GLobal variables
    timeStart = love.timer.getTime()
    FPSCAP = 60
    DT = 1/1000 --miliseconds
    WINDOWX = 1000
    WINDOWY = 900
    BOARDSIZEPIXELS = 600
    PEGSIZEPIXELS = 10
    
    BOARDSTARTPOS = {WINDOWX/2 - BOARDSIZEPIXELS/2, WINDOWY/2 - BOARDSIZEPIXELS/2}
    success = love.window.setMode(WINDOWX, WINDOWY)
    board = love.graphics.newCanvas(WINDOWX, WINDOWY)
    pegLocCanvas = love.graphics.newCanvas(WINDOWX, WINDOWY)
    -- background = love.graphics.newImage('/Images/Backgrounds/VintageChessBoard.png')
    
    
    
    object = {}
    object.x, object.y = 450, 450
    object.w, object.h = 20, 20
    object.body = love.physics.newBody(world, object.x, object.y, "dynamic")
    object.shape = love.physics.newCircleShape(object.w/2)
    object.fixture = love.physics.newFixture(object.body, object.shape)
    object.body:setFixedRotation(true)
    

    -- Run initialization functions
    initBoardState(BOARDSTARTPOS[1], BOARDSTARTPOS[2], PEGSIZEPIXELS, BOARDSIZEPIXELS, world)

    

-- Setup Canvas for drawing background and the board
    love.graphics.setCanvas(board)
        love.graphics.clear(0, 0, 0, 0)
        love.graphics.setBlendMode("alpha")
        drawBoard(BOARDSTARTPOS, BOARDSIZEPIXELS, PEGSIZEPIXELS)
        love.graphics.setCanvas()
    
    -- Canvas for drawing the pegboard locations
    love.graphics.setCanvas(pegLocCanvas)
     love.graphics.clear(0, 0, 0, 0)
        love.graphics.setBlendMode("alpha")
        drawPegLocations(BOARDSTARTPOS, BOARDSIZEPIXELS, PEGSIZEPIXELS)
        love.graphics.setCanvas()
end




-----------------------------------------------------
-- Update Function callback
-----------------------------------------------------
function love.update(DT)
    -- Control frame rate
    world:update(DT)
    sleep(DT, FPSCAP)
    
    cursorX, cursorY = getCursorPosition()

    clickX, clickY = getMousePosOnClick()

    object.x, object.y = object.body:getPosition()
    -- object.body:applyForce(5, 5)


    
    
end


-----------------------------------------------------
-- Draw Function callback
-----------------------------------------------------
function love.draw()
    drawBalls(world)
    -- love.graphics.setColor(1,0,0)
    love.graphics.draw(board, 0, 0)
    love.graphics.draw(pegLocCanvas, 0, 0)
    love.graphics.circle("fill", object.x, object.y, object.w, object.h)
    love.graphics.print("Cursor Position ..." .. tostring(cursorX)..", "..tostring(cursorY), 40, 300)

    love.graphics.print("Current elapsed game time ..." .. tostring(elapsedTime()), 40, 100)
    love.graphics.print("Mouse clicked ..." .. tostring(clickX), 40, 350)

end