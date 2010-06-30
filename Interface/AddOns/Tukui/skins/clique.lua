-- Set Defaults
if TukuiDB["skins"].Clique == nil then
	TukuiDB["skins"].Clique = {}
end

local skins = TukuiDB["skins"]

skins["Clique"].skinned = false
skins["Clique"].name = "Clique"

-- Function to Skin Clique
function skins.Clique:SkinMe()
	-- Hook Clique's Skin Frame function
	Clique.SkinFrame = function(_, frame)
		frame:SetBackdrop({
			bgFile = TukuiDB["media"].blank, 
	 		edgeFile = TukuiDB["media"].blank, 
	 		tile = false, tileSize = 0, edgeSize = TukuiDB.mult, 
	 		insets = { left = -TukuiDB.mult, right = -TukuiDB.mult, top = -TukuiDB.mult, bottom = -TukuiDB.mult}
		});
		frame:SetBackdropColor(unpack(TukuiDB["media"].backdropcolor))
		frame:SetBackdropBorderColor(unpack(TukuiDB["media"].bordercolor))

		frame:EnableMouse()
		frame:SetClampedToScreen(true)

		frame.titleBar = CreateFrame("Button", nil, frame)
		frame.titleBar:SetHeight(32)
		frame.titleBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2)
		frame.titleBar:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -2)
		frame:SetMovable(true)
		frame:SetFrameStrata("MEDIUM")
		frame.titleBar:RegisterForDrag("LeftButton")
		frame.titleBar:SetScript("OnDragStart", ondragstart)
		frame.titleBar:SetScript("OnDragStop", ondragstop)

		frame.header = frame.titleBar:CreateTexture(nil, "ARTWORK");
		frame.header:SetTexture("Interface\\AddOns\\Clique\\images\\header.tga");
		frame.header:SetAllPoints(frame.titleBar)
		
		frame.title = frame.titleBar:CreateFontString(nil, "OVERLAY");
		frame.title:SetFont(TukuiDB["media"].font, TukuiDB:Scale(12))
		frame.title:SetWidth(200); frame.title:SetHeight(16);
		frame.title:SetPoint("TOP", 0, 0);
		
		frame.footerLeft = frame:CreateTexture(nil, "ARTWORK");
		frame.footerLeft:SetTexture("Interface\\AddOns\\Clique\\images\\footCorner.tga");
		frame.footerLeft:SetWidth(48); frame.footerLeft:SetHeight(48);
		frame.footerLeft:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 2, 2);

		frame.footerRight = frame:CreateTexture(nil, "ARTWORK");
		frame.footerRight:SetTexture("Interface\\AddOns\\Clique\\images\\footCorner.tga");
		frame.footerRight:SetTexCoord(1,0,0,1);
		frame.footerRight:SetWidth(48); frame.footerRight:SetHeight(48);
		frame.footerRight:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2);

		frame.footer = frame:CreateTexture(nil, "ARTWORK");
		frame.footer:SetTexture("Interface\\AddOns\\Clique\\images\\footer.tga");
		frame.footer:SetPoint("TOPLEFT", frame.footerLeft, "TOPRIGHT");
		frame.footer:SetPoint("BOTTOMRIGHT", frame.footerRight, "BOTTOMLEFT");
	end
end
