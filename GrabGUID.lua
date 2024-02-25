-- Create a frame
local frame = CreateFrame("Frame", "GrabGUIDFrame", UIParent, "BasicFrameTemplateWithInset")
frame:SetSize(240, 110)
frame:SetPoint("CENTER")
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
frame:SetClampedToScreen(true)
frame:Hide()

-- Function to show or hide the frame
local function ToggleFrame()
    if frame:IsShown() then
        frame:Hide()
    else
        frame:Show()
    end
end

-- Register slash command
SLASH_GRABGUID1 = "/grabguid"
SlashCmdList["GRABGUID"] = ToggleFrame

-- Function to show the frame on login
local function ShowFrame()
    frame:Show()
end

-- Register an event to show the frame when the player logs in
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", ShowFrame)

-- Create a text label
frame.label = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
frame.label:SetPoint("TOP", frame, "TOP", 0, -5) 
frame.label:SetText("Target:")

-- Create an edit box for GUID and Name
frame.infoBox = CreateFrame("EditBox", "GrabGUIDEditBox", frame, "InputBoxTemplate")
frame.infoBox:SetSize(200, 40)
frame.infoBox:SetPoint("TOP", frame.label, "BOTTOM", 0, -20)
frame.infoBox:SetAutoFocus(false)
frame.infoBox:SetMultiLine(true)
frame.infoBox:SetFontObject(GameFontHighlightSmall)
frame.infoBox:SetTextInsets(5, 5, 0, 0)
frame.infoBox:SetCursorPosition(0)
frame.infoBox:SetMaxLetters(100)
frame.infoBox:SetScript("OnEscapePressed", function() frame:Hide() end)

-- Create a button
frame.button = CreateFrame("Button", "GrabGUIDButton", frame, "UIPanelButtonTemplate")
frame.button:SetSize(100, 25)
frame.button:SetPoint("BOTTOM", 0, 20)
frame.button:SetText("Grab GUID")

-- Function to grab target's GUID and name
local function GrabTargetInfo()
    local targetGUID = UnitGUID("target")
    local targetName = UnitName("target")
    if targetGUID and targetName then
        frame.infoBox:SetText(targetGUID .. " - " .. targetName)
        frame:Show()
        print("Target: " .. targetName .. " (GUID: " .. targetGUID .. ")")
    else
        frame.infoBox:SetText("No target selected.")
        frame:Show()
        print("No target selected.")
    end
end

frame.button:SetScript("OnClick", GrabTargetInfo)
