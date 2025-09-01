Snake = Class {}

function Snake:init(x, y, size, length)
    self.x = x
    self.y = y
    self.body = {}
    self.timer = 0
    self.size = size
    self.direction = 'left'

    for i = 1, length do
        table.insert(self.body, SnakeBody(x, y, size))
        x = x + size + 1
    end
end

function Snake:update(dt)
    self.timer = self.timer + dt

    if self.timer > 0.25 then
        local nx = self.x
        local ny = self.y

        if self.direction == 'up' then
            ny = ny - self.size - 1
        elseif self.direction == 'down' then
            ny = ny + self.size + 1
        elseif self.direction == 'left' then
            nx = nx - self.size - 1
        elseif self.direction == 'right' then
            nx = nx + self.size + 1
        end

        table.insert(self.body, 1, SnakeBody(nx, ny, self.size))
        self.x = nx
        self.y = ny
        table.remove(self.body)

        self.timer = 0
    end
end

function Snake:render()
    for _, part in pairs(self.body) do
        part:render()
    end
end
