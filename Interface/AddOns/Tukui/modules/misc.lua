-- always show worldstate behind buffs
WorldStateAlwaysUpFrame:SetFrameStrata("BACKGROUND")
WorldStateAlwaysUpFrame:SetFrameLevel(0)

-- remove uiscale option via blizzard option, users need to set this in the config file
VideoOptionsResolutionPanelUIScaleSlider:Hide()
VideoOptionsResolutionPanelUseUIScale:Hide()

-- enable or disable an addon via command
SlashCmdList.DISABLE_ADDON = function(s) DisableAddOn(s) ReloadUI() end
SLASH_DISABLE_ADDON1 = "/disable"
SlashCmdList.ENABLE_ADDON = function(s) EnableAddOn(s) LoadAddOn(s) ReloadUI() end
SLASH_ENABLE_ADDON1 = "/enable"

-- switch to heal layout via a command
local function HEAL()
	DisableAddOn("Tukui_Dps_Layout"); 
	EnableAddOn("Tukui_Heal_Layout"); 
	ReloadUI();
end
SLASH_HEAL1 = "/heal"
SlashCmdList["HEAL"] = HEAL

-- switch to dps layout via a command
local function DPS()
	DisableAddOn("Tukui_Heal_Layout"); 
	EnableAddOn("Tukui_Dps_Layout");
	ReloadUI();
end
SLASH_DPS1 = "/dps"
SlashCmdList["DPS"] = DPS

-- fix combatlog manually when it broke
local function CLFIX()
	CombatLogClearEntries()
end
SLASH_CLFIX1 = "/clfix"
SlashCmdList["CLFIX"] = CLFIX

-- a command to show frame you currently mouseover
local function FRAME()
	ChatFrame1:AddMessage(GetMouseFocus():GetName()) 
end
SLASH_FRAME1 = "/frame"
SlashCmdList["FRAME"] = FRAME

-- enable lua error by command
function SlashCmdList.LUAERROR(msg, editbox)
	if (msg == 'on') then
		SetCVar("scriptErrors", 1)
		-- because sometime we need to /rl to show error.
		ReloadUI()
	elseif (msg == 'off') then
		SetCVar("scriptErrors", 0)
	else
		print("/luaerror on - /luaerror off")
	end
end
SLASH_LUAERROR1 = '/luaerror'

SlashCmdList["GROUPDISBAND"] = function()
		SendChatMessage(tukuilocal.disband, "RAID" or "PARTY")
		if UnitInRaid("player") then
			for i = 1, GetNumRaidMembers() do
				local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
				if online and name ~= TukuiDB.myname then
					UninviteUnit(name)
				end
			end
		else
			for i = MAX_PARTY_MEMBERS, 1, -1 do
				if GetPartyMember(i) then
					UninviteUnit(UnitName("party"..i))
				end
			end
		end
		LeaveParty()
end
SLASH_GROUPDISBAND1 = '/rd'