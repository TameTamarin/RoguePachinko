-- if arg[2] == "debug" then
--     require("lldebugger").start()
-- end

-- print("it's Wednesday ma dudes")


-----------------------------------------------------
-- Global Variables
-----------------------------------------------------
FPSCAP = 60
DT = 1/1000 --miliseconds
WINDOWX = 1000
WINDOWY = 900
BOARDSIZEPIXELS = 600
PEGSIZEPIXELS = 10
XGRAVITY = 0
YGRAVITY = 500
BOARDSTARTPOS = {WINDOWX/2 - BOARDSIZEPIXELS/2, WINDOWY/2 - BOARDSIZEPIXELS/2}

-----------------------------------------------------
-- Load Function callback
-- 
--  This fuction is called at the beginning of the
--  game start and runs only once
-----------------------------------------------------
function love.load()
    -- load in submodules
    timing = require('timing')
    keyCommands = require('keyCommands')
    cursor = require('cursor')
    board = require('board')
    ball = require('ball')
    boardElements = require('flippers')
    
    -- Init the in game timer
    timeStart = love.timer.getTime()

    -- Set the window size 
    success = love.window.setMode(WINDOWX, WINDOWY, {vsync = 1})
    
    -- Setup the world and its fucntion callbacks
    world = love.physics.newWorld(XGRAVITY, YGRAVITY, true)
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    -- Run initialization functions
    -- initBoard(10, 15, BOARDSTARTPOS[1], BOARDSTARTPOS[2], BOARDSIZEPIXELS)
    -- setLeftWallDim(BOARDSIZEPIXELS, 10, BOARDSTARTPOS[1] - PEGSIZEPIXELS, BOARDSTARTPOS[2] + BOARDSIZEPIXELS/2)
    -- setRightWallDim(BOARDSIZEPIXELS, 10, BOARDSTARTPOS[1] + BOARDSIZEPIXELS + PEGSIZEPIXELS, BOARDSTARTPOS[2] + BOARDSIZEPIXELS/2)
    -- setFloorDim(10, BOARDSIZEPIXELS, BOARDSTARTPOS[1] + BOARDSIZEPIXELS/2, BOARDSTARTPOS[2] + BOARDSIZEPIXELS)
    setLeftWallDim(BOARDSIZEPIXELS, 10, 200, 100 + BOARDSIZEPIXELS/2)
    setRightWallDim(BOARDSIZEPIXELS, 10, 700, 100 + BOARDSIZEPIXELS/2)
    setFloorDim(10, BOARDSIZEPIXELS, BOARDSTARTPOS[1] + BOARDSIZEPIXELS/2, BOARDSTARTPOS[2] + BOARDSIZEPIXELS)
    setCeilingDim(10, BOARDSIZEPIXELS, 450, 100)
    

    
    -- initBoardState(PEGSIZEPIXELS, world)
    initBalls(world)
    initLeftWall(world)
    initRightWall(world)
    -- initFloor(world)
    initCeiling(world)

    initFlippers(world)


-- Setup Canvases for drawing background and the board
    backgroundObjects = love.graphics.newCanvas(WINDOWX, WINDOWY)
    pegLocCanvas = love.graphics.newCanvas(WINDOWX, WINDOWY)

    love.graphics.setCanvas(backgroundObjects)
        love.graphics.clear(0, 0, 0, 0)
        love.graphics.setBlendMode("alpha")
        -- drawBoard(BOARDSTARTPOS, BOARDSIZEPIXELS, PEGSIZEPIXELS)
        drawLeftWall()
        drawRightWall()
        -- drawFloor()
        drawCeiling()
        drawButtons()
        love.graphics.setCanvas()
    
    -- Canvas for drawing the pegboard locations
    love.graphics.setCanvas(pegLocCanvas)
     love.graphics.clear(0, 0, 0, 0)
        love.graphics.setBlendMode("alpha")
        -- drawPegLocations(BOARDSTARTPOS, BOARDSIZEPIXELS, PEGSIZEPIXELS)
        love.graphics.setCanvas()

   
end


-----------------------------------------------------
-- Run Function Callback
--
-- This is the main loop of the program.
-----------------------------------------------------
function love.run()
	if love.load then love.load(love.arg.parseGameArguments(arg), arg) end

	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end

	local dt = 0

	-- Main loop time.
	return function()
		-- Process events.
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a or 0
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end

		-- Update dt, as we'll be passing it to update
		if love.timer then dt = love.timer.step() end

		-- Call update and draw
		if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled

		if love.graphics and love.graphics.isActive() then
			love.graphics.origin()
			love.graphics.clear(love.graphics.getBackgroundColor())

			if love.draw then love.draw() end

			love.graphics.present()
		end

		if love.timer then love.timer.sleep(0.001) end
	end
end


-----------------------------------------------------
-- World Function callbacks
--
-- Functions that run when specific tagged events 
-- occur in the world.
--
-- These funcitons need to match the listed functions
-- in the world creation.
-----------------------------------------------------
function beginContact(a, b, coll)

end


function endContact(a, b, coll)
    
end

function preSolve(a, b, coll)
   
end

function postSolve(a, b, coll, normalimpulse, tangentimpulse)

end


-----------------------------------------------------
-- Update Function callback
-- 
-- This function runs on every interation of the
-- main loop.
-----------------------------------------------------
row = nil
collumn = nil

local rightFlipperAngle = 0
local leftFlipperAngle = 0
function love.update(dt)
    -- Control frame rate
    world:update(dt)
    -- sleep(DT, FPSCAP)

    -- updateFlipper(getRightFlipper())
    -- updateFlipper(getLeftFlipper())
    updateLeftFlipper()
    updateRightFlipper()
    -- activateFlipper(dt)
    cursorX, cursorY = getCursorPosition()

    clickX, clickY = getMousePosOnClick()

    if checkMouseClick() then
        if clickX <= 75 and clickX >= 25 and clickY <= 125 and clickY >= 75 then
            resetBallPosition()
        end

        -- row , collumn = getSelectedSpace(clickX, clickY, PEGSIZEPIXELS)

        -- updateSpaceParameter(row, collumn)

        -- updateBallBounce(2, 2)
    end

    updateBallsLocations()

    ballPosX, ballPosY = getBallPos(1)
    leftFlipperX, leftFlipperY = getLeftFlipperPos()
    rightFlipperX, rightFlipperY = getRightFlipperPos()

    
end


-----------------------------------------------------
-- Draw Function callback
-- 
-- Draws shapes onto the screen.  Runs once every
-- interation of the main loop.
-----------------------------------------------------
function love.draw()
    drawBalls(world)
    drawLeftFlipper(leftFlipperAngle)
    drawRightFlipper(rightFlipperAngle)

    love.graphics.draw(backgroundObjects, 0, 0)
    -- drawBoard(BOARDSTARTPOS, BOARDSIZEPIXELS, PEGSIZEPIXELS)
    -- drawPegLocations(BOARDSTARTPOS, BOARDSIZEPIXELS, PEGSIZEPIXELS)
    -- love.graphics.draw(pegLocCanvas, 0, 0)
    love.graphics.print("Cursor Position ..." .. tostring(cursorX)..", "..tostring(cursorY), 40, 300)

    love.graphics.print("Current elapsed game time ..." .. tostring(elapsedTime()), 40, 100)
    love.graphics.print("Mouse clicked ..." .. tostring(clickX) .. " " .. tostring(clickY), 40, 350)

    love.graphics.print("Angle ..." .. tostring(getLftFlipAngle()*180/3.14), 40, 450)

end