require("bullet")
function NewPlayer()
	local player = {
		bullets = {},
		time_since_last_bullet = 0,
		bullet_delay = 5,
		focus_speed = 150,
	}
	setmetatable(player, {__index = Movable})

	function player:update(dt)
		if self.time_since_last_bullet > 0 then
			self.time_since_last_bullet = self.time_since_last_bullet - 1
		end
		if love.keyboard.isDown(Keymaps.attack) then
			self:shoot()
		end
		self:move(dt)
	end

	function player:shoot()
		if self.time_since_last_bullet == 0 then
			table.insert(self.bullets, NewBullet("/assets/test-bullet.png", self.x + self.width/2, self.y,800,{x=0,y=-1}))
			self.time_since_last_bullet = self.bullet_delay
		end
	end
	return player
end
