Class = require 'lib.class'
local push = require 'lib.push'

require 'elements.snake'
require 'elements.snake_body'
require 'elements.food'
require 'elements.room'

WINDOW_WIDTH = 960
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 320
VIRTUAL_HEIGHT = 240

local snake
local food
local room

local score = 0

function love.load()
    math.randomseed(os.time())

    love.window.setTitle("Tiny Snake")

    love.graphics.setDefaultFilter('nearest', 'nearest')

    SmallFont = love.graphics.newFont('assets/font.ttf', 8)
    LargeFont = love.graphics.newFont('assets/font.ttf', 16)
    ScoreFont = love.graphics.newFont('assets/font.ttf', 32)

    Sounds = {
        ['countdown'] = love.audio.newSource('assets/sounds/countdown.wav', 'static'),
        ['go'] = love.audio.newSource('assets/sounds/go.wav', 'static'),
        ['pickup'] = love.audio.newSource('assets/sounds/pickup.wav', 'static'),
        ['death'] = love.audio.newSource('assets/sounds/death.wav', 'static'),
    }

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    room = Room(
        (VIRTUAL_WIDTH / 2) - (ROOM_WIDTH / 2),
        (VIRTUAL_HEIGHT / 2) - (ROOM_HEIGHT / 2),
        8
    )

    snake = Snake(room.cells[math.floor(#room.cells / 2)])
    food = Food(room:randomCell())

    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    end

    return false
end

function love.update(dt)
    if love.keyboard.wasPressed('up') and snake.direction ~= 'down' then
        snake.direction = 'up'
    elseif love.keyboard.wasPressed('down') and snake.direction ~= 'up' then
        snake.direction = 'down'
    elseif love.keyboard.wasPressed('left') and snake.direction ~= 'right' then
        snake.direction = 'left'
    elseif love.keyboard.wasPressed('right') and snake.direction ~= 'left' then
        snake.direction = 'right'
    end

    if snake:collidesSelf() then
        Sounds['death']:play()
    end

    local head = snake:head()
    if head.x < room.x
        or head.y < room.y
        or head.x >= room.x + ROOM_WIDTH
        or head.y >= room.y + ROOM_HEIGHT then
        Sounds['death']:play()
    end

    if snake:collidesFood(food) then
        Sounds['pickup']:play()
        score = score + 1
        snake.grow = true

        local cell
        repeat
            cell = room:randomCell()
        until not snake:onBody(cell)

        food.x = cell.x
        food.y = cell.y
    end

    snake:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    love.graphics.setFont(LargeFont)

    love.graphics.printf('Hello Snake!', 0, 10, VIRTUAL_WIDTH, 'center')

    room:render()
    food:render()
    snake:render()

    love.graphics.setFont(SmallFont)
    love.graphics.printf('Score: ' .. tostring(score), 10, 10, VIRTUAL_WIDTH, 'left')

    push:finish()
end
