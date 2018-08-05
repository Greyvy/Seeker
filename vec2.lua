Vec2 = {}
function Vec2.new(t)
    local vec2 = {}
    setmetatable(vec2, Vec2.mt)
    vec2[1] = t[1]
    vec2[2] = t[2]
    return vec2
end

Vec2.mt = {}
Vec2.mt.__add = vec2_add
Vec2.mt.__sub = vec2_sub
Vec2.mt.__mul = vec2_mul

function vec2_add(v1, v2)
    return {v1[1] + v2[1], v1[2] + v2[2]}
end

function vec2_sub(v1, v2)
    return {v1[1] - v2[1], v1[2] - v2[2]}
end

function vec2_mul(v1, v2)
    return {v1[1] * v2[1], v1[2] * v2[2]}
end

function vec2_scale(v1, scalar)
    return {v1[1] * scalar, v1[2] * scalar}
end

function vec2_dist(v1, v2)
    local x = v2[1] - v1[1]
    local y = v2[2] - v1[2]
    return math.sqrt(x * x + y * y)
end
