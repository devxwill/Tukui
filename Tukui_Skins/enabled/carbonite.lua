--------------------
----- Much of this code by Darth Andriod - http://www.tukui.org/v2/forums/topic.php?id=75 
--------------------

-- Set Defaults
if TukuiCF["skins"].Carbonite == nil then
    TukuiCF["skins"].Carbonite = {
        ["ButtonColumns"] = 2,
        ["ButtonSpacing"] = 40,
        ["ButtonCorner"] = "TopLeft",
    }
end

local skins = TukuiCF["skins"]

skins["Carbonite"].name = "Carbonite"
skins["Carbonite"].skinned = false

-- Function to Skin Carbonite
function skins.Carbonite:SkinMe()
    local borderspacing = TukuiDB.Scale(2)
    local butsize = TukuiMinimapStatsRight:GetHeight()-borderspacing*2
    
    if Nx.MapMinimapOwned() then
        -- restore carbonite minimap functionality
        Minimap:SetScript("OnMouseWheel", Nx.OMW)
        Minimap:SetScript("OnMouseDown", Nx.Map.MOMD)
        Minimap:SetScript("OnMouseUp", Nx.Map.MOMU)
        Minimap:SetScript("OnEnter", Nx.Map.MOE)
        Minimap:SetScript("OnLeave", Nx.Map.MOL)
        
        -- remove some Tukui additions
        MiniMapMailBorder:Show()
        MiniMapMailIcon:SetTexture("Interface\\Icons\\INV_Letter_15")
        MinimapMailFrameUpdate()
        
        if NxMapDock then
            NxData.NXGOpts.MapMMButColumns = skins["Carbonite"].ButtonColumns
            NxData.NXGOpts.MapMMButSpacing = skins["Carbonite"].ButtonSpacing
            NxData.NXGOpts.MapMMButCorner = skins["Carbonite"].ButtonCorner
            NxData.NXGOpts.MapMMButShowCarb = false
        end
        
        ----------------------------------------------------------------------------------------
        -- Right click menu
        ----------------------------------------------------------------------------------------
        local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
        local menuList = {
            {text = CHARACTER_BUTTON,
            func = function() ToggleCharacter("PaperDollFrame") end},
            {text = SPELLBOOK_ABILITIES_BUTTON,
            func = function() ToggleFrame(SpellBookFrame) end},
            {text = TALENTS_BUTTON,
            func = function() ToggleTalentFrame() end},
            {text = ACHIEVEMENT_BUTTON,
            func = function() ToggleAchievementFrame() end},
            {text = QUESTLOG_BUTTON,
            func = function() ToggleFrame(QuestLogFrame) end},
            {text = SOCIAL_BUTTON,
            func = function() ToggleFriendsFrame(1) end},
            {text = PLAYER_V_PLAYER,
            func = function() ToggleFrame(PVPParentFrame) end},
            {text = LFG_TITLE,
            func = function() ToggleFrame(LFDParentFrame) end},
            {text = L_LFRAID,
            func = function() ToggleFrame(LFRParentFrame) end},
            {text = HELP_BUTTON,
            func = function() ToggleHelpFrame() end},
            {text = L_CALENDAR,
            func = function()
                if(not CalendarFrame) then LoadAddOn("Blizzard_Calendar") end
                Calendar_Toggle()
            end},
        }
        
        TukuiCubeLeft:UnregisterAllEvents()
        TukuiCubeLeft:SetScript("OnMouseDown", function(self, btn)
            local inInstance, instanceType = IsInInstance()
            
            if btn == "RightButton" then
                EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
            elseif btn == "LeftButton" and inInstance and (instanceType == "pvp") then
                if TukuiInfoLeftBattleGround:IsShown() then
                    TukuiInfoLeftBattleGround:Hide()
                    TukuiCubeLeft:SetBackdropBorderColor(0.78,0.03,0.08)
                else
                    TukuiCubeLeft:SetBackdropBorderColor(unpack(TukuiDB["media"].bordercolor))
                    TukuiInfoLeftBattleGround:Show()
                end
            end
        end)
    end
    
    NxData.NXGOpts.QWFixedSize = true
    NxData.NXGOpts.LoginHideVer = true
    NxData.NXGOpts.TitleOff = true
    NxData.NXGOpts.MMInstanceTogFullSize = true
    
    -- QW background panel
    local carboniteQuest = select(5, NxQuestWatch:GetChildren())
    local frame = CreateFrame("Frame", nil, NxQuestWatch)
    frame:SetPoint("TOPLEFT", carboniteQuest, -22, 18)
    frame:SetPoint("BOTTOMRIGHT", carboniteQuest, 2, -2)
    frame:SetFrameStrata("LOW")
    TukuiDB.SetTemplate(frame)
    
    -- Map background panel
    local carboniteMap = select(2, NxMap1:GetChildren())
    carboniteMap:SetHeight(TukuiDB.Scale(144))
    TukuiMinimap:ClearAllPoints()
    TukuiMinimap:SetParent(NxMap1)
    TukuiMinimap:SetPoint("TOPLEFT", carboniteMap, -1, 1)
    TukuiMinimap:SetPoint("BOTTOMRIGHT", carboniteMap, 1, -1)
    
    -- Place it in the correct spot
    TukuiMinimap:RegisterEvent("PLAYER_ENTERING_WORLD")
    TukuiMinimap:SetScript("OnEvent", function(self, event)
		TukuiInfoLeftLineVertical:SetPoint("TOP", UIParent, "CENTER", 0)
		
        NxMap1:ClearAllPoints()
        NxMap1:SetPoint("LEFT", UIParent, TukuiDB.Scale(30), -TukuiDB.Scale(NxMap1:GetHeight()/2-10))
        
        NxQuestWatch:ClearAllPoints()
        NxQuestWatch:SetPoint("BOTTOMLEFT", TukuiInfoLeft, "TOPLEFT", TukuiDB.Scale(15), TukuiDB.Scale(145))
        NxQuestWatch:SetAlpha(.9)
        
        TukuiCubeLeft:EnableMouse(true)
    end)
    
    -- fix stat frames
    TukuiMinimapStatsLeft:SetParent(TukuiMinimap)
    TukuiMinimapStatsLeft:SetFrameStrata("BACKGROUND")
    TukuiMinimapStatsLeft:SetFrameLevel(0)
    TukuiMinimapStatsLeft:ClearAllPoints()
    TukuiMinimapStatsLeft:SetPoint("TOPLEFT", TukuiMinimap, "BOTTOMLEFT", 0, -borderspacing)
    TukuiMinimapStatsLeft:SetPoint("TOPRIGHT", TukuiMinimap, "BOTTOM", -borderspacing/2, -borderspacing)
    TukuiMinimapStatsRight:SetParent(TukuiMinimap)
    TukuiMinimapStatsRight:SetFrameStrata("BACKGROUND")
    TukuiMinimapStatsRight:SetFrameLevel(0)
    TukuiMinimapStatsRight:ClearAllPoints()
    TukuiMinimapStatsRight:SetPoint("TOPRIGHT", TukuiMinimap, "BOTTOMRIGHT", 0, -borderspacing)
    TukuiMinimapStatsRight:SetPoint("TOPLEFT", TukuiMinimap, "BOTTOM", borderspacing/2, -borderspacing)
    
    -- fix carbonite frames
	local height = string.match(GetCVar("gxResolution"), "%d+x(%d+)")/2
    for i, v in pairs(NxData.Characters) do
        v.W.NxMap1.H = TukuiDB.Scale((height - 203.5+17)/2)
        v.W.NxMap1.W = TukuiDB.Scale(TukuiInfoLeft:GetWidth() + 12)
        v.W.NxMap1.MaxH = TukuiDB.Scale(height)
        v.W.NxMap1.MaxW = TukuiDB.Scale(height)
        v.W.NxMap1.MaxX = height
        v.W.NxMap1.Lk = true
        
		v.W.NxQuestWatch.H = TukuiDB.Scale((height - 203.5)/2)
        v.W.NxQuestWatch.W = TukuiDB.Scale(TukuiInfoLeft:GetWidth() - 10)
        v.W.NxQuestWatch.Lk = true
        
        if (v.W.NxMapDock) then
        	v.W.NxMapDock.Lk = true
        	v.W.NxMapDock.X = -73
        	v.W.NxMapDock.Y = 10
        	v.W.NxMapDock.A = "TOPRIGHT"
        end

		-- hate the punks window
		v.W.NxPunkHUD.Hide = true
    end
    
    -- fix stat frames part deux
    Nx.Win.SFS = function(self, lay)
        local svd=self.SaD
        svd[self.LaM.."L"]=lay
        self.Frm:SetFrameStrata(self.StN[lay] or "MEDIUM")
        if (self.Frm == NxMap1) then
            TukuiMinimapStatsLeft:SetFrameStrata("BACKGROUND")
            TukuiMinimapStatsRight:SetFrameStrata("BACKGROUND")
        end
    end

	-- fix Minimap Position
	Nx.Map.MUE = function(self)
		if not self.MMO1 then
			return
		end
		local mm=self.MMF
		local mmf=self.LOp.NXMMFull
		if self.Win1:ISM() and self.GOp["MapMMHideOnMax"] or self.MMFS<.02 then
			mm:SetPoint("TOPLEFT",1,0)
			mm:SetScale(.02)
			mm:SetFrameLevel(1)
			for n,f in ipairs(self.MMM) do
				f:SetScale(.001)
			end
			return
		end
		if self.MMZT==0 then
			self:MUM("MapMMDockSquare")
			local icS1=self.GOp["MapMMDockIScale"]
			self:MSS(self.MMFS,icS1)
			local x=0
			local y=0
			local sz=140*self.MMFS
			if self.GOp["MapMMDockRight"] then
				x=(self.MaW-sz+1)
			end
			if self.GOp["MapMMDockBottom"] then
				y=(self.MaH-sz+1)
			end
			mm:ClearAllPoints()
			mm:SetPoint("TOPLEFT",0, -1)--(x+self.GOp["MapMMDXO"])/icS1,(-y-self.GOp["MapMMDYO"])/icS1)
			mm:Show()
			mm:SetFrameLevel(self.Lev)
			self:MUDF(self.Lev+1)
			self.Lev=self.Lev+2
		end
		if self.MMZC then
			self.MMZC=false
			local zoo=max(self.MMZT-1,0)
			if self.MMZT==0 then
				zoo=self.GOp["MapMMDockZoom"]
			end
			local z=zoo-1
			if z<0 then
				z=1
			end
			mm:SetZoom(z)
			mm:SetZoom(zoo)
			if self.MMZT==0 then
				mm:SetAlpha(1)
			end
		end
		MinimapPing:SetScale(self.Win1.Frm:GetScale()*mm:GetScale())
	end
    
    -- carbonite buttons
    NxMap1TB:SetParent(TukuiMinimap)
    NxMap1TB:ClearAllPoints()
    NxMap1TB:SetPoint("BOTTOMRIGHT", TukuiMinimap, "TOPRIGHT", 0, 2)
    TukuiDB.SetTemplate(NxMap1TB)
    for i,v in ipairs({NxMap1TB:GetChildren()}) do
        v:SetSize(butsize, butsize)
        v.tex:SetTexCoord(.09,.91,.09,.91)
        v:ClearAllPoints()
        v:SetPoint("LEFT", NxMap1TB, "LEFT", (i-1) * (butsize+borderspacing/2) + borderspacing, 0)
    end
    for i,v in pairs(NxMap1TB.NxI.Too) do
        v.But2.Typ.SiD = butsize
        v.But2.Typ.SiU = butsize
    end
    NxMap1TB.NxI.Siz2 = butsize
    NxMap1TB:SetWidth(7 * (butsize+borderspacing/2) + borderspacing)
    NxMap1TB:SetAlpha(1)
    NxMap1TB.SetAlpha = function() end
    
    -- map close/autoscale
    select(1, NxMap1:GetChildren()):Hide()
    select(3, NxMap1:GetChildren()):Hide()
    select(1, NxQuestWatch:GetChildren()):Hide()
    select(2, NxQuestWatch:GetChildren()):Hide()
    
    -- Skin everything else
    Nx.Ski.GetBackdrop = function()
        return {
            bgFile = TukuiCF["media"].blank, 
            edgeFile = TukuiCF["media"].blank, 
            tile = false, tileSize = 0, edgeSize = TukuiDB.mult, 
            insets = { left = -TukuiDB.mult, right = -TukuiDB.mult, top = -TukuiDB.mult, bottom = -TukuiDB.mult}
        }
    end
    
    Nx.Win.ReB = function(self)
        if self.Win2 then
            local bk=Nx.Ski:GetBackdrop()
            for win,v in pairs(self.Win2) do
                if win.Bor1 and win.Frm:GetName() ~= "NxMap1" and win.Frm:GetName() ~= "NxQuestWatch" and win.Frm:GetName() ~= "NxMapDock"  then
                    win.Frm:SetBackdrop(bk)
                    win.BaF=win.BFT+.0001
                else
                    win.Frm:SetBackdrop({})
                end
            end
        end
    end
    
    Nx.Ski.GBGC = function()
        return TukuiCF["media"].backdropcolor
    end
    
    Nx.Ski.GBC = function()
        return TukuiCF["media"].bordercolor
    end
    
    Nx.Ski.GFSBGC = Nx.Ski.GBGC
    Nx.Ski:Upd()
end
