
-- @(Grey): init
bubbles = {}
    for i=1,400 do
        table.insert(bubbles,
            {
                pos=Vec2.new({
                        love.math.random(size[1]),
                        love.math.random(size[2])
                    }),
                r=10 + love.math.random(30),
                scale = 1
            }
        )
    end


-- @NOTE(Grey): update
    for i,bub in pairs(bubbles) do
        bub.scale = map(vec2_dist(bub.pos, p.pos), 0, size[2], 0, 1)
    end


-- @NOTE(Grey): draw
    love.graphics.setColor(rgb_normal({102, 126, 255}))
    for i,bub in pairs(bubbles) do
        love.graphics.arc('line', bub.pos[1], bub.pos[2], bub.r * bub.scale, 0, math.pi * 2, 30)
    end
