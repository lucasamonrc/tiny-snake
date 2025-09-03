Class = require 'lib.class'
local push = require 'lib.push'

require 'elements.snake'
require 'elements.snake_body'
require 'elements.food'
require 'elements.room'

require 'game'
require 'states.base'
require 'states.countdown'
require 'states.play'
require 'states.score'
require 'states.title'

WINDOW_WIDTH = 960
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 320
VIRTUAL_HEIGHT = 240

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

    Room = Room(
        (VIRTUAL_WIDTH / 2) - (ROOM_WIDTH / 2),
        (VIRTUAL_HEIGHT / 2) - (ROOM_HEIGHT / 2),
        8
    )

    State = Game {
        ['title'] = function() return TitleState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
    }
    State:set('title')

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
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
    State:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)
    State:render()
    push:finish()
end
