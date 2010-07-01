-- Set Defaults
if TukuiDB["skins"].Skada == nil then
	TukuiDB["skins"].Skada = {}
	TukuiDB["skins"].Skada.name = "Skada"
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

	-- Set Defaults
	Skada.windowdefaults.bartexture = "Tukui Texture"
	Skada.windowdefaults.barfont = "Tukui Font"
	Skada.windowdefaults.barspacing = TukuiDB:Scale(1)
	Skada.windowdefaults.barwidth = TukuiInfoRight:GetWidth() - 2
	Skada.windowdefaults.barslocked = true
	Skada.windowdefaults.title = {menubutton = true, font="Tukui Font", fontsize=11,margin=0, texture="Tukui Texture", bordertexture="", borderthickness=0, color = {r=0.1,g=0.1,b=0.1,a=1}}
	Skada.windowdefaults.background = {margin=0, height=160, texture="Tukui Background", bordertexture="Tukui Border", borderthickness=TukuiDB:Scale(1), color = {r=0.1,g=0.1,b=0.1,a=1}}
	Skada.windowdefaults.enablebackground = true

	-- Create the New Windows
	local c = true
	for _, win in ipairs(Skada:GetWindows()) do
		if win.db.name == "Tukui" then
			c = false
			break
		end
	end	
	
	if c then
		Skada:CreateWindow("Tukui", nil)
	end
	
	-- Create the Lines
	-- TOP
	local ltst = CreateFrame("Frame", "LineToSkadaTop", barbg)
	TukuiDB:CreatePanel(ltst, 8, 2, "LEFT", TukuiBG, "TOPRIGHT", 0, -TukuiDB:Scale(10))

	-- BOTTOM
	local ltsb = CreateFrame("Frame", "LineToSkadaBottom", barbg)
	TukuiDB:CreatePanel(ltsb, 8, 2, "LEFT", TukuiBG, "BOTTOMRIGHT", 0, TukuiDB:Scale(10))

	-- Grab the Display mod
	local mod = Skada.displays["bar"]
	
	-- Hook Show
	mod.Show = function(_, win)
		win.bargroup:Show()
		win.bargroup:SortBars()
	
		-- Login Fix
		_G["TukuiInfoRightLineVertical"]:SetHeight(317)
		_G["LineToSkadaBottom"]:Show()
		_G["LineToSkadaTop"]:Show()
	end
	
	-- Hook Hide
	mod.Hide = function(_, win)
		win.bargroup:Hide()
	
		-- Login Fix
		_G["TukuiInfoRightLineVertical"]:SetHeight(130)
		_G["LineToSkadaBottom"]:Hide()
		_G["LineToSkadaTop"]:Hide()
	end
	
	-- Hook ApplySettings
	mod.ApplySettings_ = mod.ApplySettings
	mod.ApplySettings = function(self, win)
		mod:ApplySettings_(win)
		
		win.bargroup.button:SetBackdropBorderColor(unpack(TukuiDB["media"].bordercolor))
		win.bargroup.bgframe:SetBackdropBorderColor(unpack(TukuiDB["media"].bordercolor))
		win.bargroup.bgframe:SetPoint("TOP", win.bargroup.button, "BOTTOM", 0, TukuiDB:Scale(17))
		win.bargroup:SetPoint("TOPRIGHT", TukuiInfoRightLineVertical, "TOPLEFT", -TukuiDB:Scale(13), -TukuiDB:Scale(2))
	end
	
	-- Set CubeRight to Toggle Skada!
	TukuiCubeRight:EnableMouse(true)
	TukuiCubeRight:SetScript("OnMouseDown", function()
		Skada:ToggleWindow()
	end)
end
