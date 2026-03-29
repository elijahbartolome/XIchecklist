local menus_util = {}

menus_util.menu_npcs = {
	['Conrad'] = {entityid=17735859, zoneid=234, menuid=584, menu_function=warps_util.handle_op_warps}, -- Bastok Mines
	['Jeanvirgaud'] = {entityid=17723597, zoneid=231, menuid=864, menu_function=warps_util.handle_op_warps}, -- Northern San d'Oria
	['Rottata'] = {entityid=17760439, zoneid=240, menuid=653, menu_function=warps_util.handle_op_warps}, -- Port Windurst
}

function menus_util.handle_npc_menu(data)
	parseddata = packets.parse('incoming', data)
	local index = parseddata['NPC Index']
	local npc = index and windower.ffxi.get_mob_by_index(index).name
	if not npc or not menus_util.menu_npcs[npc] then
		return
	end
	local zone_id = windower.ffxi.get_info().zone
	if ((menus_util.menu_npcs[npc].zoneid == windower.ffxi.get_info().zone) and (menus_util.menu_npcs[npc].menuid == parseddata['Menu ID'])) then
		menus_util.menu_npcs[npc]['menu_function'](data)
	end
end

return menus_util