--------------------------------------------------------------------------
-- Auto-Release when dead in Wintergrasp or Battleground.
--------------------------------------------------------------------------

if TukuiDB["others"].pvpautorelease ~= true then return end

local WINTERGRASP
WINTERGRASP = tukuilocal.mount_wintergrasp

local autoreleasepvp = CreateFrame("frame")
autoreleasepvp:RegisterEvent("PLAYER_DEAD")
autoreleasepvp:SetScript("OnEvent", function(self, event)
	if TukuiDB.myclass ~= "SHAMAN" or TukuiDB.myclass ~= "WARLOCK" then
		if (tostring(GetZoneText()) == WINTERGRASP) then
			RepopMe()
		end

		if MiniMapBattlefieldFrame.status == "active" then
			RepopMe()
		end
	end
end)