love = love
Keymaps = {
	up = "w",
	down = "s",
	left = "a",
	right = "d",
	quit = "escape"
}

function love.keypressed(key, scancode, isrepeat)
	if scancode == Keymaps.quit then
		love.event.quit()
	end
end
