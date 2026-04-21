local imgui = require('imgui');
local ui = {}
local tabs = {
    'Main', 'Quests', 'Campaign', 'Fish', 'Key Items', 'Magic', 'Warps', 'Monstrosity', 'Titles', 'RoE', 'Battle Content'
}

local function append_items(src)
    if type(src) ~= 'table' then
        return
    end
    for _, item in ipairs(src) do
		local text = item.text
		local display = true
		local menucolor = { 1.0, 0.0, 0.0, 1.0 }
		if (item.completed == true and trackermenusettings.showcompleted == false) then
			display = false
		end
		if item.category ~= nil then 
			text = '['..item.category..'] '..text
		end
		if item.category == 'Addon Help' then
			menucolor = {1.0, 1.0, 0.0, 1.0}
		end
		if item.completed == true then
			menucolor = {0.0, 1.0, 0.0, 1.0}
		end
		if item.obtainmethod ~= nil then 
			text = text..item.obtainmethod
		end
		if (display == true) then
			imgui.TextColored(menucolor, text)
		end
    end
end

local function append_maintab(text, ...)
	local args = {...}
	local menulinecolor = { 1.0, 0.0, 0.0, 1.0 }
	if (args[1]==args[2]) then menulinecolor = {0.0, 1.0, 0.0, 1.0} end
	imgui.TextColored(menulinecolor, '-'..text:format(...))
end

local function append_header(text, ...)
	local args = {...}
	local menulinecolor = { 1.0, 0.0, 0.0, 1.0 }
	if (args[1]==args[2]) then menulinecolor = {0.0, 1.0, 0.0, 1.0} end
	text = '==== '..text..' ===='
		imgui.TextColored(menulinecolor, text:format(...))
	if args[2] == 0 then
		imgui.TextColored({1.0, 235/255, 0.0, 0.0}, 'You must zone to update.')
	end
	
end

local function append_addonhelp(text, condition)
	append_items({util.list_item('Addon Help', text, condition)})
end

local function update_maintab()
	
	append_maintab('Mastery Rank: %d', playertracker['mastery_rank'])
	append_maintab('Checklist Progress %d/%d', util.totalpoints())
	imgui.Text('======= RoE =======')
	append_maintab('RoE %d/%d', playertracker['RoE_completed'], playertracker['RoE_total'])
	
	imgui.Text( '======= Quests & Ops =======')
	append_maintab('Campaign Ops %d/%d', playertracker['campaign_completed'], playertracker['campaign_total'])
	append_maintab('Bastok Quests %d/%d', playertracker['bastok_completed'], playertracker['bastok_total'])
	append_maintab('San d\'Oria Quests %d/%d', playertracker['sandoria_completed'], playertracker['sandoria_total'])
	append_maintab('Windurst Quests %d/%d', playertracker['windurst_completed'], playertracker['windurst_total'])
	append_maintab('Jeuno Quests %d/%d', playertracker['jeuno_completed'], playertracker['jeuno_total'])
	append_maintab('Aht Urhgan Quests %d/%d', playertracker['ahturhgan_completed'], playertracker['ahturhgan_total'])
	append_maintab('Crystal War Quests %d/%d', playertracker['crystalwar_completed'], playertracker['crystalwar_total'])
	append_maintab('Outlands Quests %d/%d', playertracker['outlands_completed'], playertracker['outlands_total'])
	append_maintab('Other Quests %d/%d', playertracker['other_completed'], playertracker['other_total'])
	append_maintab('Abyssea Quests %d/%d', playertracker['abyssea_completed'], playertracker['abyssea_total'])
	append_maintab('Adoulin Quests %d/%d', playertracker['adoulin_completed'], playertracker['adoulin_total'])
	append_maintab('Coalition Assignments %d/%d', playertracker['coalition_completed'], playertracker['coalition_total'])
	
	imgui.Text( '======= Key Items =======')
	append_maintab('Permanent Key Items %d/%d', playertracker['Permanent_Key_Items_completed'], playertracker['Permanent_Key_Items_total'])
	append_maintab('Magical Maps %d/%d', playertracker['Magical_Maps_completed'], playertracker['Magical_Maps_total'])
	append_maintab('Mounts %d/%d', playertracker['Mounts_completed'], playertracker['Mounts_total'])
	append_maintab('Claim Slips %d/%d', playertracker['Claim_Slips_completed'], playertracker['Claim_Slips_total'])
	append_maintab('Active Effects %d/%d', playertracker['Active_Effects_completed'], playertracker['Active_Effects_total'])
	append_maintab('Voidwatch %d/%d', playertracker['Voidwatch_completed'], playertracker['Voidwatch_total'])
	append_maintab('Atmacite Levels %d/%d', playertracker['atmacitelevels_completed'], playertracker['atmacitelevels_total'])
	append_addonhelp( 'You must talk to any Atmacite Refiner (Menu: Enrich Atmas)', playertracker.talk_to_npc['atmacite_refiner'])
	
	imgui.Text( '======= Magic =======')
	append_maintab('White Magic %d/%d', playertracker['WhiteMagic_completed'], playertracker['WhiteMagic_total'])
	append_maintab('Black Magic %d/%d', playertracker['BlackMagic_completed'], playertracker['BlackMagic_total'])
	append_maintab('Summoner Pacts %d/%d', playertracker['SummonerPact_completed'], playertracker['SummonerPact_total'])
	append_maintab('Ninjutsu %d/%d', playertracker['Ninjutsu_completed'], playertracker['Ninjutsu_total'])
	append_maintab('Bard Songs %d/%d', playertracker['BardSong_completed'], playertracker['BardSong_total'])
	append_maintab('Blue Magic %d/%d', playertracker['BlueMagic_completed'], playertracker['BlueMagic_total'])
	append_maintab('Geomancy %d/%d', playertracker['Geomancy_completed'], playertracker['Geomancy_total'])
	append_maintab('Trusts %d/%d', playertracker['Trust_completed'], playertracker['Trust_total'])

	imgui.Text('======= Leveling =======')
	append_maintab('Craft Skills %d/%d', playertracker['craftingskills_completed'], 790)
	append_maintab('Wing Skill %d/%d', playertracker['wingskill_completed'], 100)
	append_addonhelp( 'You must talk to any Chocobo stats NPC @ Nations Chocobo Stables', playertracker.talk_to_npc['chocobokid'])
	append_maintab('Merit Points %d/%d', playertracker['Meritpoints_completed'], 919)
	append_maintab('Job Points %d/%d', playertracker['Jobpoints_completed'], 46200)
	append_maintab('Master Levels %d/%d (Highest: %d)', playertracker['Masterlevels_completed'], 1100, playertracker['Masterlevels_highest'])
	
	imgui.Text( '======= Warps =======')
	append_maintab('Home Points %d/%d', playertracker['homepoints_completed'], playertracker['homepoints_total'])
	append_maintab('Survival Guides %d/%d', playertracker['survivalguides_completed'], playertracker['survivalguides_total'])
	append_maintab('Waypoints %d/%d', playertracker['waypoints_completed'], playertracker['waypoints_total'])
	append_maintab('Outposts %d/%d', playertracker['outposts_completed'], playertracker['outposts_total'])
	append_addonhelp( 'You must talk to any Outpost Teleporter NPC @ three nations.', playertracker.talk_to_npc['outpostnpc'])
	append_maintab('Proto-Waypoints %d/%d', playertracker['protowaypoints_completed'], playertracker['protowaypoints_total'])
	append_addonhelp( 'You must talk to any Proto-Waypoint.', playertracker.talk_to_npc['protowaypoint'])
	
	imgui.Text( '======= Fishing =======')
	append_maintab('Fishes Caught %d/%d', playertracker['fishes_completed'], 164)
	append_addonhelp( 'You must talk to Katsunaga @ Mhuaura (H-9) (Menu: Types of fishes caught)', playertracker.talk_to_npc['katsunaga'])
	
	imgui.Text( '======= Monstrosity =======')
	append_maintab('Monster Levels %d/%d', playertracker['MonsterLevels_completed'], playertracker['MonsterLevels_total'])
	append_maintab('Race/Job Instincts %d/%d', playertracker['Racejobinstinct_completed'], playertracker['Racejobinstinct_total'])
	append_maintab('Monster Variants %d/%d', playertracker['MonsterVariants_completed'], playertracker['MonsterVariants_total'])
	append_maintab('Monster Instincts %d/%d', playertracker['MonsterInsincts_completed'], playertracker['MonsterInsincts_total'])
	
	imgui.Text( '======= Battle Content =======')
	append_maintab('MMM Vouchers Unlocked %d/%d', playertracker['mmmvouchers_completed'], playertracker['mmmvouchers_total'])
	append_maintab('MMM Runes Unlocked %d/%d', playertracker['mmmrunes_completed'], playertracker['mmmrunes_total'])
	append_maintab('MMM Maze count %d', playertracker['mmm_mazecount'])
	append_addonhelp('You must talk to any Chatnachoq @ Lower Jeuno (H-9) ', playertracker.talk_to_npc['chatnachoq'])
	append_maintab('Meeble Burrows Goal #3 %d/%d', playertracker['meebleburrows_completed'], playertracker['meebleburrows_total'])
	append_addonhelp('You must talk to Burrow Investigator @ Upper Jeuno (I-8)', playertracker.talk_to_npc['meeble_sauromugue'])
	append_addonhelp( 'Menu: Review expedition specifics -> Sauromugue Champaign', playertracker.talk_to_npc['meeble_sauromugue'])
	append_addonhelp('You must talk to Burrow Investigator @ Upper Jeuno (I-8)', playertracker.talk_to_npc['meeble_batallia'])
	append_addonhelp('Menu: Review expedition specifics -> Batallia Downs', playertracker.talk_to_npc['meeble_batallia'])
	append_maintab('Sheol Gaol Vengeance (%d/%d)', playertracker['sheolgaoltiers_completed'], playertracker['sheolgaoltiers_total'])
	append_addonhelp('You must talk to ??? @ Rabao (I-8) (Status Report: Sheol Gaol)', playertracker.talk_to_npc['sheolgaol'])

	imgui.Text( '======= Titles =======')
	append_maintab('Titles %d/%d', playertracker['Titles_completed'], playertracker['Titles_total'])
	append_items(menus_util.list_titles_bycontent())
	
end

local function xichecklist_updatetabs(tab)
	if not player then return false
	
	elseif (tab == 'Quests') then
		-- log quests
		append_header( 'San d\'Oria Quests (%d/%d)', playertracker['sandoria_completed'], playertracker['sandoria_total'])
		append_items(tab_logs.quests['sandoria'])
		append_header( 'Bastok Quests (%d/%d)', playertracker['bastok_completed'], playertracker['bastok_total'])
		append_items( tab_logs.quests['bastok'])
		append_header( 'Windurst Quests (%d/%d)', playertracker['windurst_completed'], playertracker['windurst_total'])
		append_items(tab_logs.quests['windurst'])
		append_header( 'Jeuno Quests (%d/%d)', playertracker['jeuno_completed'], playertracker['jeuno_total'])
		append_items(tab_logs.quests['jeuno'])
		append_header( 'Aht Urhgan Quests (%d/%d)', playertracker['ahturhgan_completed'], playertracker['ahturhgan_total'])
		append_items(tab_logs.quests['ahturhgan'])
		append_header( 'Crystal War Quests (%d/%d)', playertracker['crystalwar_completed'], playertracker['crystalwar_total'])
		append_items(tab_logs.quests['crystalwar'])
		append_header( 'Outlands Quests (%d/%d)', playertracker['outlands_completed'], playertracker['outlands_total'])
		append_items( tab_logs.quests['outlands'])
		append_header( 'Other Quests (%d/%d)', playertracker['other_completed'], playertracker['other_total'])
		append_items( tab_logs.quests['other'])
		append_header( 'Abyssea Quests (%d/%d)', playertracker['abyssea_completed'], playertracker['abyssea_total'])
		append_items( tab_logs.quests['abyssea'])
		append_header( 'Adoulin Quests (%d/%d)', playertracker['adoulin_completed'], playertracker['adoulin_total'])
		append_items( tab_logs.quests['adoulin'])
		append_header( 'Coalition Assignments (%d/%d)', playertracker['coalition_completed'], playertracker['coalition_total'])
		append_items( tab_logs.quests['coalition'])
	elseif (tab == "Campaign") then
	-- log campaign ops
		append_header( 'Campaign Ops (%d/%d)', playertracker['campaign_completed'], playertracker['campaign_total'])
		append_items( tab_logs.quests['campaign'])
	
	-- log Monstrosity levels & Race/Job Instincts
	elseif (tab == 'Monstrosity') then
		append_header( 'Species Levels (%d/%d)', playertracker['MonsterLevels_completed'], playertracker['MonsterLevels_total'])
		append_items( tab_logs.monsterlevels)
		append_header( 'Monster Variants (%d/%d)', playertracker['MonsterVariants_completed'], playertracker['MonsterVariants_total'])
		append_items( tab_logs.monstervariants)
		append_header( 'Race / Job Instincts (%d/%d)', playertracker['Racejobinstinct_completed'], playertracker['Racejobinstinct_total'])
		append_items( tab_logs.racejobinstincts)
		append_header( 'Monster Instincts (%d/%d)', playertracker['MonsterInsincts_completed'], playertracker['MonsterInsincts_total'])
		append_items( tab_logs.monster_instincts)
	
	-- log RoE
	elseif (tab == 'RoE') then
		append_header( 'RoE (%d/%d)', playertracker['RoE_completed'], playertracker['RoE_total'])
		append_items( roe_util.log_roe())
	
	elseif (tab == 'Battle Content') then
		-- log MMM
		append_header( 'MM/M Vouchers Unlocks (%d/%d)', playertracker['mmmvouchers_completed'], playertracker['mmmvouchers_total'])
		append_items( tab_logs.mmmvouchers)
		append_header( 'MMM Runes Unlocks (%d/%d)', playertracker['mmmrunes_completed'], playertracker['mmmrunes_total'])
		append_items( tab_logs.mmmrunes)
		-- log Meeble Burrows
		append_header( 'Meeble Burrows (%d/%d)', playertracker['meebleburrows_completed'], playertracker['meebleburrows_total'])
		append_addonhelp( 'You must talk to Burrow Investigator @ Upper Jeuno (I-8)', playertracker.talk_to_npc['meeble_sauromugue'])
		append_addonhelp( 'Menu: Review expedition specifics -> Sauromugue Champaign', playertracker.talk_to_npc['meeble_sauromugue'])
		append_addonhelp( 'You must talk to Burrow Investigator @ Upper Jeuno (I-8)', playertracker.talk_to_npc['meeble_batallia'])
		append_addonhelp( 'Menu: Review expedition specifics -> Batallia Downs', playertracker.talk_to_npc['meeble_batallia'])
		append_items( tab_logs.meeble_burrows)
		-- Log Sheol Gaol Vengeance Tiers
		append_header( 'Sheol Gaol Vengeance (%d/%d)', playertracker['sheolgaoltiers_completed'], playertracker['sheolgaoltiers_total'])
		append_addonhelp( 'You must talk to ??? @ Rabao (I-8)m (Status Report: Sheol Gaol)', playertracker.talk_to_npc['sheolgaol'])
		append_items( tab_logs.sheolgaol)
	
	elseif (tab == 'Key Items') then
		-- log keyitems
		append_header( 'Permanent Key Items (%d/%d)', playertracker['Permanent_Key_Items_completed'], playertracker['Permanent_Key_Items_total'])
		append_items( tab_logs.keyitems['Permanent Key Items'])
		append_header( 'Magical Maps (%d/%d)', playertracker['Magical_Maps_completed'], playertracker['Magical_Maps_total'])
		append_items( tab_logs.keyitems['Magical Maps'])
		append_header( 'Mounts (%d/%d)', playertracker['Mounts_completed'], playertracker['Mounts_total'])
		append_items( tab_logs.keyitems['Mounts'])
		append_header( 'Claim Slips (%d/%d)', playertracker['Claim_Slips_completed'], playertracker['Claim_Slips_total'])
		append_items( tab_logs.keyitems['Claim Slips'])
		append_header( 'Active Effects (%d/%d)', playertracker['Active_Effects_completed'], playertracker['Active_Effects_total'])
		append_items( tab_logs.keyitems['Active Effects'])
		append_header( 'Voidwatch Key Items (%d/%d)', playertracker['Voidwatch_completed'], playertracker['Voidwatch_total'])
		append_items( tab_logs.keyitems['Voidwatch'])
		append_header( 'Atmacite Levels (%d/%d)', playertracker['atmacitelevels_completed'], playertracker['atmacitelevels_total'])
		append_addonhelp( 'You must talk to any Atmacite Refiner (Menu: Enrich Atmas)', playertracker.talk_to_npc['atmacite_refiner'])
		append_items( tab_logs.atmacite_levels)
	
	elseif (tab == 'Magic') then
		-- log spells and trusts
		append_header( 'White Magic (%d/%d)', playertracker['WhiteMagic_completed'], playertracker['WhiteMagic_total'])
		append_items( tab_logs.magic['WhiteMagic'])
		append_header( 'Black Magic (%d/%d)', playertracker['BlackMagic_completed'], playertracker['BlackMagic_total'])
		append_items( tab_logs.magic['BlackMagic'])
		append_header( 'Summoner Pacts (%d/%d)', playertracker['SummonerPact_completed'], playertracker['SummonerPact_total'])
		append_items( tab_logs.magic['SummonerPact'])
		append_header( 'Ninjutsu (%d/%d)', playertracker['Ninjutsu_completed'], playertracker['Ninjutsu_total'])
		append_items( tab_logs.magic['Ninjutsu'])
		append_header( 'Bard Songs (%d/%d)', playertracker['BardSong_completed'], playertracker['BardSong_total'])
		append_items( tab_logs.magic['BardSong'])
		append_header( 'Blue Magic (%d/%d)', playertracker['BlueMagic_completed'], playertracker['BlueMagic_total'])
		append_items( tab_logs.magic['BlueMagic'])
		append_header( 'Geomancy (%d/%d)', playertracker['Geomancy_completed'], playertracker['Geomancy_total'])
		append_items( tab_logs.magic['Geomancy'])
		append_header( 'Trust Magic (%d/%d)', playertracker['Trust_completed'], playertracker['Trust_total'])
		append_items( tab_logs.magic['Trust'])
	elseif (tab == 'Warps') then
		-- log warps
		append_header( 'Home Points (%d/%d)', playertracker['homepoints_completed'], playertracker['homepoints_total'])
		append_items( tab_logs.homepoints)
		append_header( 'Survival Guides (%d/%d)', playertracker['survivalguides_completed'], playertracker['survivalguides_total'])
		append_items( tab_logs.survivalguides)
		append_header( 'Adoulin Waypoints (%d/%d)', playertracker['waypoints_completed'], playertracker['waypoints_total'])
		append_items( tab_logs.waypoints)
		append_header( 'Outpost Warps (%d/%d)', playertracker['outposts_completed'], playertracker['outposts_total'])
		append_addonhelp( 'You must talk to any Outpost Teleporter NPC @ three nations.', playertracker.talk_to_npc['outpostnpc'])
		append_items( tab_logs.outposts)
		append_header( 'Proto-Waypoints (%d/%d)', playertracker['protowaypoints_completed'], playertracker['protowaypoints_total'])
		append_addonhelp( 'You must talk to any Proto-Waypoint.', playertracker.talk_to_npc['protowaypoint'])
		append_items( tab_logs.protowaypoints)
	elseif (tab == 'Fish') then
		-- log fishes caught
		append_header( 'Type of Fishes Caught (%d/%d)', playertracker['fishes_completed'], playertracker['fishes_total'])
		append_addonhelp( 'You must talk to Katsunaga @ Mhuaura (H-9) (Menu: Types of fishes caught)', playertracker.talk_to_npc['katsunaga'])
		append_items( tab_logs.fishes)
	elseif (tab == 'Titles') then
			-- log Titles
		append_header( 'Titles (%d/%d)', playertracker['Titles_completed'], playertracker['Titles_total'])
		append_addonhelp( 'You must talk to Aligi-Kufongi @ Tavnazian Safehold (H-9)', playertracker.talk_to_npc['Aligi-Kufongi'])
		append_addonhelp( 'You must talk to Koyol-Futenol @ Aht Urhgan Whitegate (E-9)', playertracker.talk_to_npc['Koyol-Futenol'])
		append_addonhelp( 'You must talk to Tamba-Namba @ Southern San d\'Oria (S) (L-8)', playertracker.talk_to_npc['Tamba-Namba'])
		append_addonhelp( 'You must talk to Bhio Fehriata @ Bastok Markets (S) (I-10)', playertracker.talk_to_npc['Bhio_Fehriata'])
		append_addonhelp( 'You must talk to Cattah Pamjah @ Windurst Waters (S) (G-10)', playertracker.talk_to_npc['Cattah_Pamjah'])
		append_addonhelp( 'You must talk to Moozo-Koozo @ Southern San d\'Oria (K-6)', playertracker.talk_to_npc['Moozo-Koozo'])
		append_addonhelp( 'You must talk to Styi Palneh @ Port Bastok (I-7)', playertracker.talk_to_npc['Styi_Palneh'])
		append_addonhelp( 'You must talk to Burute-Sorute @ Windurst Walls (H-10)', playertracker.talk_to_npc['Burute-Sorute'])
		append_addonhelp( 'You must talk to Tuh Almobankha @ Lower Jeuno (I-8)', playertracker.talk_to_npc['Tuh_Almobankha'])
		append_addonhelp( 'You must talk to Zuah Lepahnyu @ Port Jeuno (J-8)', playertracker.talk_to_npc['Zuah_Lepahnyu'])
		append_addonhelp( 'You must talk to Shupah Mujuuk @ Rabao (G-8)', playertracker.talk_to_npc['Shupah_Mujuuk'])
		append_addonhelp( 'You must talk to Yulon-Polon @ Selbina (I-9)', playertracker.talk_to_npc['Yulon-Polon'])
		append_addonhelp( 'You must talk to Willah Maratahya @ Mhaura (I-8)', playertracker.talk_to_npc['Willah_Maratahya'])
		append_addonhelp( 'You must talk to Eron-Tomaron @ Kazham (G-7)', playertracker.talk_to_npc['Eron-Tomaron'])
		append_addonhelp( 'You must talk to Quntsu-Nointsu @ Norg (G-7)', playertracker.talk_to_npc['Quntsu-Nointsu'])
		append_addonhelp( 'You must talk to Debadle-Levadle @ Western Adoulin (H-8)', playertracker.talk_to_npc['Debadle-Levadle'])
		append_items( tab_logs.titles)
	end
end

-- UI HELPERS
function ui.render_items(tab)
	if trackermenusettings.initial then
		-- add active_tab helper text here
		imgui.TextColored({1.0, .5, .5, .5}, 'Change zones to update Quests / Campaigns / Warps / Monstrosity')
		imgui.TextColored({1.0, .5, .5, .5}, 'Check the README or "/xic help" to register NPC-related data')
        trackermenusettings.initial = false
	elseif tab == 'Main' then
		update_maintab()
	else
		xichecklist_updatetabs(tab)
	end
end

function ui.render()
	if (not trackermenusettings.visibility[1]) then
        return;
    end
	imgui.SetNextWindowSize({ 1000, 400, });
    imgui.SetNextWindowSizeConstraints({ 1000, 400, }, { FLT_MAX, FLT_MAX, });
    if (imgui.Begin('XIChecklist', trackermenusettings.visibility, ImGuiWindowFlags_AlwaysAutoResize)) then
		if (imgui.BeginTabBar('##checklist_tabbar', ImGuiTabBarFlags_NoCloseWithMiddleMouseButton)) then
			for i, tab in ipairs(tabs) do
				if (imgui.BeginTabItem(tab, nil)) then
					ui.render_items(tab)
					imgui.EndTabItem();
				end
			end
		end
		imgui.EndTabBar();
	end
	imgui.End();
end

return ui