local mons_util = {}
local map_species = require('../maps/monstrosity_species')
local map_species_variants = require('../maps/monstrosity_species_variants')
local map_racejobinstincts = require('../maps/monstrosity_racejobinstincts')
local map_monsterinstincts = require('../maps/monstrosity_instincts')
local monster_levels = nil
local racejobinstincts = nil
local variants_bitfield = nil
local monster_instincts = nil

local totalspecies, obtainedspecies = 0, 0
local totalracejobinstincts, obtainedracejobinstincts = 0, 0

function mons_util.log_racejobinstincts()
	if mons_util.racejobinstincts==nil then return end
	local racejobinstincts_list = {}
	local total, obtained = 0, 0
	for id, instinctname in pairs(map_racejobinstincts) do
		total = total+1
		if util.has_bit(mons_util.racejobinstincts, id) then
			obtained = obtained+1
			--table.insert(racejobinstincts_list, '\\cs(0,255,0) ' .. instinctname ..'\\cr') -- add obtained race/job instinct
		else
			table.insert(racejobinstincts_list, '\\cs(255,255,0) ' .. instinctname ..'\\cr') -- add unobtained race/job instinct
		end
	end
	playertracker['Racejobinstinct_completed'] = obtained
	playertracker['Racejobinstinct_total'] = total	
	return racejobinstincts_list
end

function mons_util.log_monsterlevels()
	if mons_util.monster_levels==nil then return end
	local species_list = {}
	local total, complete = 0, 0
	for id, monster in pairs(map_species) do
		total = total+99
		table.insert(species_list, '\\cs(255,255,0) Lv. ' .. mons_util.monster_levels[id] .. ' ' .. monster ..'\\cr') -- add monster
		complete = complete + mons_util.monster_levels[id]
	end
	playertracker['MonsterLevels_completed'] = complete
	playertracker['MonsterLevels_total'] = total	
	return species_list
end

function mons_util.log_variants()
	if mons_util.variants_bitfield==nil then return end
	local variants_list = {}
	local total, obtained = 0, 0
	for id, variantname in pairs(map_species_variants) do
		total = total+1
		if util.has_bit(mons_util.variants_bitfield, (id-256)) then
			obtained = obtained+1
			--table.insert(variants_list, '\\cs(0,255,0) ' .. variantname ..'\\cr') -- add obtained monster variant
		else
			table.insert(variants_list, '\\cs(255,255,0) ' .. variantname ..'\\cr') -- add unobtained monster variant
		end
	end
	playertracker['MonsterVariants_completed'] = obtained
	playertracker['MonsterVariants_total'] = total	
	return variants_list
end

function mons_util.log_monsterinstincts()
	if mons_util.monster_instincts==nil then return end
	local monsterinstincts_list = {}
	--local instincts_unlocks = util.twobits_to_table(mons_util.monster_instincts)
	local total, obtained = 0, 0
	for table_id, unlocked_level in pairs(mons_util.monster_instincts) do
		total = total+3
		local instinct_index_base = 3 * (table_id - 1)
		for instinct_index=1, 3 do
			if (unlocked_level >= instinct_index) then
				if (map_monsterinstincts[instinct_index_base+instinct_index]) then
					obtained = obtained+1
					total = total+1
					--table.insert(monsterinstincts_list, '\\cs(0,255,0)' .. map_monsterinstincts[instinct_index_base+instinct_index] .. '\\cr') -- add obtained monster instinct
				end
			else
				if (map_monsterinstincts[instinct_index_base+instinct_index]) then
					total = total+1
					table.insert(monsterinstincts_list, '\\cs(255,255,0)' .. map_monsterinstincts[instinct_index_base+instinct_index] .. '\\cr') -- add non obtained monster instinct
				end
			end

		end
	end
	playertracker['MonsterInsincts_completed'] = obtained
	playertracker['MonsterInsincts_total'] = total	
	return monsterinstincts_list
end

return mons_util