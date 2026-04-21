local warps_util = {}
local warps_data = nil

local warps = {
	homepoints = {data = {0x08+1, 0x17+1}, map = require('../maps/warps_homepoints')},
	survivalguides = {data = {0x18+1, 0x27+1}, map = require('../maps/warps_survivalguides')},
	waypoints = {data = {0x28+1 , 0x2E+1}, map = require('../maps/warps_waypoints')},
}

function warps_util.checkwarps(warptype)
	if warps_util.warps_data == nil then return end
	local subdata = warps_util.warps_data:sub(warps[warptype].data[1], warps[warptype].data[2])
	local total, obtained = 0, 0
	output_list = {}
	-- check for obtained warp
	for index, name in pairs(warps[warptype].map) do
		total = total+1
		local completion = false
		if (util.has_bit(subdata, index+1)) then
			obtained = obtained+1
			completion = true
		end
		table.insert(output_list, util.list_item(warptype, name, completion))
	end
	tab_logs[warptype..'_completed'] = obtained
	tab_logs[warptype..'_total'] = total		
	return output_list
end

return warps_util