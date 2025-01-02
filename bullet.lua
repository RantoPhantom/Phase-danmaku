function NewBullet(sprite_path, init_x, init_y, speed, direction)
	local bullet = {
		sprite = love.graphics.newImage(sprite_path),
		x = init_x,
		y = init_y,
		speed = speed,
		direction = direction,

		update = function(self, dt)
			self.x = self.x + self.direction.x * speed * dt
			self.y = self.y + self.direction.y * speed * dt
		end,
	}
	return bullet
end
