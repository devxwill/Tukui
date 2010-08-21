--[[
	Skada Skin by Darth Android
	Edited by Mankar (Runetotem)
	
	- Added Integration options

	TukuiDB["skins"] {
		Skada {
			["name"] = "Skada",
			["position"] = "BOTTOMRIGHT",
		},
	}

	- Possible positions are BOTTOMRIGHT, and RIGHT
]]

-- Set Defaults
if TukuiDB["skins"].Skada == nil then
	TukuiDB["skins"].Skada = {}
	TukuiDB["skins"].Skada.name = "Skada"
	TukuiDB["skins"].Skada.position = "BOTTOMRIGHT"
end

local skins = TukuiDB["skins"]
skins["Skada"].skinned = false

-- Function to Skin Skada
function skins.Skada:SkinMe()
	
	-- Delete the original Skada Window if its still there
	Skada:DeleteWindow("Skada")

	-- Register Media
	local media = LibStub("LibSharedMedia-3.0")
	media:Register("statusbar", "Tukui Texture", TukuiDB["media"].normTex)
	media:Register("border", "Tukui Border", TukuiDB["media"].blank)
	media:Register("background", "Tukui Background", TukuiDB["media"].blank)
	media:Register("font", "Tukui Font", TukuiDB["media"].font)
	media:Register("font", "Tukui UF Font", TukuiDB["media"].uffont)
	media:Register("font", "Tukui Combat Font", TukuiDB["media"].dmgfont)

	-- Create the New Windows
	local c = false
	for _, win in ipairs(Skada:GetWindows()) do
		if win.db.name == "Tukui" then
			c = true
			break
		end
	end	
	
	if not c then
		-- Set Defaults
		Skada.windowdefaults.bartexture = "Tukui Texture"
		Skada.windowdefaults.barfont = "Tukui Font"
		Skada.windowdefaults.barspacing = TukuiDB:Scale(1)
		Skada.windowdefaults.barwidth = TukuiInfoRight:GetWidth() - 2
		Skada.windowdefaults.barslocked = true
		Skada.windowdefaults.barmax = 9
		Skada.windowdefaults.title = {menubutton = true, font="Tukui Font", fontsize=11,margin=0, texture="Tukui Texture", bordertexture="Tukui Border", borderthickness=0, color = {r=0.1,g=0.1,b=0.1,a=1}}
	
		Skada:CreateWindow("Tukui", nil)
	end

	-- Grab the Display mod
	local mod = Skada.displays["bar"]
	
	-- Hook Show
	mod.Show = function(_, win)
		win.bargroup:Show()
		win.bargroup:SortBars()
	
		-- Login Fix
		if skins["Skada"].position == "RIGHT" then
			TukuiInfoRightLineVertical:SetHeight(317)
		elseif skins["Skada"].position == "BOTTOMRIGHT" then
			TukuiInfoRightLineVertical:SetHeight(178)
		else
			if TukuiDB["chat"].enable == true then
				TukuiInfoRightLineVertical:SetHeight(153)
			else
			 	TukuiInfoRightLineVertical:SetHeight(130)
			end
		end
		
		TukuiSkadaPanel:Show()
		
		--oUF_Tukz_player:SetPoint("BOTTOMLEFT", TukuiActionBarBackground, "TOPLEFT", 0,8)
	end
	
	-- Hook Hide
	mod.Hide = function(_, win)
		win.bargroup:Hide()
	
		-- Login Fix
		if TukuiDB["chat"].enable == true then
			TukuiInfoRightLineVertical:SetHeight(153)
		else
		 	TukuiInfoRightLineVertical:SetHeight(130)
		end
		
		TukuiSkadaPanel:Hide()
		
		--oUF_Tukz_player:SetPoint("BOTTOMLEFT", TukuiActionBarBackground, "TOPLEFT", -50,8)
	end
	
	-- Hook ApplySettings
	mod.ApplySettings_ = mod.ApplySettings
	mod.ApplySettings = function(self, win)
		mod:ApplySettings_(win)
		
		local scale = 4
		if skins["Skada"].position == "RIGHT" then
			scale = 143
		end
		
		local frame = CreateFrame("Frame", "TukuiSkadaPanel", TukuiInfoRight)
		TukuiDB:CreatePanel(frame, TukuiInfoRight:GetWidth(), 161, "BOTTOMLEFT", TukuiInfoRight, "TOPLEFT", 0, TukuiDB:Scale(scale))
		frame:SetFrameStrata("MEDIUM")
		
		win.bargroup.button:SetPoint("TOPLEFT", frame, "TOPLEFT", 1, -1)
		win.bargroup.button:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -1)
	end
	
	-- Set CubeRight to Toggle Skada!
	TukuiCubeRight:EnableMouse(true)
	TukuiCubeRight:SetScript("OnMouseDown", function()
		Skada:ToggleWindow()
	end)
end

--[[ Function to update tooltip position
function skins.Skada:gtUpdate(self, ...)
	local frame = nil
	
	if IsAddOnLoaded("ArkInventory") then
		for _, value in pairs(skins["ArkInventory"].Right) do
			local mf = ArkInventory.Frame_Main_Get( value )
			if mf:IsShown( ) then
				frame = mf
				break
			end
		end
	end
	
	if TukuiSkadaPanel:IsShown() and frame == nil then
		frame = TukuiSkadaPanel
	else
		frame = TukuiInfoRight
	end
	
	if self:GetAnchorType( ) == "ANCHOR_NONE" then
		if self:GetAlpha( ) == 1 then
			self:ClearAllPoints( )
			self:SetPoint( "BOTTOMRIGHT", frame, "TOPRIGHT", 0, TukuiDB:Scale(4))
		end
	end
end
GameTooltip:HookScript("OnUpdate", skins.Skada.gtUpdate)]]
