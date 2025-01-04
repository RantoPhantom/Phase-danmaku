function NewBullet(sprite_path, init_x, init_y, speed, direction)
	local bullet = {
		sprite = love.graphics.newImage(sprite_path),
		x = init_x,
		y = init_y,
		speed = speed,
		direction = direction,
	}
	bullet.width, bullet.height = bullet.sprite:getDimensions()

	function bullet:update(dt)
		self.x = self.x + self.direction.x * speed * dt
		self.y = self.y + self.direction.y * speed * dt
	end

	function bullet:draw()
		love.graphics.draw(self.sprite, self.x,self.y,0,1,1, self.width/2, self.height/2)
	end
	return bullet
end
