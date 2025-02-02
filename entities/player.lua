require("entities.bullet")
function NewPlayer()
	local player = {
		x = 0,
		y = 0,
		sprite = Sprites.player,
		bullets = {},
		health = 100,
		time_since_last_bullet = 0,
		bullet_delay = 10,

		focus_speed = 150,
		speed = 350
	}

	player.width, player.height = player.sprite:getDimensions()

	function player:update(dt)
		if self.body == nil then
			self.body = love.physics.newBody(World, self.x, self.y, "dynamic")
			self.collision_box = love.physics.newCircleShape(self.width/2)
			self.fixture = love.physics.newFixture(self.body, self.collision_box)
			self.fixture:setUserData("Player")
			self.fixture:setCategory(CollisionMasks.player)
			self.fixture:setMask(CollisionMasks.enemies)
		end
		-- update bullets and remove when out of bounds
		for i, bullet in ipairs(self.bullets) do
			bullet:update(dt)
			if bullet.y < 0 then
				table.remove(self.bullets, i)
			end
		end
		-- manage bullet spawning
		if self.time_since_last_bullet > 0 then
			self.time_since_last_bullet = self.time_since_last_bullet - 1
		end
		if love.keyboard.isDown(Keymaps.attack) then
			self:shoot()
		end
		-- move 
		self:move(dt)
		self.body:setX(self.x)
		self.body:setY(self.y)
	end

	function player:move(dt)
		local move_speed = self.speed
		if love.keyboard.isDown(Keymaps.slow_mode) then move_speed = self.focus_speed end
		-- move
		local dir = {x=0,y=0}
		dir = self:get_move_direction()
		self.x = self.x + dir.x * dt * move_speed
		self.y = self.y + dir.y * dt * move_speed
		--! set walls
		if self.x < 0 + self.width/2 then self.x = 0 + self.width/2 end
		if self.x > Window_width - self.width/2 then self.x = Window_width - self.width/2 end
		if self.y < 0 + self.height/2 then self.y = 0 + self.height/2 end
		if self.y > Window_height - self.height/2 then self.y = Window_height - self.height/2 end
	end

	function player:draw()
		-- draw all the bullets
		for _, bullet in pairs(self.bullets) do bullet:draw() end
		--draw player
		love.graphics.draw(self.sprite,self.x,self.y,0,1,1, self.width/2, self.height/2)
		love.graphics.circle("line", self.x, self.y, self.width/2)
	end

	function player:shoot()
		if self.time_since_last_bullet == 0 then
			table.insert(self.bullets, NewBullet(self.x, self.y,800,{x=0,y=-1}))
			self.time_since_last_bullet = self.bullet_delay
		end
	end

	function player:get_move_direction()
		local dir = {x=0,y=0}
		if love.keyboard.isDown(Keymaps.right) then dir.x = dir.x + 1 end
		if love.keyboard.isDown(Keymaps.left) then dir.x = dir.x - 1 end
		if love.keyboard.isDown(Keymaps.up) then dir.y = dir.y - 1 end
		if love.keyboard.isDown(Keymaps.down) then dir.y = dir.y + 1 end
		-- pythagorean math shit 
		local len = math.sqrt(dir.x^2 + dir.y^2)
		if len > 0 then
			dir.x = dir.x/len
			dir.y = dir.y/len
		end
		return dir
	end

	return player
end
