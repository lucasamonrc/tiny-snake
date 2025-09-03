TitleState = Class { __includes = BaseState }

function TitleState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        State:set('countdown')
    end
end

function TitleState:render()
    love.graphics.setFont(LargeFont)
    love.graphics.printf('Hello Snake!', 0, 64, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(ScoreFont)
    love.graphics.printf('Press ENTER to start', 0, 100, VIRTUAL_WIDTH, 'center')
end
