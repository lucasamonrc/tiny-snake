Food = Class {}

function Food:init(x, y, size)
    self.x = x
    self.y = y
    self.size = size
end

function Food:render()
    love.graphics.rectangle(
        'fill',
        self.x,
        self.y,
        self.size,
        self.size
    )
end
