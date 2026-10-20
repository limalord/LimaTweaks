local addonName, addon = ...


local function EventHandler(self, event, arg1, arg2, arg3, ...)
    if event == "PLAYER_LOGIN" then
        if not LimaUIDB then LimaUIDB = {} end
        addon.database = LimaUIDB
        addon.session = {}
        addon.session.PlayerColor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
        addon.InitializeSettings()
        addon.SlashCmd.Initialize()
    elseif event == "ADDON_LOADED" then
        if arg1 == "Blizzard_GroupFinder_VanillaStyle" then
            addon.LFGSettings()
            addon.SetBagsVisibility(addon.database.HideBagBar)
        end
    end
end

local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("PLAYER_LOGIN")
initFrame:RegisterEvent("ADDON_LOADED")
initFrame:SetScript("OnEvent", EventHandler)
