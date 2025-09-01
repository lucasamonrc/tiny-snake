RoomCell = Class {}

function RoomCell:init(x, y, size)
    self.x = x
    self.y = y
    self.size = size
end

function RoomCell:render()
    love.graphics.rectangle(
        'line',
        self.x,
        self.y,
        self.size,
        self.size
    )
end

Room = Class {}

ROOM_WIDTH = 262
ROOM_HEIGHT = 192

function Room:init(x, y, cell_size)
    self.x = x
    self.y = y

    self.rows = math.floor(ROOM_HEIGHT / cell_size)
    self.cols = math.floor(ROOM_WIDTH / cell_size)
    self.cells = {}

    for _ = 1, self.rows do
        for _ = 1, self.cols do
            table.insert(self.cells, RoomCell(x, y, cell_size))
            x = x + cell_size
        end
        x = self.x
        y = y + cell_size
    end
end

function Room:randomCell()
    return self.cells[math.random(#self.cells)]
end

function Room:render()
    love.graphics.rectangle(
        'line',
        self.x,
        self.y,
        ROOM_WIDTH,
        ROOM_HEIGHT
    )
end
