require "math"
------------------------------------
-- Functions for settibg board
-- dimensions
------------------------------------
function updateSpaceSize(spaceSize)
    
end

function updateBoardPosition(xStartPos, yStartPos)
    
end

function updateBoardSpaceDimensions(heightSpaces, widthSpaces)
   
end

------------------------------------
-- Funtion for initalizing the board
------------------------------------

function initBoardState(xStartPos, yStartPos, spaceSize, boardSize)
    -- Initiate the boardstate as a blank table
    boardState = {}
    x = 0 + xStartPos
    heightSpaces = 10
    widthSpaces = 10
    math.randomseed(os.time())
    -- iterate through each space based on the size of the board
    for i = 1, widthSpaces + 1 do
        boardState[i] = {}
        -- y position has to be reinitallized for each index of the x position so we start from top
        y = 0 + yStartPos
        for j = 1, heightSpaces + 1 do
            -- set all the attributes for each space
            boardState[i][j] = {
            ["xpos"] = 0,
            ["ypos"] = 0,
            ["visible"] = true,
            ["piece"] = "none",
            ["upgrade"] = "none",
            ["pieceColor"] = "white",
            ["fwdMoveAmt"] = 0,
            ["RevMoveAmt"] = 0,
            ["RgtMoveAmt"] = 0,
            ["LftMoveAmt"] = 0
            }
            -- set each x and y position of the currently indexed space
            boardState[i][j]["xpos"] = x
            boardState[i][j]["ypos"] = y

            -- Increment the y pos after setting each paramater
            y = y + (boardSize - spaceSize)/heightSpaces
        end

        -- Increment the x pos after setting each paramater
        x = x + (boardSize - spaceSize)/widthSpaces

    end
end


function getBoardState()
    return boardState
end

function updateBoardSpaceAttr(row, col, attr, val)
    boardState[row][col][attr] = val
end

-----------------------------------
-- Function to draw the chess board
-----------------------------------
function drawBoard(boardStartPos, boardSize, spaceSize)
    love.graphics.rectangle("line", boardStartPos[1], boardStartPos[2], boardSize, boardSize)
    colorIndex = 1
    for i = 1, #boardState do
        for j = 1, #boardState[i] do
            love.graphics.setColor(0,0,1)
            -- if colorIndex%2 == 0 then
            --     love.graphics.setColor(0,0,1)
            -- else
            --     love.graphics.setColor(0,1,0)
            -- end
            colorIndex = colorIndex + 1
            love.graphics.rectangle( "fill", boardState[i][j]["xpos"], boardState[i][j]["ypos"], spaceSize, spaceSize)
        end
        colorIndex = colorIndex + 1
    end
end

function getSelectedSpace(xCoord, yCoord, spaceSize)
    -- with a given set of coordinates, return the row and collumn of
    -- the selected space
    for i = 1, #boardState do
        for j = 1, #boardState[i] do
            -- get bounds of indexed space
            spaceXLeftBound = boardState[i][j]["xpos"] - spaceSize/2
            spaceXRightBound = boardState[i][j]["xpos"] + spaceSize/2
            spaceYLowerBound = boardState[i][j]["ypos"] - spaceSize/2
            spaceYUpperBound = boardState[i][j]["ypos"] + spaceSize/2
            
            -- check if input coords fall within indexeded space
            if (xCoord > spaceXLeftBound) and (xCoord < spaceXRightBound) then --and yCoord > spaceYLowerBound and yCoord < spaceYUpperBound then
                return i, j
            end
        end
    end
    -- return nil if selected space is out of bounds
    return nil, nil
end


function drawAllowedMoves()
    -- Draws dots for the moves that are allowed to be made for the
    -- selected space.  Selected space is determined from an input 
    -- row and collumn indicies.
end
