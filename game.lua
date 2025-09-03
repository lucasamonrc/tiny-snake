Game = Class {}

function Game:init(states)
    self.empty = {
        render = function() end,
        update = function() end,
        enter = function() end,
        exit = function() end
    }
    self.states = states or {}
    self.current = self.empty
end

function Game:set(state, params)
    assert(self.states[state])
    self.current:exit()
    self.current = self.states[state]()
    self.current:enter(params)
end

function Game:update(dt)
    self.current:update(dt)
end

function Game:render()
    self.current:render()
end
