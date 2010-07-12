TukuiDB["general"] = {
	["autoscale"] = true,                  -- mainly enabled for users that don't want to mess with the config file
	["uiscale"] = 0.71,                    -- set your value (between 0.64 and 1) of your uiscale if autoscale is off
	["overridelowtohigh"] = false,         -- EXPERIMENTAL ONLY! override lower version to higher version on a lower reso.
	["multisampleprotect"] = true,         -- i don't recommend this because of shitty border but, voila!
}

TukuiDB["unitframes"] = {
	-- general options
	["enable"] = true,                     -- do i really need to explain this?
	["enemyhcolor"] = false,               -- enemy target color by hostility, very useful for healer.
	["unitcastbar"] = true,                -- enable tukui castbar
	["cblatency"] = false,                 -- enable castbar latency
	["cbicons"] = true,                    -- enable icons on castbar
	["auratimer"] = true,                  -- enable timers on buffs/debuffs
	["auratextscale"] = 11,                -- the font size of buffs/debuffs timers on unitframes
	["playerauras"] = false,               -- enable auras on target unit frame
	["targetauras"] = true,                -- enable auras on target unit frame
	["highThreshold"] = 80,                -- hunter high threshold
	["lowThreshold"] = 20,                 -- global low threshold, for low mana warning.
	["targetpowerpvponly"] = true,         -- enable power text on pvp target only
	-- NOT DONE YET ["totdebuffs"] = false,-- enable tot debuffs (high reso only)
	["focusdebuffs"] = false,              -- enable focus debuffs 
	["showfocustarget"] = false,           -- show focus target
	["showtotalhpmp"] = false,             -- change the display of info text on player and target with XXXX/Total.
	["showsmooth"] = true,                 -- enable smooth bar
	["showthreat"] = true,                 -- enable the threat bar anchored to info left panel.
	["charportrait"] = false,              -- do i really need to explain this?
	-- NOT DONE YET ["t_mt"] = false,      -- enable maintank and mainassist
	-- NOT DONE YET ["t_mt_power"] = false,-- enable power bar on maintank and mainassist because it's not show by default.
	["combatfeedback"] = true,             -- enable combattext on player and target.
	-- NOT DONE YET ["classcolor"] = true, -- if set to false, use foof color theme. 
	-- NOT DONE YET["playeraggro"] = false.-- glow border of player frame change color according to your current aggro.
	["positionbychar"] = false,            -- save X, Y position with /uf (movable frame) per character instead of per account.

	-- raid layout
	["showrange"] = true,                  -- show range opacity on raidframes
	["raidalphaoor"] = 0.3,                -- alpha of unitframes when unit is out of range
	["gridposX"] = 18,                     -- horizontal position starting from left
	["gridposY"] = -250,                   -- vertical position starting from top
	["gridposZ"] = "TOPLEFT",              -- if we want to change the starting position zone
	["gridonly"] = false,                  -- enable grid only mode for all healer mode raid layout.
	["showsymbols"] = true,	               -- show symbol.
	["aggro"] = true,                      -- show aggro on all raids layouts
	["raidunitdebuffwatch"] = true,        -- track important spell to watch in pve for grid mode.
	["gridhealthvertical"] = true,         -- enable vertical grow on health bar for grid mode.
	["showplayerinparty"] = true,          -- show my player frame in party
	["gridscale"] = 1,                     -- set the healing grid scaling
	
	-- boss frames
	["showboss"] = true,                   -- enable boss unit frames for PVELOL encounters.

	-- priest only plugin
	["ws_show_time"] = false,              -- show time on weakened soul bar
	["ws_show_player"] = true,             -- show weakened soul bar on player unit
	["ws_show_target"] = true,             -- show weakened soul bar on target unit
	
	-- death knight only plugin
	["runebar"] = true,                    -- enable tukui runebar plugin
	
	-- shaman only plugin
	["totemtimer"] = true,                 -- enable tukui totem timer plugin
}

TukuiDB["arena"] = {
	["unitframes"] = true,                 -- enable tukz arena unitframes (requirement : tukui unitframes enabled)
	["spelltracker"] = true,               -- enable tukz enemy spell tracker (an afflicted3 or interruptbar alternative)
}

TukuiDB["actionbar"] = {
	["enable"] = true,                     -- enable tukz action bars
	["hotkey"] = false,                    -- enable hotkey display because it was a lot requested
	["rightbarmouseover"] = false,         -- enable right bars on mouse over
	["shapeshiftmouseover"] = false,       -- enable shapeshift or totembar on mouseover
	["hideshapeshift"] = false,            -- hide shapeshift or totembar because it was a lot requested.
	["bottomrows"] = 2,                    -- numbers of row you want to show at the bottom (select between 1 and 2 only)
	["rightbars"] = 3,                     -- numbers of right bar you want
	["showgrid"] = true,                   -- show grid on empty button
}

TukuiDB["nameplate"] = {
	["enable"] = true,                     -- enable nice skinned nameplates that fit into tukui
}

TukuiDB["bags"] = {
	["enable"] = true,                     -- enable an all in one bag mod that fit tukui perfectly
	["soulbag"] = true,                    -- show warlock soulbag slot on bag.
}

TukuiDB["map"] = {
	["enable"] = true,                     -- reskin the map to fit tukui
}

TukuiDB["loot"] = {
	["lootframe"] = true,                  -- reskin the loot frame to fit tukui
	["rolllootframe"] = true,              -- reskin the roll frame to fit tukui
	["autogreed"] = true,                  -- auto-dez or auto-greed item at max level.
}

TukuiDB["cooldown"] = {
	["enable"] = true,                     -- do i really need to explain this?
	["treshold"] = 8,                      -- show decimal under X seconds and text turn red
}

TukuiDB["datatext"] = {
	["fps_ms"] = 4,                        -- show fps and ms on panels
	["mem"] = 5,                           -- show total memory on panels
	["bags"] = 0,                          -- show space used in bags on panels
	["gold"] = 6,                          -- show your current gold on panels
	["wowtime"] = 8,                       -- show time on panels
	["guild"] = 1,                         -- show number on guildmate connected on panels
	["dur"] = 2,                           -- show your equipment durability on panels.
	["friends"] = 3,                       -- show number of friends connected.
	["dps_text"] = 0,                      -- show a dps meter on panels
	["hps_text"] = 0,                      -- show a heal meter on panels
	["power"] = 7,                         -- show your attackpower/spellpower/healpower/rangedattackpower whatever stat is higher gets displayed
	["arp"] = 0,                           -- show your armor penetration rating on panels.
	["haste"] = 0,                         -- show your haste rating on panels.
	["crit"] = 0,                          -- show your crit rating on panels.
	["avd"] = 0,                           -- show your current avoidance against the level of the mob your targeting
	["armor"] = 0,                         -- show your armor value against the level mob you are currently targeting

	["battleground"] = true,               -- enable 3 stats in battleground only that replace stat1,stat2,stat3.
	["time24"] = true,                     -- set time to 24h format.
	["localtime"] = false,                 -- set time to local time instead of server time.
	["fontsize"] = 12,                     -- font size for panels.
	
	["font"] = [=[Interface\Addons\Tukui\media\fonts\arial.ttf]=], 
}

TukuiDB["chat"] = {
	["enable"] = true,                     -- blah
}

TukuiDB["panels"] = { 
	["tinfowidth"] = 370,                  -- the width of left and right stat panels.
}

TukuiDB["tooltip"] = {
	["enable"] = true,                     -- true to enable this mod, false to disable
	["cursor"] = false,                    -- enable units tooltip on cursor
	["hidecombat"] = false,                -- hide bottom-right tooltip when in combat
	["hidebuttons"] = false,               -- always hide action bar buttons tooltip.
	["hideuf"] = false,                    -- hide tooltip on unitframes
}

TukuiDB["combatfont"] = {
	["enable"] = true,                     -- true to enable this mod, false to disable
}

TukuiDB["merchant"] = {
	["enable"] = true,                     -- true to enable this mod, false to disable
	["sellgrays"] = true,                  -- automaticly sell grays?
	["autorepair"] = true,                 -- automaticly repair?
}

TukuiDB["error"] = {
	["enable"] = true,                     -- true to enable this mod, false to disable
	filter = {                             -- what messages to not hide
		["Inventory is full."] = true,     -- inventory is full will not be hidden by default
	},
}

TukuiDB["invite"] = { 
	["autoaccept"] = true,                 -- auto-accept invite from guildmate and friends.
}

TukuiDB["watchframe"] = { 
	["movable"] = true,                    -- disable this if you run "Who Framed Watcher Wabbit" from seerah.
}

TukuiDB["buffreminder"] = {
	["enable"] = false,                    -- this is now the new innerfire warning script for all armor/aspect class.
	["sound"] = true,                      -- enable warning sound notification for reminder.
}

TukuiDB["others"] = {
	["pvpautorelease"] = false,            -- enable auto-release in bg or wintergrasp.
}

----------------------------------------------------------------------------
-- Per Class Config (overwrite general)
-- Class need to be UPPERCASE
----------------------------------------------------------------------------

if TukuiDB.myclass == "PRIEST" then
	-- do some config!
end

----------------------------------------------------------------------------
-- Per Character Name Config (overwrite general and class)
-- Name need to be case sensitive
----------------------------------------------------------------------------

if TukuiDB.myname == "Tukz" or TukuiDB.myname == "Kutza" then
	TukuiDB.buffreminder.enable = true
	TukuiDB.actionbar.rightbars = 0
	TukuiDB.actionbar.bottomrows = 1
	TukuiDB.actionbar.hotkey = false
	TukuiDB.actionbar.hideshapeshift = true
	TukuiDB.others.pvpautorelease = true
	TukuiDB.unitframes.enemyhcolor = true
end