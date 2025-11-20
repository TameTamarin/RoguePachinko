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
-- balls = require("ball")
    
    gameEngineVars = {
    worldSleep = false,
    score = 0,
    ballsRemaining = 0,
    ballsActive = 0,
    bumpersHit = 0,
    targetsHit = 0,
    world = nil
}

eventStack = {getNumEvents}

function eventCheck()
    table.insert(eventStack, gameOver)
    if gameEngineVars.ballsRemaining == 0 and gameEngineVars.ballsActive == 0 then
        table.insert(eventStack, gameOver)
    end
end

function eventResolve()
    if #eventStack > 0 then
        eventStack[1]()
        table.remove(eventStack, 1)
    end
end

function getNumEvents()
    love.graphics.print("Num Events: " .. #eventStack, 300, 70)
end

function gameOver()
    -- function love.draw()
    love.graphics.print("Game Over", 300, 80)
    love.graphics.print("New Game", 300, 150)
    gameEngineVars.worldSleep = True
    if spaceKeyCheck() then
        -- table.insert(eventStack, initBall)
        love.event.clear()
    end
end

function pauseWorld()
    return
end