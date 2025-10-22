require "math"

function ballApplyForce(ballIndex, forceVal, angle)
    iy = math.sin(angle)*forceVal
    ix = math.cos(angle)*forceVal
    return ix,iy
end

print(ballApplyForce(2, 20, 20))
print("hello")