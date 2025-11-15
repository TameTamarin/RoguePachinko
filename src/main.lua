-- if arg[2] == "debug" then
--     require("lldebugger").start()
-- end

-- print("it's Wednesday ma dudes")


-----------------------------------------------------
--
-- Global Variables
--
-----------------------------------------------------
FPSCAP = 60
WINDOWX = 600
WINDOWY = WINDOWX*2
BOARDSIZEPIXELS = 600
BOARDWIDTHPIXELS = 600
BOARDHEIGHTPIXELS = 1000
PEGSIZEPIXELS = 10
XGRAVITY = 0
YGRAVITY = 500
-- BOARDSTARTPOS = {WINDOWX/2 - BOARDWIDTHPIXELS/2, WINDOWY/2 - BOARDHEIGHTPIXELS/2}
BOARDSTARTPOS = {0, 100}
BALLWIDTH = 50
INOUTLANEGAP = BALLWIDTH * 1.25

-----------------------------------------------------
--
-- Load Function callback
-- 
--  This fuction is called at the beginning of the
--  game start and runs only once
--
-----------------------------------------------------
function love.load()
    -- load in submodules
    require("math")
    timing = require('timing')
    keyCommands = require('keyCommands')
    cursor = require('cursor')
    board = require('board')
    ball = require('ball')
    boardElements = require('flippers')
    utilities = require('utilities')
    bumpers = require('bumpers')
    pinBallTable = require('pinBallTable')
    scoreBoard = require("scoreBoard")

    -- Init the in game timer
    timeStart = love.timer.getTime()

    -- Set the random seed
    math.randomseed(os.time())

    -- Set the window size scaled based on screen resolution
    limitsX, limitsY = love.window.getDesktopDimensions()
    sx = limitsX/WINDOWX
    sy = limitsY/WINDOWY
    success = love.window.setMode(WINDOWX*sy, WINDOWY*sy, {vsync = 1})

    -- Load auido files
    audio = {
        bumper = love.audio.newSource("audio/Bumper1.wav", "static")
    }

    
    
    -- Setup the world and its fucntion callbacks
    world = love.physics.newWorld(XGRAVITY, YGRAVITY, true)
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    -- Run initialization functions
    setLeftWallDim(BOARDHEIGHTPIXELS, 10, BOARDSTARTPOS[1], BOARDSTARTPOS[2] + BOARDHEIGHTPIXELS/2)
    setRightWallDim(BOARDHEIGHTPIXELS, 10,BOARDSTARTPOS[1] + BOARDWIDTHPIXELS, BOARDSTARTPOS[2] + BOARDHEIGHTPIXELS/2)
    setFloorDim(10, BOARDWIDTHPIXELS, BOARDSTARTPOS[1] + BOARDSIZEPIXELS/2, BOARDSTARTPOS[2] + BOARDSIZEPIXELS)
    setCeilingDim(10, BOARDWIDTHPIXELS, BOARDSTARTPOS[1] + BOARDWIDTHPIXELS/2, BOARDSTARTPOS[2])
    setLeftOutLaneDim(175, 10, BOARDSTARTPOS[1], BOARDSTARTPOS[2] + BOARDHEIGHTPIXELS, 135)
    setLeftInLaneDim(75, 10, BOARDSTARTPOS[1] + INOUTLANEGAP, BOARDSTARTPOS[2] + BOARDHEIGHTPIXELS, 135)
    setRightOutLaneDim(175, 10, BOARDSTARTPOS[1] + BOARDWIDTHPIXELS, BOARDSTARTPOS[2] + BOARDHEIGHTPIXELS, 45)
    setRightInLaneDim(75, 10, BOARDSTARTPOS[1] + BOARDWIDTHPIXELS - INOUTLANEGAP, BOARDSTARTPOS[2] + BOARDHEIGHTPIXELS, 45)
    setLeftFlipperDim(10, 75, BOARDSTARTPOS[1] + INOUTLANEGAP + getLeftInLane().h/2, BOARDSTARTPOS[2] + BOARDHEIGHTPIXELS + getLeftInLane().h/2)
    setRightFlipperDim(10, 75, BOARDSTARTPOS[1] - INOUTLANEGAP - getRightInLane().h/2 + BOARDWIDTHPIXELS, BOARDSTARTPOS[2] + BOARDHEIGHTPIXELS + getRightInLane().h/2)
    
    setLeftFlipperDim(35, 75, 135, 945)
    setRightFlipperDim(35, 75, 325, 945)
        
    setPlungerFeedDim(BOARDHEIGHTPIXELS, 10, BOARDSTARTPOS[1] + BOARDWIDTHPIXELS + INOUTLANEGAP, BOARDSTARTPOS[2] + BOARDHEIGHTPIXELS/2)

    -- initBoardState(PEGSIZEPIXELS, world)
    initBall(world, 730, 710, 10)
    -- initLeftWall(world)
    -- initRightWall(world)
    
    -- initCeiling(world)
    -- initLeftInLane(world)
    -- initLeftOutLane(world)
    -- initRightInLane(world)
    -- initRightOutLane(world)
    -- initPlungerFeed(world)

    initFlippers(world)
    initBumper(world, 250, 400)
    initBumper(world, 300, 450)
    initBumper(world, 350, 400)

    initTable(world, BOARDSTARTPOS[1], BOARDSTARTPOS[2])


----------------------------------------------------------------
-- Setup Canvases for drawing background and the board
----------------------------------------------------------------
    backgroundObjects = love.graphics.newCanvas(WINDOWX, WINDOWY)
    pegLocCanvas = love.graphics.newCanvas(WINDOWX, WINDOWY)

    love.graphics.setCanvas(backgroundObjects)
        love.graphics.clear(0, 0, 0, 0)
        love.graphics.setBlendMode("alpha")
        -- drawBoard(BOARDSTARTPOS, BOARDSIZEPIXELS, PEGSIZEPIXELS)
        -- drawLeftWall()
        -- drawRightWall()
        
        -- drawCeiling()
        -- drawLeftInLane()
        -- drawLeftOutLane()
        -- drawRightInLane()
        -- drawRightOutLane()
        -- drawPlungerFeed()
        -- drawButtons()
        drawTable()
        love.graphics.setCanvas()

    
    -- Canvas for drawing the pegboard locations
    love.graphics.setCanvas(pegLocCanvas)
     love.graphics.clear(0, 0, 0, 0)
        love.graphics.setBlendMode("alpha")
        -- drawPegLocations(BOARDSTARTPOS, BOARDSIZEPIXELS, PEGSIZEPIXELS)
        love.graphics.setCanvas()

   
end


-----------------------------------------------------
--
-- Run Function Callback
--
-- This is the main loop of the program.
--
-----------------------------------------------------
printdata = ""


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
--
-- World Function callbacks
--
-- Functions that run when specific tagged events 
-- occur in the world.
--
-- These funcitons need to match the listed functions
-- in the world creation.
--
-----------------------------------------------------
function beginContact(fixture_a, fixture_b, contact)
    local object_a = fixture_a:getUserData()
    local object_b = fixture_b:getUserData()
    printdata = object_a
    -- Check if both objects are valid and have a "tag"
    if object_a and object_b and object_a.tag and object_b.tag then
        -- do something
        
    elseif object_a == 'bumper' or object_b == 'bumper' then
        addToScoreBoard(100)
        -- ballVelX, ballVelY = getBallVelocity(1)
        -- bumperVelX, bumperVelY = getBumperAppliedVel(ballVelX, ballVelY)
        -- ballSetVelocityWComponents(1, bumperVelX, bumperVelY)
    end
end


function endContact(fixture_a, fixture_b, coll)
    local object_a = fixture_a:getUserData()
    local object_b = fixture_b:getUserData()
    if object_a == 'bumper' or object_b == 'bumper' then
        ballVelX, ballVelY = getBallVelocity(1)
        bumperVelX, bumperVelY = getBumperAppliedVel(ballVelX, ballVelY)
        ballSetVelocityWComponents(1, bumperVelX, bumperVelY)
        audio.bumper:play()
    end
    
end

function preSolve(a, b, coll)
   
end

function postSolve(a, b, coll, normalimpulse, tangentimpulse)

end


-----------------------------------------------------
--
-- Update Function callback
-- 
-- This function runs on every interation of the
-- main loop.
--
-----------------------------------------------------
row = nil
collumn = nil

local rightFlipperAngle = 0
local leftFlipperAngle = 0
dt = 1/60
function love.update(dt)
    -- Control frame rate
    
    -- sleep(DT, FPSCAP)

    updateBallsLocations()
    updateLeftFlipper()
    updateRightFlipper()
    

    cursorX, cursorY = getCursorPosition()
    clickX, clickY = getMousePosOnClick()


    if checkMouseClick() then
        if clickX <= 75 and clickX >= 25 and clickY <= 125 and clickY >= 75 then
            resetBallPosition()
        end
    end

    ballPosX, ballPosY = getBallPos(1)
    leftFlipperX, leftFlipperY = getLeftFlipperPos()
    rightFlipperX, rightFlipperY = getRightFlipperPos()

    if spaceKeyCheck() == 1 then
        ballSetVelocityWAngle(1, 1000, 270)
    end

    if ballPosY > WINDOWY then
        resetBallPosition()
    end

    world:update(dt, 10, 10)
    
end


-----------------------------------------------------
--
-- Draw Function callback
-- 
-- Draws shapes onto the screen.  Runs once every
-- interation of the main loop.
--
-----------------------------------------------------
function love.draw()
    -- set scale to draw at baed on on the screen resoltion and window size
    love.graphics.push()
    love.graphics.scale( sy, sy )

    -- draw objects
    drawBalls(world)
    drawLeftFlipper(leftFlipperAngle)
    drawRightFlipper(rightFlipperAngle)
    drawBumpers(world)
    drawScoreBoard()

    love.graphics.draw(backgroundObjects, 0, 0)
    -- drawBoard(BOARDSTARTPOS, BOARDSIZEPIXELS, PEGSIZEPIXELS)
    -- drawPegLocations(BOARDSTARTPOS, BOARDSIZEPIXELS, PEGSIZEPIXELS)
    -- love.graphics.draw(pegLocCanvas, 0, 0)
    love.graphics.print("Cursor Position ..." .. tostring(cursorX)..", "..tostring(cursorY), 0, 20)

    -- love.graphics.print("Current elapsed game time ..." .. tostring(elapsedTime()), 40, 100)
    love.graphics.print("Mouse clicked ..." .. tostring(clickX) .. " " .. tostring(clickY), 0, 40)

    love.graphics.print("Collision ..." .. tostring(printdata), 0, 60)
    
    love.graphics.print("Screen dimensions: " .. tostring(sx) .. ", " .. tostring(sy), 0, 80)
    printdata = ""

    -- return to normal scale to prevent crashing
    love.graphics.pop()

   

end