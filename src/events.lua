--------------------------------------------------------
--
-- Events
-- 
-- This file will contain the code for tracking what
-- events should happen.
--
-- examples of events:
-- Game over, start new game, random events, etc
--
-- This code will contain a function that will
-- check various parameters and attributes that
-- are occuring within the game.
--
-- If there is an event that meets the specific
-- conditions then the event to occur will be added
-- to the stack.  During the update and draw callbacks
-- the event will be executed and removed from the stack.
---------------------------------------------------------

keyCommands = require("keyCommands")
ball = require("ball")
bumper = require("bumpers")

-- This is a table that will house all of the variables
-- that will be passed back and forth between the main
-- and the engine.
gameEngineVars = {
    worldSleep = false,
    updateSleep = false,
    ignoreNewEvents = false,
    score = 0,
    ballsRemaining = 3,
    ballsActive = 0,
    bumpersHit = 0,
    targetsHit = 0,
    world = nil,
    windowX = 0,
    windowY = 0,
    gameOver = false,
    gameReset = false,
    drawActions = {}
}

eventStack = {}
--------------------------------------------------------
-- Check that an event has occurred
--------------------------------------------------------
function eventCheck()
    ballActiveCheck()
    if not gameEngineVars.gameOver then
        gameOverCheck()
    end

    checkNumBumpsHitForUpgrade()
    

end

-- Pull the first event from the stack and resolve it
function eventResolve()
        for i = 1 , #eventStack do
            eventStack[1]()
            table.remove(eventStack, 1)
        end
end


function getNumEvents()
    love.graphics.print("Num Events: " .. #eventStack, 300, 70)
end

function queueEvent(event)
    table.insert(eventStack, event)
end
--------------------------------------------------------
--
-- Event checks
--
-- These are the functions that are used to check that
-- an event has occurred.  These have been broken out of
-- the event check function so that there is a label
-- of the type of event associated with it and makes it
-- easier to edit events.
--
---------------------------------------------------------

function gameOverCheck()
    if gameEngineVars.ballsRemaining == 0 and gameEngineVars.ballsActive == 0 then
            table.insert(eventStack, gameOver)
            writeToLogFile("gameOver", nil)
    end
end


function resetBallCheck()
    if gameEngineVars.ballsRemaining > 0 then
        table.insert(eventStack, spawnBallAtPlunger)
    end
end


function ballActiveCheck()
    -- We only want to check the balls position if there is a ball active
    gameEngineVars.ballsActive = getNumBalls()
    if gameEngineVars.ballsActive ~= 0 and gameEngineVars.updateSleep == false then

        updateBallsLocations()
    end
end

function checkNumBumpsHitForUpgrade()
    if gameEngineVars.bumpersHit == 10 then
        bumps[1].scoreVal = bumps[1].scoreVal + 100
        gameEngineVars.bumpersHit = 0
    end
end

--------------------------------------------------------
--
-- Events to be called
--
-- These are the functions that can be added to the stack
--
---------------------------------------------------------

function newGame()
    -- Start a new game by resetting score, balls remaining,
    -- and spawning a new ball
    -- table.remove(eventStack, 1)
    -- table.remove(eventStack, 1)
    gameEngineVars.score = 0
    gameEngineVars.worldSleep = false
    gameEngineVars.ballsRemaining = 3
    bumps[1].scoreVal = 100
    -- Set to one ball active so that we do not trigger
    -- a second ball spawn on next ball check
    gameEngineVars.ballsActive = 1
    gameEngineVars.gameOver = false
    table.insert(eventStack, spawnBallAtPlunger)
    -- Set the reset flag back to false after resetting the game
    gameEngineVars.gameReset = false
    gameEngineVars.drawActions = {
        drawBalls,
        drawBumpers,
        drawScoreBoard,
        drawPlunger,
        drawOutOfBounds,
        drawBackgroundObjects,
        drawLeftFlipper,
        drawRightFlipper
    }

end


function upgradeScreen()
    -- Placeholder for future upgrade screen event
    gameEngineVars.worldSleep = true
    
    if spaceKeyCheck() == 1 then
        gameEngineVars.worldSleep = false
    end
        

end


function gameOver()
    -- function love.draw()
    -- Only allow for one game over event to be processed
    if gameEngineVars.gameReset == false then
        love.graphics.print("Game Over", 300, 80)
        love.graphics.print("New Game", 300, 150)
        -- gameEngineVars.worldSleep = true
        gameEngineVars.gameOver = true
        -- respawn ball when appropriate key is pressed
        gameEngineVars.drawActions = {drawScoreBoard,}
        -- destroy all balls that could possibly linger or spawn
        destroyAllBalls()
        table.insert(eventStack, gameOver)
        if spaceKeyCheck() == 1 then
            table.insert(eventStack, newGame)
            gameEngineVars.gameReset = true
            writeToLogFile("Game Over space key pressed", nil)
            
        end
    end
end


-- function select
--     --Make a selection using the arrows between a set of options.  What if we want to make it dynamic?  A table with each of the selection locations that when we hit a button it draws a box at that selection?
-- end
