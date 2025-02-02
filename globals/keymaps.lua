love = love
Keymaps = {
	up = "w",
	down = "s",
	left = "a",
	right = "d",
	quit = "escape",
	slow_mode = "l",
	attack = "m",
	special = "k",
}

function love.keypressed(scancode)
	if scancode == Keymaps.quit then
		love.event.quit()
	end
end
