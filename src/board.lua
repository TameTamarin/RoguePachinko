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
        x = 200,
        y = 100
    }

local rightWall = {
        h = 400,
        w = 10,
        x = 700,
        y = 100
    }

local floor = {
        h = 0,
        w = 0,
        x = 0,
        y = 0
    }


local ceiling = {
        h = 0,
        w = 0,
        x = 0,
        y = 0
    }

local leftInLane = {
        h = 400,
        w = 10,
        x = 0,
        y = 0,
        angle = 0
    }

local leftOutLane = {
    h = 100,
    w = 10,
    x = 0,
    y = 0,
    angle = 0
}

local rightInLane = {
        h = 100,
        w = 10,
        x = 0,
        y = 0,
        angle = 0
    }

local rightOutLane = {
        h = 100,
        w = 10,
        x = 0,
        y = 0,
        angle = 0
    }

local resetButton = {
        h = 50,
        w = 50,
        x = 50,
        y = 100
    }

------------------------------------------------------------------------------------
--
-- Fucntions for setting and retreiving the dimensions of the board pieces before initialization
--
------------------------------------------------------------------------------------

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

function setCeilingDim(h, w, x, y)
    ceiling.h = h
    ceiling.w = w
    ceiling.x = x
    ceiling.y = y
end

function setLeftInLaneDim(h, w, x, y, angle)
    leftInLane.h = h
    leftInLane.w = w
    leftInLane.x = x
    leftInLane.y = y
    leftInLane.angle = angle
end

function setLeftOutLaneDim(h, w, x, y, angle)
    leftOutLane.h = h
    leftOutLane.w = w
    leftOutLane.x = x
    leftOutLane.y = y
    leftOutLane.angle = angle
end

function setRightInLaneDim(h, w, x, y, angle)
    rightInLane.h = h
    rightInLane.w = w
    rightInLane.x = x
    rightInLane.y = y
    rightInLane.angle = angle
end

function setRightOutLaneDim(h, w, x, y, angle)
    rightOutLane.h = h
    rightOutLane.w = w
    rightOutLane.x = x
    rightOutLane.y = y
    rightOutLane.angle = angle
end

function getLeftInLane()
    return leftInLane
end

function getLeftOutLane()
    return leftOutLane
end

function getRightInLane()
    return rightInLane
end

function getRightOutLane()
    return rightOutLane
end


function updateSpaceSize(spaceSize)
    
end

function updateBoardPosition(xStartPos, yStartPos)
    
end

function updateBoardSpaceDim(heightSpaces, widthSpaces)
   
end

------------------------------------
--
-- Funtion for initalizing 
-- the walls, floor, ceiling
--
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

function initCeiling(world)
    ceiling.body = love.physics.newBody(world,ceiling.x,ceiling.y,"static")
    ceiling.shape = love.physics.newRectangleShape(ceiling.w,ceiling.h)
    ceiling.fixture = love.physics.newFixture(ceiling.body, ceiling.shape, 1000)
end

function drawCeiling()
    love.graphics.rectangle("fill", ceiling.x - ceiling.w/2, ceiling.y - ceiling.h/2, ceiling.w, ceiling.h)
end

function initLeftOutLane(world)
    leftOutLane.body = love.physics.newBody(world,leftOutLane.x + leftOutLane.h/4,leftOutLane.y + leftOutLane.h/4,"static")
    leftOutLane.shape = love.physics.newRectangleShape(leftOutLane.w,leftOutLane.h)
    leftOutLane.fixture = love.physics.newFixture(leftOutLane.body, leftOutLane.shape, 1000)
    leftOutLane.body:setAngle(leftOutLane.angle * 3.14 / 180)
end

function drawLeftOutLane()
    bx, by = leftOutLane.body:getPosition()
    drawRotatedRectangle("fill", bx, by, leftOutLane.w, leftOutLane.h, leftOutLane.body:getAngle())
end

function initLeftInLane(world)
    leftInLane.body = love.physics.newBody(world,leftInLane.x,leftInLane.y,"static")
    leftInLane.shape = love.physics.newRectangleShape(leftInLane.w,leftInLane.h)
    leftInLane.fixture = love.physics.newFixture(leftInLane.body, leftInLane.shape, 1000)
    leftInLane.body:setAngle(leftInLane.angle * 3.14 / 180)
end

function drawLeftInLane()
    bx, by = leftInLane.body:getPosition()
    drawRotatedRectangle("fill", bx, by, leftInLane.w, leftInLane.h, leftInLane.body:getAngle())
end


function initRightOutLane(world)
    rightOutLane.body = love.physics.newBody(world,rightOutLane.x - rightOutLane.h/4,rightOutLane.y + rightOutLane.h/4,"static")
    rightOutLane.shape = love.physics.newRectangleShape(rightOutLane.w,rightOutLane.h)
    rightOutLane.fixture = love.physics.newFixture(rightOutLane.body, rightOutLane.shape, 1000)
    rightOutLane.body:setAngle(rightOutLane.angle * 3.14 / 180)
end

function drawRightOutLane()
    bx, by = rightOutLane.body:getPosition()
    drawRotatedRectangle("fill", bx, by, rightOutLane.w, rightOutLane.h, rightOutLane.body:getAngle())
end

function initRightInLane(world)
    rightInLane.body = love.physics.newBody(world,rightInLane.x,rightInLane.y,"static")
    rightInLane.shape = love.physics.newRectangleShape(rightInLane.w,rightInLane.h)
    rightInLane.fixture = love.physics.newFixture(rightInLane.body, rightInLane.shape, 1000)
    rightInLane.body:setAngle(rightInLane.angle * 3.14 / 180)
end

function drawRightInLane()
    bx, by = rightInLane.body:getPosition()
    drawRotatedRectangle("fill", bx, by, rightInLane.w, rightInLane.h, rightInLane.body:getAngle())
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
            boardState[i][j].enable = true

            pegLocations[i][j].xpos = x
            pegLocations[i][j].ypos = y
            pegLocations[i][j].enable = true

            -- Increment the y pos after setting each paramater
            x = x + (boardDim.size - pegSize)/boardDim.hSpaces
        end

        -- Increment the x pos after setting each paramater
        y = y + (boardDim.size - pegSize)/boardDim.wSpaces

    end
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
            if boardState[i][j].enable == true then
                love.graphics.circle("fill", boardState[i][j]["xpos"], boardState[i][j]["ypos"], pegSize/2)
            end
        end
        colorIndex = colorIndex + 1
    end
end

function drawPegLocations(boardStartPos, boardSize, pegLocSize)
    -- Draw all of the possible peg locations on the board
    for i = 1, #pegLocations do
        for j = 1, #pegLocations[i] do
            love.graphics.setColor(0,1,0)
            if pegLocations[i][j].enable == true then
                love.graphics.circle("fill", pegLocations[i][j]["xpos"], pegLocations[i][j]["ypos"], pegLocSize/3)
            end
        end
    end
end

function drawButtons()
    -- Draw buttons onto the board
    love.graphics.rectangle("fill", resetButton.x, resetButton.y, resetButton.h, resetButton.w)
end


function drawAllowedMoves()
    -- Draws dots for the moves that are allowed to be made for the
    -- selected space.  Selected space is determined from an input 
    -- row and collumn indicies.
end


-----------------------------------
-- Functions for getting status of
-- the board and for updating
-- spaces
-----------------------------------

function getBoardState()
    return boardState
end

function getSelectedSpace(xCoord, yCoord, spaceSize)
    if xCoord == nil or yCoord == nil then
        return nil, nil
    end
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
            if (xCoord > spaceXLeftBound) and (xCoord < spaceXRightBound) and yCoord > spaceYLowerBound and yCoord < spaceYUpperBound then
                return i, j
            end
        end
    end
    -- return nil if selected space is out of bounds
    return nil, nil
end


function updateSpaceParameter(row, collumn)
    if row == nil or collumn == nil then
        return
    else
        boardState[row][collumn].enable = false
        pegLocations[row][collumn].enable = false
        boardState[row][collumn].body:setActive(false)
    end
end


function updateBoardSpaceAttr(row, col, attr, val)
    boardState[row][col][attr] = val
end
