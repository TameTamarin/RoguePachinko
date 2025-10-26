function drawRotatedRectangle(mode, x, y, width, height, angle)
	-- We cannot rotate the rectangle directly, but we
	-- can move and rotate the coordinate system.
	love.graphics.push()
	love.graphics.translate(x, y)
	love.graphics.rotate(angle)
	-- love.graphics.rectangle(mode, 0, 0, width, height) -- origin in the top left corner
	love.graphics.rectangle(mode, -width/2, -height/2, width, height) -- origin in the middle
	love.graphics.pop()
end