-- @NOTE(Grey): Helper functions
function clamp(v, min, max)
    if (v < min) then
        return min
    end
    if (v > max) then
        return max
    end
    return v
end

-- @NOTE(Grey): Map a number from a range to a range
function map(v, start1, stop1, start2, stop2, constrain)
    local val = (v - start1) / (stop1 - start1) * (stop2 - start2) + start2
    if not constrain then
        return val
    end
    return clamp(val, start2, stop2)
end

-- @NOTE(Grey): convert 0-255 to 0-1 for rgb
function rgb_normal(t)
    return {t[1] / 255, t[2] / 255, t[3] / 255}
end

function table_merge(t1, t2)
    for k,v in pairs(t2) do
        t1[k] = v
    end
    return t1
end

