balls = {
        {x=200, y=0, radius=10, color={1,0,0}},
        {x=300, y=0, radius=15, color={0,1,0}},
        {x=400, y=0, radius=20, color={0,0,1}},
        {x=500, y=0, radius=25, color={1,1,0}},
        {x=600, y=0, radius=30, color={0,1,1}},
    }
function start()
    for i, ball in ipairs(balls) do
        ball.thing = 7
    end
end

function finish()
    for i, ball in ipairs(balls) do
        print(ball.thing)
    end
end

start()
finish()