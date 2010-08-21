--[[
	Tukui Skin for Quartz rewritten by Mankar - Runetotem (US)
	Original by Darth Android
	Special thanks to Nevcairiel and Nymbia for their work on Quartz, and Tukz for such a great UI!
]]

-- Set Defaults
if TukuiDB["skins"].Quartz == nil then
	TukuiDB["skins"].Quartz = {
		["name"] = "Quartz",
		["skinned"] = false,
		["integrate"] = true,
		["focus"] = "TukuiInfoRight", -- delete this option, or set to nil for original tukui placement
	}
end

--[[ Setup Frame to watch for AddOn's Loading
if skinFrame == nil then
	skinFrame = CreateFrame("Frame")
	
	
	
end]]

--[[ If the AddOn has loaded or isLoaded, then skin it
local function skinAddOn(self, event, ...)
	if event == "ADDON_LOADED" then
		local msg = ...
 		for i, v in pairs(TukuiDB["skins"]) do
			if (msg == v.name or IsAddOnLoaded(v.name)) and v.skinned == false then
				TukuiDB["skins"][v.name]:SkinMe()
				v.skinned = true
			end
 		end
 	end
end

skinFrame:RegisterEvent("ADDON_LOADED")
skinFrame:SetScript("OnEvent", skinAddOn)]]

local skins = TukuiDB["skins"]

-- Function to Skin Quartz
function skins.Quartz:SkinMe()
	-- Grab Quartz
	local Quartz = LibStub("AceAddon-3.0"):GetAddon("Quartz3")
	
	-- Register Media
	local media = LibStub("LibSharedMedia-3.0")
	media:Register("statusbar", "Tukui Texture", TukuiDB["media"].normTex)
	media:Register("border", "Tukui Border", TukuiDB["media"].blank)
	media:Register("background", "Tukui Background", TukuiDB["media"].blank)
	media:Register("font", "Tukui Font", TukuiDB["media"].font)
	media:Register("font", "Tukui UF Font", TukuiDB["media"].uffont)
	media:Register("font", "Tukui Combat Font", TukuiDB["media"].dmgfont)
	
	-- Configure Template
	local template = Quartz.CastBarTemplate.template
	template.ApplySettings_ = template.ApplySettings
	template.ApplySettings = function(self)
		local db = self.config
		
		-- Set Defaults
		if self.unit == "focus" then
			db.h = TukuiInfoRight:GetHeight() - TukuiDB:Scale(2) * 2
			db.w = TukuiInfoRight:GetWidth() - TukuiDB:Scale(2) * 2
		else
			db.h = oUF_Tukz_player.panel:GetHeight() - TukuiDB:Scale(2) * 2
			db.w = oUF_Tukz_player.panel:GetWidth() - TukuiDB:Scale(2) * 2
		end
		
		db.hideicon = not TukuiDB["unitframes"].cbicons
		db.texture = "Tukui Texture"
		db.font = "Tukui UF Font"
		db.icongap = 5
		
		-- Create the Bars
		self:ApplySettings_()
		
		-- Position the Bars
		self:ClearAllPoints()
		if self.unit == "focus" then
			self:SetAllPoints(oUF_Tukz_focus)
		elseif self.unit == "player" then
			self:SetAllPoints(oUF_Tukz_player.panel)
		else
			self:SetAllPoints(oUF_Tukz_target.panel)
		end
		self.Bar:SetFrameStrata("HIGH")
    	self:SetFrameStrata("HIGH")
    	
    	-- Position the Icon
		if not self.IconBorder then
			self.IconBorder = CreateFrame("Frame", nil, self)
			self.IconBorder:SetHeight(TukuiDB:Scale(26))
			self.IconBorder:SetWidth(TukuiDB:Scale(26))
			TukuiDB:SetTemplate(self.IconBorder)
		end
		
    	self.Icon:ClearAllPoints()
    	self.Icon:SetPoint("TOPLEFT", self.IconBorder, TukuiDB:Scale(2), TukuiDB:Scale(-2))
		self.Icon:SetPoint("BOTTOMRIGHT", self.IconBorder, TukuiDB:Scale(-2), TukuiDB:Scale(2))
		self.Icon:SetTexCoord(0.08, 0.92, 0.08, .92)
		
    	if self.unit == "target" then
    		if TukuiDB["unitframes"].charportrait == true then
				self.IconBorder:SetPoint("RIGHT", 80.5, 26.5)
			else
				self.IconBorder:SetPoint("RIGHT", 44.5, 26.5)
			end
		else
			if TukuiDB["unitframes"].charportrait == true then
				self.IconBorder:SetPoint("LEFT", -80.5, 26.5)
			else
				self.IconBorder:SetPoint("LEFT", -44.5, 26.5)
			end
		end
		
		self.IconBackdrop = CreateFrame("Frame", nil, self)
		self.IconBackdrop:SetPoint("TOPLEFT", self.IconBorder, "TOPLEFT", -4, 4)
		self.IconBackdrop:SetPoint("BOTTOMRIGHT", self.IconBorder, "BOTTOMRIGHT", 4, -4)
		self.IconBackdrop:SetBackdrop({
			edgeFile = TukuiDB["media"].glowTex, edgeSize = 4,
			insets = {left = 3, right = 3, top = 3, bottom = 3}
		})
		self.IconBackdrop:SetBackdropColor(0, 0, 0, 0)
		self.IconBackdrop:SetBackdropBorderColor(0, 0, 0, 0.7)
	end
	
	-- Configure the GCD
	local GCD = Quartz:GetModule("GCD")
	GCD.ApplySettings_ = GCD.ApplySettings
	GCD.ApplySettings = function(self)
		db = self.db.profile
		
		-- Set Defaults
		db.gcdposition = "top"
		
		self:ApplySettings_()
	end
end
