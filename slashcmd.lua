local addonName, addon = ...


addon.SlashCmd = {}

function addon.SlashCmd.Open(msg, editBox)
    Settings.OpenToCategory(addon.settingsCategoryID)
end

function addon.SlashCmd.Initialize()
    SLASH_LIMA_UI1 = "/limaui"
    SLASH_LIMA_UI2 = "/lui"
    SlashCmdList["LIMA_UI"] = addon.SlashCmd.Open
end


