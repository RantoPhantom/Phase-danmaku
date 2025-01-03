require("keymaps")
require("player")
function love.load()
	Window_width = 500
	Window_height = 800
	Player = NewPlayer()

	love.window.setTitle("yayya")
	love.window.setMode(Window_width, Window_height)
	love.keyboard.setKeyRepeat(true)
end

function love.update(dt)
	Player:update(dt)
	for i, bullet in ipairs(Player.bullets) do
		bullet:update(dt)
		if bullet.y < 0 then
			table.remove(Player.bullets, i)
		end
	end
end

function love.draw()
	Draw_stats()
	for _, bullet in pairs(Player.bullets) do
		love.graphics.draw(bullet.sprite, bullet.x,bullet.y,0,1,1,0,32)
	end
	if Player ~= nil then
		love.graphics.draw(Player.sprite,Player.x,Player.y,0,1,1,0,32)
	end
end

function Draw_stats()
	local stats = love.graphics.getStats()
	local stat_location = 0
	for k,v in pairs(stats) do
		love.graphics.print(k .. ":" .. v .. "\n", 10, stat_location)
		stat_location = stat_location + 20
	end
end
