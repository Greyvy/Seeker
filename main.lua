require "helpers"
require "vec2"
require "map"

function math_sign(v)
    if (v < 0) then
        return -1
    end
    if (v > 0) then
        return 1
    end
    return 0
end

function math_round(v)
    return math.floor(v + 0.5)
end

function actor_move_x(amount)
    local mend = math_round(math.abs(amount))
    local sgn = math_sign(amount)
    local res = 0

    for i=0,mend do
        res = res + sgn
    end
    return res
end

function actor_move_y(amount)
    local mend = math_round(math.abs(amount))
    local sgn = math_sign(amount)
    local res = 0

    for i=0,mend do
        res = res + sgn
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
        acc = 600,
        friction = 0.8,
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

    x = actor_move_x(move[1])
    y = actor_move_y(move[2])

    player.pos = vec2_add(player.pos, {x, y})

    -- @TODO(Grey): Need to find some way to scale
    -- this in a way that ends up at 0
    --[[
    player.vel[1] = player.vel[1] * 0.95
    player.vel[2] = player.vel[2] * 0.95
    --]]
    player.vel = {0, 0}

end

function love.draw()

    love.graphics.scale(scale, scale)
    love.graphics.translate(
        math.floor(-player.pos[1] + (size[1] / 2)),
        math.floor(-player.pos[2] + (size[2] / 2))
    )

    love.graphics.clear(rgb_normal({63, 63, 116}))

    Map.draw(level0)
    -- @NOTE(Grey): Draw the player
    love.graphics.setColor(rgb_normal({255, 102, 102}))
    love.graphics.arc('fill', player.pos[1], player.pos[2], player.size[1] / 2, 0, math.pi * 2, 30)


    --love.graphics.print(delta, 10, 10)
    love.graphics.print(player.vel[1], 10, 10)
    love.graphics.print(player.vel[2], 10, 25)
    --love.graphics.print(player.pos[1], 10, 40)
    --love.graphics.print(player.pos[2], 10, 55)


end

