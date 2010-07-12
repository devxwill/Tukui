if not TukuiDB["unitframes"].enable == true then return end

local font2 = TukuiDB["media"].uffont
local font1 = TukuiDB["media"].font

local function Shared(self, unit)
	self.colors = TukuiDB.oUF_colors
	self:RegisterForClicks('AnyUp')
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	
	self.menu = TukuiDB.SpawnMenu
	self:SetAttribute('type2', 'menu')
	self:SetAttribute('initial-height', TukuiDB.Scale(12*TukuiDB.raidscale))
	self:SetAttribute('initial-width', TukuiDB.Scale(100*TukuiDB.raidscale))
	
	self:SetBackdrop({bgFile = TukuiDB["media"].blank, insets = {top = -TukuiDB.mult, left = -TukuiDB.mult, bottom = -TukuiDB.mult, right = -TukuiDB.mult}})
	self:SetBackdropColor(0.1, 0.1, 0.1)
	
	local health = CreateFrame('StatusBar', nil, self)
    health:SetAllPoints(self)
	health:SetStatusBarTexture(TukuiDB["media"].normTex)
	self.Health = health

	health.bg = self.Health:CreateTexture(nil, 'BORDER')
	health.bg:SetAllPoints(self.Health)
	health.bg:SetTexture(TukuiDB["media"].blank)
	health.bg:SetTexture(0.3, 0.3, 0.3)
	health.bg.multiplier = (0.3)
	self.Health.bg = health.bg
	
	health.colorDisconnected = true
	health.colorReaction = true
	health.colorClassPet = false    
	health.colorClass = true
		
	local name = health:CreateFontString(nil, 'OVERLAY')
	name:SetFont(font2, 13*TukuiDB.raidscale, "THINOUTLINE")
	name:SetPoint("LEFT", self, "RIGHT", TukuiDB.Scale(5), TukuiDB.Scale(1))
	self:Tag(name, '[Tukui:namemedium]')
	self.Health.name = name
	
	if TukuiDB["unitframes"].showsymbols == true then
		RaidIcon = health:CreateTexture(nil, 'OVERLAY')
		RaidIcon:SetHeight(TukuiDB.Scale(14*TukuiDB.raidscale))
		RaidIcon:SetWidth(TukuiDB.Scale(14*TukuiDB.raidscale))
		RaidIcon:SetPoint("CENTER", self, "CENTER")
		RaidIcon:SetTexture('Interface\\TargetingFrame\\UI-RaidTargetingIcons')
		self.RaidIcon = RaidIcon
	end
	
	if TukuiDB["unitframes"].aggro == true then
		table.insert(self.__elements, TukuiDB.UpdateThreat)
		self:RegisterEvent('PLAYER_TARGET_CHANGED', TukuiDB.UpdateThreat)
		self:RegisterEvent('UNIT_THREAT_LIST_UPDATE', TukuiDB.UpdateThreat)
		self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', TukuiDB.UpdateThreat)
    end
	
	local ReadyCheck = health:CreateTexture(nil, "OVERLAY")
	ReadyCheck:SetHeight(TukuiDB.Scale(12*TukuiDB.raidscale))
	ReadyCheck:SetWidth(TukuiDB.Scale(12*TukuiDB.raidscale))
	ReadyCheck:SetPoint('CENTER')
	self.ReadyCheck = ReadyCheck
	
	self.DebuffHighlightAlpha = 1
	self.DebuffHighlightBackdrop = true
	self.DebuffHighlightFilter = true

	if TukuiDB["unitframes"].showsmooth == true then
		health.Smooth = true
	end
	
	if TukuiDB["unitframes"].showrange == true then
		local range = {insideAlpha = 1, outsideAlpha = TukuiDB["unitframes"].raidalphaoor}
		self.Range = range
	end
end

oUF:RegisterStyle('TukuiDpsR40', Shared)
oUF:Factory(function(self)
	oUF:SetActiveStyle("TukuiDpsR40")

	local raid = self:SpawnHeader("oUF_TukuiDpsRaid40", nil, "custom [@raid26,exists] show;hide", "showRaid", true, "yOffset", TukuiDB.Scale(-3))
	raid:SetPoint('TOPLEFT', UIParent, 15, -18)
end)