Food = Class {}

function Food:init(cell)
    self.x = cell.x
    self.y = cell.y
    self.size = cell.size
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
