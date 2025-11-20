-----------------------------------------------------
--
-- Scoreboard
-- 
-- This file will contain the code for updating the
-- scroreboard and any animations involved with it
--
-----------------------------------------------------


local scoreBoard = {
score = 0,
x = 0,
y = 0
}


function drawScoreBoard()
    love.graphics.print('Score: ' .. tostring(scoreBoard.score), scoreBoard.x, scoreBoard.y)
end

function addToScoreBoard(value)
    scoreBoard.score = scoreBoard.score + value
end

function resetScoreBoard()
    scoreBoard.score = 0
end