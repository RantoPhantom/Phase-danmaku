Movable = {
	x = 0,
	y = 0,
	speed = 300,
	width = 0,
	height = 0,
}

function Movable:update(dt)
	self:move(dt)
end

function Movable:move(dt)
	error("not implemented")
end

function Movable:get_move_direction()
	error("not implemented")
end
