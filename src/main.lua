-- if arg[2] == "debug" then
--     require("lldebugger").start()
-- end

-- print("it's Wednesday ma dudes")

-----------------------------------------------------
-- Load Function callback, called when program starts
-----------------------------------------------------
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
    PEGSIZEPIXELS = 5
    
    BOARDSTARTPOS = {WINDOWX/2 - BOARDSIZEPIXELS/2, WINDOWY/2 - BOARDSIZEPIXELS/2}
    success = love.window.setMode(WINDOWX, WINDOWY)
    board = love.graphics.newCanvas(WINDOWX, WINDOWY)
    pegLocCanvas = love.graphics.newCanvas(WINDOWX, WINDOWY)
    -- background = love.graphics.newImage('/Images/Backgrounds/VintageChessBoard.png')
    
    -- Run initialization functions
    initBoardState(BOARDSTARTPOS[1], BOARDSTARTPOS[2], PEGSIZEPIXELS, BOARDSIZEPIXELS)

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
function love.update()
    -- Control frame rate
    sleep(DT, FPSCAP)
    
    cursorX, cursorY = getCursorPosition()

    clickX, clickY = getMousePosOnClick()


    
    
end


-----------------------------------------------------
-- Draw Function callback
-----------------------------------------------------
function love.draw()
    drawBalls()
    -- love.graphics.setColor(1,0,0)
    love.graphics.draw(board, 0, 0)
    love.graphics.draw(pegLocCanvas, 0, 0)
    love.graphics.print("Cursor Position ..." .. tostring(cursorX)..", "..tostring(cursorY), 40, 300)

    love.graphics.print("Current elapsed game time ..." .. tostring(elapsedTime()), 40, 100)
    love.graphics.print("Mouse clicked ..." .. tostring(clickX), 40, 350)
end