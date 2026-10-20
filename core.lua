local addonName, addon = ...

---------------------
-- Hide Player Frame Corner
---------------------
local function ApplyFrameCornerHide(frame)
    PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PlayerPortraitCornerIcon:SetParent(frame)
end

local function EventHandler(self, event, arg1, arg2, arg3, ...)
    if event == "PLAYER_LOGIN" then
        if not LimaUIDB then LimaUIDB = {} end
        addon.database = LimaUIDB
        addon.session = {}
        addon.session.PlayerColor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
        addon.InitializeSettings()
        addon.SlashCmd.Initialize()
    end
end

local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("PLAYER_LOGIN")
initFrame:SetScript("OnEvent", EventHandler)
