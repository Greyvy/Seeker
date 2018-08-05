
Map = {}

function Map.new(tw, th, tilesheet)
    sheet = love.graphics.newImage(tilesheet)
    return {
        tilesize = {tw, th},
        size = {10, 10},
        tilesheet = sheet,
        entities = {
            { type = "player", pos = { 320, 450 } }
        },
        tiles = {
            3,3,3,3,3,3,3,3,3,3,
            3,1,1,1,1,1,1,2,1,3,
            3,1,1,2,1,2,2,1,1,3,
            3,1,1,1,1,2,2,1,1,3,
            3,1,1,1,2,2,2,2,1,3,
            3,1,1,1,1,2,1,1,1,3,
            3,1,1,2,1,1,1,1,1,3,
            3,1,1,2,2,2,1,1,1,3,
            3,1,1,1,1,1,1,1,1,3,
            3,3,3,3,3,3,3,3,3,3,
        },
        collision = {
            1,1,1,1,1,1,1,1,1,1,
            1,0,0,0,0,0,0,0,0,1,
            1,0,0,0,0,0,0,0,0,1,
            1,0,0,0,0,0,0,0,0,1,
            1,0,0,0,0,0,0,0,0,1,
            1,0,0,0,0,0,0,0,0,1,
            1,0,0,0,0,0,0,0,0,1,
            1,0,0,0,0,0,0,0,0,1,
            1,0,0,0,0,0,0,0,0,1,
            1,1,1,1,1,1,1,1,1,1,
        }
    }
end

function Map.draw(m)
    local tw = m.tilesize[1]
    local th = m.tilesize[2]
    local tsw, tsh = m.tilesheet:getDimensions()
    local tiles = {}

    for i=0,tsw,tw do
        table.insert(tiles, love.graphics.newQuad(i, 0, tw, th, tsw, tsh))
    end

    love.graphics.setColor(1, 1, 1, 1)
    for k,v in pairs(m.tiles) do
        local x = (k - 1) % m.size[1] * m.tilesize[1]
        local y = math.floor((k - 1) / m.size[2]) * m.tilesize[2]
        love.graphics.draw(m.tilesheet, tiles[v], x, y)
    end
end

