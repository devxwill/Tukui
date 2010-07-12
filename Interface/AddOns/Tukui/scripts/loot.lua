-- credits : Haste

if not TukuiDB["loot"].lootframe == true then return end

local _NAME, _NS = ...

_NS.L = {
	fish = "Fishy loot",
	empty = "Empty slot",

	uiTitleSize = 'Title font size:',
	uiItemSize = 'Item font size:',
	uiCountSize = 'Count font size:',
	uiIconSize = 'Item icon size:',
	uiFrameScale = 'Frame scale:',
}

local TukuiLoot = CreateFrame("Button", _NAME)
TukuiLoot:Hide()

TukuiLoot:SetScript("OnEvent", function(self, event, ...)
	self[event](self, event, ...)
end)

function TukuiLoot:LOOT_OPENED(event, autoloot)
	self:Show()

	if(not self:IsShown()) then
		CloseLoot(not autoLoot)
	end

	local L = _NS.L
	if(IsFishingLoot()) then
		self.title:SetText(L.fish)
	elseif(not UnitIsFriend("player", "target") and UnitIsDead"target") then
		self.title:SetText(UnitName"target")
	else
		self.title:SetText(LOOT)
	end

	-- Blizzard uses strings here
	if(GetCVar("lootUnderMouse") == "1") then
		local x, y = GetCursorPosition()
		x = x / self:GetEffectiveScale()
		y = y / self:GetEffectiveScale()

		self:ClearAllPoints()
		self:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", x-40, y+20)
		self:GetCenter()
		self:Raise()
	end

	local m = 0
	local items = GetNumLootItems()
	if(items > 0) then
		for i=1, items do
			local slot = _NS.slots[i] or _NS.CreateSlot(i)
			local texture, item, quantity, quality, locked = GetLootSlotInfo(i)
			local color = ITEM_QUALITY_COLORS[quality]

			if(LootSlotIsCoin(i)) then
				item = item:gsub("\n", ", ")
			end

			if(quantity > 1) then
				slot.count:SetText(quantity)
				slot.count:Show()
			else
				slot.count:Hide()
			end

			if(quality > 1) then
				slot.drop:SetVertexColor(color.r, color.g, color.b)
				slot.drop:Show()
			else
				slot.drop:Hide()
			end

			slot.quality = quality
			slot.name:SetText(item)
			slot.name:SetTextColor(color.r, color.g, color.b)
			slot.icon:SetTexture(texture)

			m = math.max(m, quality)

			slot:Enable()
			slot:Show()
		end
	else
		local slot = _NS.slots[1] or _NS.CreateSlot(1)
		local color = ITEM_QUALITY_COLORS[0]

		slot.name:SetText(L.empty)
		slot.name:SetTextColor(color.r, color.g, color.b)
		slot.icon:SetTexture[[Interface\Icons\INV_Misc_Herb_AncientLichen]]

		slot.count:Hide()
		slot.drop:Hide()
		slot:Disable()
		slot:Show()
	end
	self:AnchorSlots()

	local color = ITEM_QUALITY_COLORS[m]
	self:SetBackdropBorderColor(color.r, color.g, color.b, .8)

	self:UpdateWidth()
end
TukuiLoot:RegisterEvent"LOOT_OPENED"

function TukuiLoot:LOOT_SLOT_CLEARED(event, slot)
	if(not self:IsShown()) then return end

	_NS.slots[slot]:Hide()
	self:AnchorSlots()
end
TukuiLoot:RegisterEvent"LOOT_SLOT_CLEARED"

function TukuiLoot:LOOT_CLOSED()
	StaticPopup_Hide"LOOT_BIND"
	self:Hide()

	for _, v in pairs(_NS.slots) do
		v:Hide()
	end
end
TukuiLoot:RegisterEvent"LOOT_CLOSED"

function TukuiLoot:OPEN_MASTER_LOOT_LIST()
	ToggleDropDownMenu(1, nil, GroupLootDropDown, LootFrame.selectedLootButton, 0, 0)
end
TukuiLoot:RegisterEvent"OPEN_MASTER_LOOT_LIST"

function TukuiLoot:UPDATE_MASTER_LOOT_LIST()
	UIDropDownMenu_Refresh(GroupLootDropDown)
end
TukuiLoot:RegisterEvent"UPDATE_MASTER_LOOT_LIST"

do
	local round = function(n)
		return math.floor(n * 1e5 + .5) / 1e5
	end

	function TukuiLoot:SavePosition()
		local point, parent, _, x, y = self:GetPoint()

		_NS.db.framePosition = string.format(
			'%s\031%s\031%d\031%d',
			point, 'UIParent', round(x), round(y)
		)
	end

	function TukuiLoot:LoadPosition()
		local scale = self:GetScale()
		local point, parentName, x, y = string.split('\031', _NS.db.framePosition)

		self:ClearAllPoints()
		self:SetPoint(point, parentName, point, x / scale, y / scale)
	end
end

do
	local title = TukuiLoot:CreateFontString(nil, "OVERLAY")
	title:SetPoint("BOTTOMLEFT", TukuiLoot, "TOPLEFT", TukuiDB.Scale(4), TukuiDB.Scale(4))
	TukuiLoot.title = title
end

TukuiLoot:SetScript("OnMouseDown", function(self)
	if(IsAltKeyDown()) then
		self:StartMoving()
	end
end)

TukuiLoot:SetScript("OnMouseUp", function(self)
	self:StopMovingOrSizing()
	self:SavePosition()
end)

TukuiLoot:SetScript("OnHide", function(self)
	StaticPopup_Hide"CONFIRM_LOOT_DISTRIBUTION"
	CloseLoot()
end)

TukuiLoot:SetMovable(true)
TukuiLoot:RegisterForClicks"anyup"

TukuiLoot:SetParent(UIParent)
TukuiLoot:SetBackdrop{
	bgFile = TukuiDB.media.blank, tile = true, tileSize = 16,
	edgeFile = TukuiDB.media.blank, edgeSize = 1,
	insets = {left = -TukuiDB.mult, right = -TukuiDB.mult, top = -TukuiDB.mult, bottom = -TukuiDB.mult},
}
TukuiLoot:SetBackdropColor(TukuiDB.media.backdropcolor)

TukuiLoot:SetClampedToScreen(true)
TukuiLoot:SetClampRectInsets(0, 0, 14, 0)
TukuiLoot:SetHitRectInsets(0, 0, -14, 0)
TukuiLoot:SetFrameStrata"HIGH"
TukuiLoot:SetToplevel(true)

do
	local slots = {}
	_NS.slots = slots

	local OnEnter = function(self)
		local slot = self:GetID()
		if(LootSlotIsItem(slot)) then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetLootItem(slot)
			CursorUpdate(self)
		end

		self.drop:Show()
		self.drop:SetVertexColor(1, 1, 0)
	end

	local OnLeave = function(self)
		if(self.quality > 1) then
			local color = ITEM_QUALITY_COLORS[self.quality]
			self.drop:SetVertexColor(color.r, color.g, color.b)
		else
			self.drop:Hide()
		end

		GameTooltip:Hide()
		ResetCursor()
	end

	local OnClick = function(self)
		if(IsModifiedClick()) then
			HandleModifiedItemClick(GetLootSlotLink(self:GetID()))
		else
			StaticPopup_Hide"CONFIRM_LOOT_DISTRIBUTION"

			LootFrame.selectedLootButton = self
			LootFrame.selectedSlot = self:GetID()
			LootFrame.selectedQuality = self.quality
			LootFrame.selectedItemName = self.name:GetText()

			LootSlot(self:GetID())
		end
	end

	local OnUpdate = function(self)
		if(GameTooltip:IsOwned(self)) then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetLootItem(self:GetID())
			CursorOnUpdate(self)
		end
	end

	function _NS.CreateSlot(id)
		local db = _NS.db

		local iconSize = db.iconSize-2
		local fontSizeItem = db.fontSizeItem
		local fontSizeCount = db.fontSizeCount
		local fontItem = TukuiDB.media.uffont
		local fontCount = TukuiDB.media.font

		local frame = CreateFrame("Button", 'TukuiLootSlot'..id, TukuiLoot)
		frame:SetHeight(math.max(fontSizeItem, iconSize))
		frame:SetID(id)

		frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")

		frame:SetScript("OnEnter", OnEnter)
		frame:SetScript("OnLeave", OnLeave)
		frame:SetScript("OnClick", OnClick)
		frame:SetScript("OnUpdate", OnUpdate)

		local iconFrame = CreateFrame("Frame", nil, frame)
		iconFrame:SetSize(iconSize, iconSize)
		iconFrame:SetPoint("RIGHT", frame)
		TukuiDB.SetTemplate(iconFrame)
		frame.iconFrame = iconFrame

		local icon = iconFrame:CreateTexture(nil, "ARTWORK")
		icon:SetAlpha(.8)
		icon:SetTexCoord(.07, .93, .07, .93)
		icon:SetPoint("TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
		icon:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
		frame.icon = icon

		local count = iconFrame:CreateFontString(nil, "OVERLAY")
		count:SetJustifyH"RIGHT"
		count:SetPoint("BOTTOMRIGHT", iconFrame, 2, 2)
		count:SetFont(fontCount, fontSizeCount, 'OUTLINE')
		count:SetShadowOffset(.8, -.8)
		count:SetShadowColor(0, 0, 0, 1)
		count:SetText(1)
		frame.count = count

		local name = frame:CreateFontString(nil, "OVERLAY")
		name:SetJustifyH"LEFT"
		name:SetPoint("LEFT", frame)
		name:SetPoint("RIGHT", iconFrame, "LEFT")
		name:SetNonSpaceWrap(true)
		name:SetFont(fontItem, fontSizeItem)
		name:SetShadowOffset(.8, -.8)
		name:SetShadowColor(0, 0, 0, 1)
		frame.name = name

		local drop = frame:CreateTexture(nil, "ARTWORK")
		drop:SetTexture[[Interface\QuestFrame\UI-QuestLogTitleHighlight]]

		drop:SetPoint("LEFT", icon, "RIGHT")
		drop:SetPoint("RIGHT", frame)
		drop:SetAllPoints(frame)
		drop:SetAlpha(.3)
		frame.drop = drop

		slots[id] = frame
		return frame
	end

	function TukuiLoot:UpdateWidth()
		local maxWidth = 0
		for _, slot in next, _NS.slots do
			local width = slot.name:GetStringWidth()
			if(width > maxWidth) then
				maxWidth = width
			end
		end

		self:SetWidth(math.max(maxWidth + 30 + _NS.db.iconSize, self.title:GetStringWidth() + 5))
	end

	function TukuiLoot:AnchorSlots()
		local frameSize = math.max(_NS.db.iconSize, _NS.db.fontSizeItem)
		local iconSize = _NS.db.iconSize
		local shownSlots = 0

		local prevShown
		for i=1, #slots do
			local frame = slots[i]
			if(frame:IsShown()) then
				frame:ClearAllPoints()
				frame:SetPoint("LEFT", 8, 0)
				frame:SetPoint("RIGHT", -8, 0)
				if(not prevShown) then
					frame:SetPoint('TOPLEFT', self, 8, -8)
				else
					frame:SetPoint('TOP', prevShown, 'BOTTOM')
				end

				frame:SetHeight(frameSize)
				shownSlots = shownSlots + 1
				prevShown = frame
			end
		end

		local offset = self:GetTop() or 0
		self:SetHeight(math.max((shownSlots * frameSize + 16), 20))

		-- Reposition the frame so it doesn't move.
		local point, parent, relPoint, x, y = self:GetPoint()
		offset = offset - (self:GetTop() or 0)
		self:SetPoint(point, parent, relPoint, x, y + offset)
	end
end

-- Kill the default loot frame.
LootFrame:UnregisterAllEvents()

-- Escape the dungeon.
table.insert(UISpecialFrames, "TukuiLoot")

local LoadSettings
do
	LoadSettings = function(self)
		-- We only need this once.
		self:SetScript('OnShow', nil)

		local db = {}
		_NS.db = setmetatable(db,
		{
			__index = {
				iconSize = 30;

				-- Attempt to set sane defaults.
				fontSizeTitle = math.floor(select(2, GameTooltipHeaderText:GetFont()) + .5);
				fontSizeItem = math.floor(select(2, GameFontWhite:GetFont()) + .5);
				fontSizeCount = math.floor(select(2, NumberFontNormalSmall:GetFont()) + .5);

				frameScale = 1;
				framePosition = 'TOPLEFT\031UIParent\0310\031-104';
			}
		})

		self.title:SetFont(GameTooltipHeaderText:GetFont(), _NS.db.fontSizeTitle, 'OUTLINE')
		self:SetScale(_NS.db.frameScale)

		self:LoadPosition()
	end

	-- Used to setup our DB and such.
	TukuiLoot:SetScript('OnShow', LoadSettings)
end