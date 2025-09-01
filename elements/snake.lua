Snake = Class {}

function Snake:init(x, y, size, length)
    self.x = x
    self.y = y
    self.body = {}
    self.timer = 0
    self.direction = 'down'

    for i = 1, length do
        table.insert(self.body, SnakeBody(x, y, size))
        x = x + size + 1
    end
end

function Snake:update(dt)
    -- self.timer = self.timer + dt

    -- if self.timer > 0.25 then
    --     if self.direction == 'up' then
    --         self.y = self.y - self.size - 1
    --     elseif self.direction == 'down' then
    --         self.y = self.y + self.size + 1
    --     elseif self.direction == 'left' then
    --         self.x = self.x - self.size - 1
    --     elseif self.direction == 'right' then
    --         self.x = self.x + self.size + 1
    --     end

    --     self.timer = 0
    -- end
end

function Snake:render()
    for _, part in pairs(self.body) do
        part:render()
    end
end
