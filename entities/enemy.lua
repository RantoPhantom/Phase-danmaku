function NewDummy(sprite_path)
	local dummy = {
		sprite = Sprites.enemy,
		speed = 200,
		health = 10,
		attack = 10,
		x = Window_width/2,
		y = 100,
		direction = {x=-1,y=0},

	}

	dummy.width, dummy.height = dummy.sprite:getDimensions()
	function dummy:update(dt)
		if self.body == nil then
			self.body = love.physics.newBody(World, self.x, self.y, "dynamic")
			self.collision_box = love.physics.newCircleShape(self.width/2)
			self.fixture = love.physics.newFixture(self.body, self.collision_box, 1)
			self.fixture:setUserData("Dummy")
			self.fixture:setCategory(CollisionMasks.enemies)
		end

		self:move(dt)
		self.body:setX(self.x)
		self.body:setY(self.y)
	end

	function dummy:draw()
		love.graphics.setColor(255/255, 200/255, 40/255)
		love.graphics.draw(self.sprite, self.x,self.y,0,1,1,self.width/2, self.height/2)
		love.graphics.setColor(1,1,1)
		love.graphics.circle("line", self.body:getX(), self.body:getY(), self.width/2)
	end

	function dummy:move(dt)
		self.x = self.x + self.speed * dt * self.direction.x

		if self.x < 0 + self.width/2 then self:reverse() self.x = 0 + self.width/2 end
		if self.x > Window_width - self.width/2 then self:reverse() self.x = Window_width - self.width/2 end
		if self.y < 0 + self.height/2 then self:reverse() self.y = 0 + self.height/2 end
		if self.y > Window_height - self.height/2 then self:reverse() self.y = Window_height - self.height/2 end
	end

	function dummy:reverse()
		self.direction.x = self.direction.x * -1
	end

	return dummy
end
