require "helpers"
require "vec2"
require "map"


function collision(actor, map)
    local actor_w = actor.size[1]
    local actor_h = actor.size[2]
    local collisions = {}

    for i=1,#map.collision do
        if map.collision[i] == 1 then
            local t = Map.tile_to_screen(map, map.collision, i)
            if (actor.pos[1] + actor.size[1] > t.pos[1] and
                actor.pos[1] < t.pos[1] + t.size[1] and
                actor.pos[2] + actor.size[2] > t.pos[2] and
                actor.pos[2] < t.pos[2] + t.size[2]) then
                table.insert(collisions, t)
            end
        end
    end

    if #collisions > 0 then
        return collisions
    end

    return false
end


function actor_move_x(level, actor, amount)
    local mend = math_round(math.abs(amount))
    local sgn = math_sign(amount)
    local res = 0

    for i=0,mend do
        local test = {
            pos = {actor.pos[1] + (res + sgn), actor.pos[2]},
            size = actor.size
        }
        local cols = collision(test, level)
        if cols then
            return res
        else
            res = res + sgn
        end
    end

    return res
end

function actor_move_y(level, actor, amount)
    local mend = math_round(math.abs(amount))
    local sgn = math_sign(amount)
    local res = 0

    for i=0,mend do
        local test = {
            pos = {actor.pos[1], actor.pos[2] + (res + sgn)},
            size = actor.size
        }
        local cols = collision(test, level)
        if cols then
            return res
        else
            res = res + sgn
        end
    end

    return res
end


function love.keyreleased(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == 'r' then
        love.load()
    end
end

function love.load()
    -- @TODO(Grey): Fix this so scale/size have a proper relationship
    -- right now scale will completely goof with the way the camera works
    scale = 1
    size = {640 * 2, 360 * 2}

    level0 = Map.new(64, 64, "tile00.png")
    player = {
        pos = {320, 250},
        vel = {0, 0},
        acc = 200,
        friction = 0.5,
        size = {32, 32},
    }
    love.window.setMode(size[1], size[2], { borderless = true })
end

function love.update(dt)

    if love.keyboard.isDown("w") then
        player.vel[2] = player.vel[2] + -player.acc
    end

    if love.keyboard.isDown("a") then
        player.vel[1] = player.vel[1] + -player.acc
    end

    if love.keyboard.isDown("s") then
        player.vel[2] = player.vel[2] + player.acc
    end

    if love.keyboard.isDown("d") then
        player.vel[1] = player.vel[1] + player.acc
    end


    move = vec2_scale(player.vel, dt)

    cols = collision(player, level0)

    x = actor_move_x(level0, player, move[1])
    y = actor_move_y(level0, player, move[2])

    player.pos = vec2_add(player.pos, {x, y})

    player.vel[1] = player.vel[1] * player.friction
    player.vel[2] = player.vel[2] * player.friction
    if math.abs(player.vel[1]) < 0.0015 then player.vel[1] = 0 end
    if math.abs(player.vel[2]) < 0.0015 then player.vel[2] = 0 end

end

function love.draw()

    love.graphics.scale(scale, scale)
    love.graphics.translate(
        math.floor(-player.pos[1] + (size[1] / 2)),
        math.floor(-player.pos[2] + (size[2] / 2))
    )

    love.graphics.clear(rgb_normal({63, 63, 116}))

    Map.draw(level0)

    love.graphics.setColor(rgb_normal({255, 102, 102}))
    x, y = unpack(player.pos)
    r = player.size[1] / 2
    -- love.graphics.arc('fill', x - r, y - r, r, 0, math.pi * 2, 30)
    love.graphics.rectangle('line', x, y, r * 2, r * 2)


    -- @NOTE(Grey): Draw some debug info
    love.graphics.setColor(rgb_normal({255, 0, 107}))
    if cols then
        for k,v in pairs(cols) do
            x, y = unpack(v.pos)
            w, h = unpack(v.size)
            love.graphics.rectangle('line', x, y, w, h)
        end
    end

end

