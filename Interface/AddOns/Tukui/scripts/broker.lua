-- Special thanks to funkydude for his awesome work, which helped me build this little plugin - Inspired by Ztango

if not TukuiDB["broker"].enable == true then return end

TukuiDataBroker = CreateFrame("Frame")
local DataBroker = LibStub("LibDataBroker-1.1")

local DataObjects = {}

TukuiDataBroker:RegisterEvent("PLAYER_LOGIN")
TukuiDataBroker:SetScript("OnEvent", function(_, event, ...)
	TukuiDataBroker[event](self, ...)
end)

function TukuiDataBroker:TextUpdate(_, name, _, data)
	DataObjects[name].text:SetText(data)
end

function TukuiDataBroker:ValueUpdate(_, name, _, data, obj)
	DataObjects[name].text:SetFormattedText("%s %s", data, obj.suffix)
end

function TukuiDataBroker:Icon(_, name, _, icon)
	DataObjects[name].icon:SetTexture(icon)
end

function TukuiDataBroker:IconColor(_, name, _, _, obj)
	DataObjects[name].icon:SetVertexColor(obj.iconR, obj.iconG, obj.iconB)
end

function TukuiDataBroker:IconCoords(_, name, _, coords)
	DataObjects[name].icon:SetTexCoord(unpack(coords))
end

function TukuiDataBroker:PLAYER_LOGIN()
	TukuiDataBroker:SetScript("OnEvent", nil)
    TukuiDataBroker:UnregisterEvent("PLAYER_LOGIN")
    DataBroker.RegisterCallback(TukuiDataBroker, "LibDataBroker_DataObjectCreated", "New")
    
    for name, obj in DataBroker:DataObjectIterator() do
        	TukuiDataBroker:New(nil, name, obj)
    end
    
    TukuiDataBroker.PLAYER_LOGIN = nil
end

local function OnTooltipEnter(frame)
	if InCombatLockdown() then return end
        
    local obj = frame.pluginObject
    if not frame.isMoving and obj.OnTooltipShow then
    	GameTooltip:SetOwner(frame, "ANCHOR_TOP", 0, TukuiDB:Scale(6));
		GameTooltip:ClearAllPoints()
		GameTooltip:SetPoint("BOTTOM", frame, "TOP", 0, TukuiDB.mult)
    	GameTooltip:ClearLines()
        
        obj.OnTooltipShow(GameTooltip, frame)
        GameTooltip:Show()
    elseif obj.OnEnter then
      obj.OnEnter(frame)
    end
end

local function OnTooltipLeave(frame)
    GameTooltip:Hide()
    if frame.pluginObject.OnLeave then 
    	frame.pluginObject.OnLeave(frame)
    end
end

local function OnClick(frame, btn)
	if frame.pluginObject.OnClick then
        frame.pluginObject.OnClick(frame, btn)
    end
end

function TukuiDataBroker:New(_, name, obj)
	if not DataObjects[name] == nil then return end
	if TukuiDB["broker"][name] == nil then return end
	
	DataObjects[name] = {}
	local bitem = TukuiDB["broker"][name]
	
	local DBFrame = CreateFrame("Frame")
	DBFrame:EnableMouse(true)
	DBFrame.pluginName = name
	DBFrame.pluginObject = obj
	DataObjects[name].frame = DBFrame
	
	if obj.text and bitem.display == "text" then
		local DBText = TukuiBrokerLeft:CreateFontString(nil, "LOW")
		DBText:SetFont(TukuiDB["datatext"].font, TukuiDB["datatext"].fontsize)
		DataObjects[name].text = DBText
		DBFrame:SetAllPoints(DBText)
		TukuiDB.PP(bitem.position, DBText)
	end
	
	if obj.icon and bitem.display == "icon" then
		local DBIcon = TukuiBrokerLeft:CreateTexture(name .. "_Texture")
		DBIcon:SetTexture(obj.icon)
		DBIcon:SetWidth(TukuiBrokerLeft:GetHeight())
		DBFrame:SetAllPoints(DBIcon)
		TukuiDB.PP(bitem.position, DBIcon)
		
		if obj.iconCoords then
        	DBIcon:SetTexCoord(unpack(obj.iconCoords))
        	DataBroker.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_iconCoords", "IconCoords")
        end
        
        if obj.iconR then
        	DBIcon:SetVertexColor(obj.iconR or 1, obj.iconG or 1, obj.iconB or 1)
        	DataBroker.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_iconR", "IconColor")
            DataBroker.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_iconG", "IconColor")
            DataBroker.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_iconB", "IconColor")
        end
        
        DataBroker.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_icon", "Icon")
        DataObjects[name].icon = DBIcon
	end
	
	if obj.suffix and bitem.display == "text" then
    	self:ValueUpdate(nil, name, nil, obj.value or name, obj)
        DataBroker.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_value", "ValueUpdate")
    elseif bitem.display == "text" then
    	self:TextUpdate(nil, name, nil, obj.text or name)
    	DataBroker.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_text", "TextUpdate")
	end
	
	DataObjects[name].frame:SetScript("OnEnter", OnTooltipEnter)
	DataObjects[name].frame:SetScript("OnLeave", OnTooltipLeave)
	DataObjects[name].frame:SetScript("OnMouseUp", OnClick)
	
	if obj.OnCreate then obj.OnCreate(obj, DataObject) end
end
