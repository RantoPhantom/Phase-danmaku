function NewBullet(init_x, init_y, speed, direction)
	local bullet = {
		sprite = Sprites.bullet,
		x = init_x,
		y = init_y,
		speed = speed,
		direction = direction,
	}
	bullet.width, bullet.height = bullet.sprite:getDimensions()

	function bullet:update(dt)
		if self.body == nil then
			self.body = love.physics.newBody(World, self.x, self.y, "static")
			self.collision_box = love.physics.newRectangleShape(self.width ,self.height)
			self.fixture = love.physics.newFixture(self.body, self.collision_box)
			self.fixture:setUserData("Bullet")
			-- collision setup
			self.fixture:setCategory(CollisionMasks.projectiles)
			self.fixture:setMask(CollisionMasks.player, CollisionMasks.projectiles)
		end
		self.y = self.y + self.direction.y * speed * dt
		self.body:setY(self.y)
		self.body:setX(self.x)
	end

	function bullet:draw()
		love.graphics.draw(self.sprite, self.x,self.y,0,1,1, self.width/2, self.height/2)
	end

	return bullet
end
