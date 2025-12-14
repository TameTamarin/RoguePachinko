
function homeScreen()
    function love.draw()
        options ={
            newGame = {100,30},
            settings = {100,50}
        }
        love.graphics.print("New Game", options.newGame[1], options.newGame[2])
        love.graphics.print("Settings", options.settings[1], options.settings[2])
        if gameEngineVars.clickX then
            if gameEngineVars.clickX <= options.newGame[1] and gameEngineVars.clickY <= options.newGame[2] then
                queueEvent(newGame)
                gameScreen()
            end
        end
    end
end


function gameOverScreen()
    gameEngineVars.clickX = nil
    gameEngineVars.clickY = nil
    function love.draw()
        options = {
            gameOver = {100,10},
            newGame = {100,30},
            quit = {100,50}
        }
        love.graphics.print("Game Over", options.gameOver[1], options.gameOver[2])
        love.graphics.print("New Game", options.newGame[1], options.newGame[2])
        love.graphics.print("Quit", options.quit[1], options.quit[2])
        if gameEngineVars.clickX then
            if gameEngineVars.clickX <= options.newGame[1] and gameEngineVars.clickY <= options.newGame[2] then
                queueEvent(newGame)
                gameScreen()
            end
        end
    end
end

function gameScreen()
    function love.draw()
        
    -- Helper Function to draw all objects
    function drawActions()
        for i = 1, #gameEngineVars.drawActions do
            gameEngineVars.drawActions[i]()
        end
    end


    -- set scale to draw at based on on the screen resoltion and window size
    love.graphics.push()
    love.graphics.scale( sy, sy )

    -- draw objects
    drawActions()
    

    love.graphics.print("Cursor Position ..." .. tostring(cursorX)..", "..tostring(cursorY), 0, 20)

    -- love.graphics.print("Current elapsed game time ..." .. tostring(elapsedTime()), 40, 100)
    love.graphics.print("Mouse clicked ..." .. tostring(gameEngineVars.clickX) .. " " .. tostring(gameEngineVars.clickY), 0, 40)

    love.graphics.print("Collision:" .. tostring(printdata), 0, 60)

    love.graphics.print("Balls active " .. tostring(gameEngineVars.ballsActive), 0, 70)
    
    love.graphics.print("Balls Remaining: " .. tostring(gameEngineVars.ballsRemaining), 0, 80)

    getNumEvents()
    
    writeToLogFile("num active balls", gameEngineVars.ballsActive)
    writeToLogFile("num remaining balls", gameEngineVars.ballsRemaining)
    

    -- return to normal scale to prevent crashing
    love.graphics.pop()
    end
end

