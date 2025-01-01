function love.load()
	Window_width = 500
	Window_height = 800
	require("keymaps")
	require("player")
	Player = NewPlayer()
	love.window.setMode(Window_width, Window_height)
	love.keyboard.setKeyRepeat(true)
end

function love.update(dt)
	Player:update(dt)
end

function love.draw()
	love.graphics.draw(Player.sprite,Player.x,Player.y,0,1,1,0,32)
end
