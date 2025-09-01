SnakeBody = Class {}

function SnakeBody:init(x, y, size)
    self.x = x
    self.y = y
    self.size = size
end

function SnakeBody:render()
    love.graphics.setColor(155 / 255, 188 / 255, 15 / 255, 255 / 255)
    love.graphics.rectangle(
        'fill',
        self.x,
        self.y,
        self.size,
        self.size
    )
    love.graphics.setColor(1, 1, 1, 1)
end
