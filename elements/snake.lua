Snake = Class {}

function Snake:init(x, y, size, length)
    self.x = x
    self.y = y
    self.body = {}
    self.timer = 0
    self.size = size
    self.direction = 'left'
    self.grow = false

    for i = 1, length do
        table.insert(self.body, SnakeBody(x, y, size))
        x = x + size
    end
end

function Snake:collides(food)
    if (self.x) + (self.size / 2) >= food.x and self.x <= food.x + food.size then
        if (self.y) + (self.size / 2) >= food.y and self.y <= food.y + food.size then
            return true
        end
    end

    return false
end

function Snake:update(dt)
    self.timer = self.timer + dt

    if self.timer > 0.25 then
        local nx = self.x
        local ny = self.y

        if self.direction == 'up' then
            ny = ny - self.size
        elseif self.direction == 'down' then
            ny = ny + self.size
        elseif self.direction == 'left' then
            nx = nx - self.size
        elseif self.direction == 'right' then
            nx = nx + self.size
        end

        table.insert(self.body, 1, SnakeBody(nx, ny, self.size))
        self.x = nx
        self.y = ny

        if not self.grow then
            table.remove(self.body)
        end

        self.grow = false
        self.timer = 0
    end
end

function Snake:render()
    for _, part in pairs(self.body) do
        part:render()
    end
end
