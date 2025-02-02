require("globals.keymaps")
require("globals.sprites")
require("entities.player")
require("entities.enemy")
function love.load()
	CollisionMasks = {
		player = 1,
		world = 2,
		enemies = 3,
		projectiles = 4,
	}
	Window_width = 500
	Window_height = 800
	Player = NewPlayer()
	Dummy = NewDummy("assets/PipHeart.png")

	love.window.setTitle("danmaku")
	love.window.setMode(Window_width, Window_height)
	love.keyboard.setKeyRepeat(true)
	love.physics.setMeter(64)
	World = love.physics.newWorld(0,0,true)
	World:setCallbacks(BeginContact)
end

function love.update(dt)
	World:update(dt)
	Player:update(dt)
	Dummy:update(dt)
end

function love.draw()
	Draw_stats()
	Player:draw()
	Dummy:draw()
end

function Draw_stats()
	local stats = love.graphics.getStats()
	local mem = string.format("texture memory: %.2fKB", stats.texturememory/1024)
	love.graphics.print(mem, 10, 10)
	love.graphics.print(love.timer.getFPS(), Window_width - 20 ,10)
	--[[
	for k,v in pairs(stats) do
		love.graphics.print(k .. ":" .. v .. "\n", 10, stat_location)
		stat_location = stat_location + 20
	end
	--]]
end

function BeginContact(a,b ,coll)
	print(a:getUserData(), b:getUserData())
	print(coll:getNormal())
end
