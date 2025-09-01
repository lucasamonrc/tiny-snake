Class = require 'lib.class'
local push = require 'lib.push'

require 'elements.snake'
require 'elements.snake_body'

WINDOW_WIDTH = 960
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 320
VIRTUAL_HEIGHT = 240

local snake = Snake(VIRTUAL_WIDTH / 2 - 4, VIRTUAL_HEIGHT / 2 - 4, 8, 3)

function love.load()
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

    snake:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    love.graphics.setFont(LargeFont)

    love.graphics.printf('Hello Snake!', 0, 20, VIRTUAL_WIDTH, 'center')

    snake:render()

    push:finish()
end
