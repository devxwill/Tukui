if not TukuiCF then return end

if TukuiCF["skins"] == nil then
    TukuiCF["skins"] = {}
end

-- Setup Frame to watch for AddOn's Loading
local skinFrame = CreateFrame("Frame")
local skins = TukuiCF["skins"]

-- If the AddOn has loaded or isLoaded, then skin it
local function skinAddOn(self, event, ...)
	local msg = ...
 	for i, v in pairs(skins) do
		if (msg == v.name or IsAddOnLoaded(v.name)) and v.skinned == false then
			skins[v.name]:SkinMe()
			v.skinned = true
		end
 	end
end

skinFrame:RegisterEvent("ADDON_LOADED")
skinFrame:SetScript("OnEvent", skinAddOn)
