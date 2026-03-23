local util = {}

function util.addon_log(str)
    windower.add_to_chat(161, str)
end

function util.has_bit(data, position)
    return data:unpack('q', math.floor(position/8)+1, position%8+1)
end

function util.char_field_to_table(str)
    local t = {}
    for i = 1, #str do
        t[i - 1] = str:byte(i)
    end
    return t
end

return util