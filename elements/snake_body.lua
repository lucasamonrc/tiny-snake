SnakeBody = Class {}

function SnakeBody:init(x, y, size)
    self.x = x
    self.y = y
    self.size = size
end

function SnakeBody:update(x, y)
    self.x = x
    self.y = y
end

function SnakeBody:render()
    love.graphics.rectangle(
        'fill',
        self.x,
        self.y,
        self.size,
        self.size
    )
end
