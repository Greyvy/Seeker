-- @NOTE(Grey): Helper functions

-- @NOTE(Grey): Math functions
function clamp(v, min, max)
    if (v < min) then
        return min
    end
    if (v > max) then
        return max
    end
    return v
end

function map(v, start1, stop1, start2, stop2, constrain)
    local val = (v - start1) / (stop1 - start1) * (stop2 - start2) + start2
    if not constrain then
        return val
    end
    return clamp(val, start2, stop2)
end

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


-- @NOTE(Grey): convert 0-255 to 0-1 for rgb
function rgb_normal(t)
    return {t[1] / 255, t[2] / 255, t[3] / 255}
end


-- @NOTE(Grey): Table helpers
function table_merge(t1, t2)
    for k,v in pairs(t2) do
        t1[k] = v
    end
    return t1
end

