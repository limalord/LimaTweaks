-- global variables
local addonName, addon = ...
local LimaUIC = {}
LimaUIC["RaidColors"] = RAID_CLASS_COLORS


local function ApplyUITweaks()
    GameMenuFrame:SetScale(0.85)
    MicroMenu.BorderArt:Hide()
    BagsBar.BorderArt:Hide()
    MainStatusTrackingBarContainer:SetScale(0.945)
    SecondaryStatusTrackingBarContainer:SetScale(0.945)
    CharacterFrameModeTabs:SetScale(0.9)
end

local function AddClassColors()
    -- Create background frame for player frame
    local PlayFN = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain:CreateTexture(nil, "BACKGROUND")
    PlayFN:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Type", true)
    PlayFN:SetTexCoord(1, 0, 0, 1)
    PlayFN:ClearAllPoints()
    PlayFN:SetPoint("TOPLEFT", 75, -25)

    local c = LimaUIC["RaidColors"][select(2, UnitClass("player"))]
    if c then PlayFN:SetVertexColor(c.r, c.g, c.b) end

    -- Create color function for target and focus frames
    local function TargetFrameCol()
        if UnitIsPlayer("target") then
            local c = LimaUIC["RaidColors"][select(2, UnitClass("target"))]
            if c then TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(c.r, c.g, c.b) end
        end
        if UnitIsPlayer("focus") then
            local c = LimaUIC["RaidColors"][select(2, UnitClass("focus"))]
            if c then FocusFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(c.r, c.g, c.b) end
        end
    end

    local ColTar = CreateFrame("FRAME")
    ColTar:SetScript("OnEvent", TargetFrameCol) -- Events are registered if target option is enabled

    -- Function to set class colored frames
    local function SetClassColFrames()
        -- Player frame
        PlayFN:Show()
        ColTar:RegisterEvent("GROUP_ROSTER_UPDATE")
        ColTar:RegisterEvent("PLAYER_TARGET_CHANGED")
        ColTar:RegisterEvent("PLAYER_FOCUS_CHANGED")
        ColTar:RegisterEvent("UNIT_FACTION")
        TargetFrameCol()
    end

    SetClassColFrames()
end

---------------------
-- Hide Player Frame Corner
---------------------
local function ApplyFrameCornerHide(frame)
    PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PlayerPortraitCornerIcon:SetParent(frame)
end

---------------------
-- Init addon
---------------------
local function EventHandler(self, event, arg1, arg2, arg3, ...)
    if event == "PLAYER_LOGIN" then
    	-- database setup
    	if not LimaUIDB then LimaUIDB = {} end

    	-- setup helper frames
    	local hiddenFrame = CreateFrame("Frame")
    	hiddenFrame:Hide()

    	-- apply settings
	ApplyUITweaks()
        -- AddClassColors()
        -- ApplyFrameCornerHide(hiddenFrame)
    end
end

local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("PLAYER_LOGIN")
initFrame:SetScript("OnEvent", EventHandler)