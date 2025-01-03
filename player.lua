require("bullet")
function NewPlayer()
	local player = {
		sprite = love.graphics.newImage("assets/PipHeart.png"),
		bullets = {},
		time_since_last_bullet = 0,
		bullet_delay = 5,
		x = 10,
		y = 10,
		speed = 350,
		focus_speed = 150,
		width = 50,
		height = 50,
	}
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

	function player:move(dt)
		local move_speed = self.speed
		if love.keyboard.isDown(Keymaps.slow_mode) then move_speed = self.focus_speed end

		local dir = {x=0,y=0}
		dir = self:get_move_direction()
		self.x = self.x + dir.x * dt * move_speed
		self.y = self.y + dir.y * dt * move_speed

		--! set walls
		if self.x < 0 - self.width/4 then self.x = 0 - self.width/4 end
		if self.x > Window_width - self.width then self.x = Window_width - self.width end

		if self.y < 0 + self.height/2 then self.y = 0 + self.height/2 end
		if self.y > Window_height - self.height/2 then self.y = Window_height - self.height/2 end
	end

	function player:get_move_direction()
		local dir = {x=0,y=0}
		if love.keyboard.isDown(Keymaps.right) then dir.x = dir.x + 1 end
		if love.keyboard.isDown(Keymaps.left) then dir.x = dir.x - 1 end
		if love.keyboard.isDown(Keymaps.up) then dir.y = dir.y - 1 end
		if love.keyboard.isDown(Keymaps.down) then dir.y = dir.y + 1 end

		local len = math.sqrt(dir.x^2 + dir.y^2)
		if len > 0 then
			dir.x = dir.x/len
			dir.y = dir.y/len
		end
		return dir
	end
	return player
end
