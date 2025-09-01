Snake = Class {}

function Snake:init(cell)
    self.direction = 'right'
    self.grow = false
    self.timer = 0

    self.body = {}

    local x = cell.x
    for _ = 3, 1, -1 do
        table.insert(self.body, SnakeBody(x, cell.y, cell.size))
        x = x - cell.size
    end
end

function Snake:head()
    return self.body[1]
end

function Snake:collidesFood(food)
    local head = self:head()
    return head.x == food.x and head.y == food.y
end

function Snake:collidesSelf()
    local head = self:head()

    for i = 2, #self.body do
        local segment = self.body[i]
        if segment.x == head.x and segment.y == head.y then
            return true
        end
    end

    return false
end

function Snake:onBody(cell)
    for _, segment in pairs(self.body) do
        if segment.x == cell.x and segment.y == cell.y then
            return true
        end
    end

    return false
end

function Snake:update(dt)
    self.timer = self.timer + dt

    if self.timer > 0.25 then
        local head = self:head()
        local nx = head.x
        local ny = head.y

        if self.direction == 'up' then
            ny = ny - head.size
        elseif self.direction == 'down' then
            ny = ny + head.size
        elseif self.direction == 'left' then
            nx = nx - head.size
        elseif self.direction == 'right' then
            nx = nx + head.size
        end

        table.insert(self.body, 1, SnakeBody(nx, ny, head.size))

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
