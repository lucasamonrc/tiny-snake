PlayState = Class { __includes = BaseState }

function PlayState:init()
    self.snake = Snake(Room.cells[5])
    self.food = Food(Room:randomCell())
    self.score = 0
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('up') and self.snake.direction ~= 'down' then
        self.snake.direction = 'up'
    elseif love.keyboard.wasPressed('down') and self.snake.direction ~= 'up' then
        self.snake.direction = 'down'
    elseif love.keyboard.wasPressed('left') and self.snake.direction ~= 'right' then
        self.snake.direction = 'left'
    elseif love.keyboard.wasPressed('right') and self.snake.direction ~= 'left' then
        self.snake.direction = 'right'
    end

    if self.snake:collidesSelf() then
        Sounds['death']:play()
        State:set('score', { score = self.score })
    end

    local head = self.snake:head()
    if head.x < Room.x
        or head.y < Room.y
        or head.x >= Room.x + ROOM_WIDTH
        or head.y >= Room.y + ROOM_HEIGHT then
        Sounds['death']:play()
        State:set('score', { score = self.score })
    end

    if self.snake:collidesFood(self.food) then
        Sounds['pickup']:play()
        self.score = self.score + 1
        self.snake.grow = true

        local cell
        repeat
            cell = Room:randomCell()
        until not self.snake:onBody(cell)

        self.food.x = cell.x
        self.food.y = cell.y
    end

    self.snake:update(dt)
end

function PlayState:render()
    Room:render()
    self.food:render()
    self.snake:render()

    love.graphics.setFont(SmallFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 10, 10, VIRTUAL_WIDTH, 'left')
end
