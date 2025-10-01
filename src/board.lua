require "math"
------------------------------------
-- Functions for settibg board
-- dimensions
------------------------------------

local boardDim = {
    hSpaces = 10,
    wSpaces = 10,
    xStart = 0,
    yStart = 0,
    size = 0
    }

local leftWall = {
        h = 400,
        w = 10,
        x = 100,
        y = 100
    }

local rightWall = {
        h = 400,
        w = 10,
        x = 100,
        y = 100
    }

local floor = {
        h = 0,
        w = 0,
        x = 0,
        y = 0
    }

function initBoard(hSpaces, wSpaces, xStart, yStart, size)
    boardDim.hSpaces = hSpaces
    boardDim.wSpaces = wSpaces
    boardDim.xStart = xStart
    boardDim.yStart = yStart
    boardDim.size = size
end

function setLeftWallDim(h, w, x, y)
    leftWall.h = h
    leftWall.w = w
    leftWall.x = x
    leftWall.y = y
end

function setRightWallDim(h, w, x, y)
    rightWall.h = h
    rightWall.w = w
    rightWall.x = x
    rightWall.y = y
end

function setFloorDim(h, w, x, y)
    floor.h = h
    floor.w = w
    floor.x = x
    floor.y = y
end
    

function updateSpaceSize(spaceSize)
    
end

function updateBoardPosition(xStartPos, yStartPos)
    
end

function updateBoardSpaceDim(heightSpaces, widthSpaces)
   
end

------------------------------------
-- Funtion for initalizing 
-- the leftWall and rightWall
------------------------------------
function initLeftWall(world)
    leftWall.body = love.physics.newBody(world,leftWall.x,leftWall.y,"static")
    leftWall.shape = love.physics.newRectangleShape(leftWall.w,leftWall.h)
    leftWall.fixture = love.physics.newFixture(leftWall.body, leftWall.shape, 1000)
end


function drawLeftWall()
    love.graphics.rectangle("fill", leftWall.x - leftWall.w/2, leftWall.y - leftWall.h/2, leftWall.w, leftWall.h)
end


function initRightWall(world)
    rightWall.body = love.physics.newBody(world,rightWall.x,rightWall.y,"static")
    rightWall.shape = love.physics.newRectangleShape(rightWall.w,rightWall.h)
    rightWall.fixture = love.physics.newFixture(rightWall.body, rightWall.shape, 1000)
end

function drawRightWall()
    love.graphics.rectangle("fill", rightWall.x - rightWall.w/2, rightWall.y - rightWall.h/2, rightWall.w, rightWall.h)
end

function initFloor(world)
    floor.body = love.physics.newBody(world,floor.x,floor.y,"static")
    floor.shape = love.physics.newRectangleShape(floor.w,floor.h)
    floor.fixture = love.physics.newFixture(floor.body, floor.shape, 1000)
end

function drawFloor()
    love.graphics.rectangle("fill", floor.x - floor.w/2, floor.y - floor.h/2, floor.w, floor.h)
end

------------------------------------
-- Funtion for initalizing the board
------------------------------------

function initBoardState(pegSize, world)
    -- Initiate the boardstate as a blank table
    boardState = {}
    pegLocations = {}
    y = 0 + boardDim.yStart
    offset = ((boardDim.size - pegSize)/boardDim.hSpaces)/2
    math.randomseed(os.time())
    -- iterate through each space based on the size of the board
    for i = 1, boardDim.wSpaces + 1 do
        boardState[i] = {}
        pegLocations[i] = {}
        -- x starting position has to be reinitallized for each index of the y position so we start from left
        if i%2 == 0 then
            x = offset + boardDim.xStart
        else
            x = 0 + boardDim.xStart
        end

        for j = 1, boardDim.hSpaces + 1 do
            -- set all the attributes for each space
            boardState[i][j] = {
            ["xpos"] = 0,
            ["ypos"] = 0,
            ["w"] = 0,
            ["h"] = 0,
            ["visible"] = true,
            ["piece"] = "none",
            ["upgrade"] = "none",
            ["pieceColor"] = "white",
            ["fwdMoveAmt"] = 0,
            ["RevMoveAmt"] = 0,
            ["RgtMoveAmt"] = 0,
            ["LftMoveAmt"] = 0
            }
            pegLocations[i][j] = {
            ["xpos"] = 0,
            ["ypos"] = 0
            }
            -- set each x and y position of the currently indexed space
            boardState[i][j].xpos = x
            boardState[i][j].ypos = y
            boardState[i][j].w = pegSize
            boardState[i][j].h = pegSize
            boardState[i][j].body = love.physics.newBody(world,x,y,"static")
            boardState[i][j].shape = love.physics.newCircleShape(boardState[i][j].w/2)
            boardState[i][j].fixture = love.physics.newFixture(boardState[i][j].body, boardState[i][j].shape,1000)
            boardState[i][j].body:setFixedRotation(true)

            pegLocations[i][j].xpos = x
            pegLocations[i][j].ypos = y

            -- Increment the y pos after setting each paramater
            x = x + (boardDim.size - pegSize)/boardDim.hSpaces
        end

        -- Increment the x pos after setting each paramater
        y = y + (boardDim.size - pegSize)/boardDim.wSpaces

    end
end


function getBoardState()
    return boardState
end

function updateBoardSpaceAttr(row, col, attr, val)
    boardState[row][col][attr] = val
end

-----------------------------------
-- Function to draw the peg board
-----------------------------------
function drawBoard(boardStartPos, boardSize, pegSize)
    love.graphics.rectangle("line", boardStartPos[1], boardStartPos[2], boardSize, boardSize)
    colorIndex = 1
    for i = 1, #boardState do
        for j = 1, #boardState[i] do
            love.graphics.setColor(0,0,1)
            colorIndex = colorIndex + 1
            love.graphics.circle( "fill", boardState[i][j]["xpos"], boardState[i][j]["ypos"], pegSize/2)
        end
        colorIndex = colorIndex + 1
    end
end

function drawPegLocations(boardStartPos, boardSize, pegLocSize)
    -- Draw all of the possible peg locations on the board
    for i = 1, #pegLocations do
        for j = 1, #pegLocations[i] do
            love.graphics.setColor(0,1,0)
            love.graphics.circle("fill", pegLocations[i][j]["xpos"], pegLocations[i][j]["ypos"], pegLocSize/2)
        end
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
