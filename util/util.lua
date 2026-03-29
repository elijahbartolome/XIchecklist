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

local bit = require('bit')

function util.twobits_to_table(data)
-- Extract 2-bit values into a table
	local result = {}
	for i = 1, #data do
		local byte = data:byte(i)
		-- Each byte contains 4 values (2 bits each)
		for j = 0, 3 do
			local shift = j * 2
			local value = bit.band(bit.rshift(byte, shift), 0x03)
			result[#result + 1] = value
		end
	end
	return result
end

function util.cleanspaces(str)
    return str:gsub(" ", "_")
end

return util