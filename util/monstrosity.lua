local mons_util = {}
local map_species = require('../maps/monstrosity_species')
local map_species_variants = require('../maps/monstrosity_species_variants')
local map_racejobinstincts = require('../maps/monstrosity_racejobinstincts')
local map_monsterinstincts = require('../maps/monstrosity_instincts')
mons_util.monster_levelspacket = {
	[1] = nil,
	[2] = nil,
}
local monster_levels = nil
local racejobinstincts = nil
local variants_bitfield = nil
local monster_instincts = nil

local totalspecies, obtainedspecies = 0, 0
local totalracejobinstincts, obtainedracejobinstincts = 0, 0

function mons_util.log_racejobinstincts()
	if mons_util.racejobinstincts==nil or mons_util.racejobinstincts==0 then return end
	local output_list = {}
	local total, obtained = 0, 0
	for id, name in pairs(map_racejobinstincts) do
		total = total+1
		local completion = false
		if util.has_bit(mons_util.racejobinstincts, id +1) then
			obtained = obtained+1
			completion = true
		end
		table.insert(output_list, util.list_item(nil, name, completion))
	end
	tab_logs['Racejobinstinct_completed'] = obtained
	tab_logs['Racejobinstinct_total'] = total	
	return output_list
end

function mons_util.log_monsterlevels()
	if (mons_util.monster_levelspacket[1] == nil or mons_util.monster_levelspacket[2] == nil) then 
		return
	else 
		mons_util.monster_levels = util.table_concat(mons_util.monster_levelspacket[1], mons_util.monster_levelspacket[2])
	end
	if mons_util.monster_levels==nil then return end
	local monster_level_bytes = util.byte_to_table_reverse(mons_util.monster_levels)
	local output_list = {}
	local total, complete = 0, 0
	for id, monster in pairs(map_species) do
		total = total+99
		local completion = false
		local monster_level = 0
		if (id ~= 254 and id ~= 255) then
			monster_level = monster_level_bytes[id+1]
		elseif (id == 254) then
			monster_level = monster_level_bytes[129]
		elseif (id == 255) then
			monster_level = monster_level_bytes[130]
		end
		complete = complete + monster_level
		if (monster_level == 99) then completion = true end
		table.insert(output_list, util.list_item(nil, 'Lv. ' .. (monster_level) .. ' ' .. monster, completion)) -- add monster
	end
	tab_logs['MonsterLevels_completed'] = complete
	tab_logs['MonsterLevels_total'] = total	
	return output_list
end

function mons_util.log_variants()
	if mons_util.variants_bitfield==nil or mons_util.variants_bitfield==0 then return end
	local output_list = {}
	local total, obtained = 0, 0
	for id, name in pairs(map_species_variants) do
		total = total+1
		local completion = false
		if util.has_bit(mons_util.variants_bitfield, (id-256)) then
			obtained = obtained+1
			completion = true
		end
		table.insert(output_list, util.list_item(nil, name, completion))
	end
	tab_logs['MonsterVariants_completed'] = obtained
	tab_logs['MonsterVariants_total'] = total	
	return output_list
end

function mons_util.log_monsterinstincts()
	if mons_util.monster_instincts==nil or mons_util.monster_instincts==nil then return end
	local output_list = {}
	--local instincts_unlocks = util.twobits_to_table(mons_util.monster_instincts)
	local total, obtained = 0, 0
	for table_id, unlocked_level in pairs(mons_util.monster_instincts) do
		--total = total+3
		local instinct_index_base = 3 * (table_id)
		for instinct_index=1, 3 do
			local completion = false
			if (map_monsterinstincts[instinct_index_base+instinct_index]) then
				total = total+1
				if (unlocked_level >= instinct_index) then
					obtained = obtained+1
					completion = true
				end
				table.insert(output_list, util.list_item(nil, map_monsterinstincts[instinct_index_base+instinct_index], completion))
			end

		end
	end
	tab_logs['MonsterInsincts_completed'] = obtained
	tab_logs['MonsterInsincts_total'] = total	
	return output_list
end

return mons_util