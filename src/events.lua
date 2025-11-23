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

-- This is a table that will house all of the variables
-- that will be passed back and forth between the main
-- and the engine.
gameEngineVars = {
    worldSleep = false,
    ignoreNewEvents = false,
    score = 0,
    ballsRemaining = 3,
    ballsActive = 0,
    bumpersHit = 0,
    targetsHit = 0,
    world = nil
}

eventStack = {}
--------------------------------------------------------
-- Check that an event has occurred
--------------------------------------------------------
function eventCheck()
    gameOverCheck()

end

-- Pull the first event from the stack and resolve it
function eventResolve()
    if #eventStack > 0 then
        eventStack[1]()
        table.remove(eventStack, 1)
    end
end


function getNumEvents()
    love.graphics.print("Num Events: " .. #eventStack, 300, 70)
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
    end
end


function resetBallCheck()
    if gameEngineVars.ballsRemaining > 0 then
        table.insert(eventStack, spawnBallAtPlunger)
    end
end

function queueEvent(event)
    table.insert(eventStack, event)
end

--------------------------------------------------------
--
-- Events to be called
--
-- These are the functions that can be added to the stack
--
---------------------------------------------------------

function newGame()
    gameEngineVars.score = 0
    gameEngineVars.worldSleep = false
    gameEngineVars.ballsRemaining = 3
    table.insert(eventStack, spawnBallAtPlunger) 
end



function gameOver()
    -- function love.draw()
    love.graphics.print("Game Over", 300, 80)
    love.graphics.print("New Game", 300, 150)
    gameEngineVars.worldSleep = true
    love.event.clear()
    if spaceKeyCheck() == 1 then
        table.insert(eventStack, newGame)
        
    end
end

