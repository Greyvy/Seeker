
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
        local t = Map.tile_to_screen(m, m.tiles, k)
        love.graphics.draw(m.tilesheet, tiles[v], t.pos[1], t.pos[2])
    end
end

function Map.tile_to_screen(m, map_layer, index)
    local x = (index - 1) % m.size[1] * m.tilesize[1]
    local y = math.floor((index - 1) / m.size[2]) * m.tilesize[2]

    return {
        pos = { x, y },
        size = { m.tilesize[1], m.tilesize[2] }
    }
end

