local addonName, addon = ...

addon.SlashCmd = {}

function addon.SlashCmd.Open(msg, editBox)
    Settings.OpenToCategory(addon.settingsCategoryID)
end


function addon.SlashCmd.Outfits(msg, editBox)
    local FramesNames = {
        Buttons = { "SaveOutfitButton", "MoneyFrame", "PurchaseOutfitButton", "DividerBar" }
    }

    function ShowFrame()
        local frame = TransmogFrame
        if C_Transmog.IsAtTransmogNPC() then
            TransmogFrameTitleText:SetText("Transmogrify")
            frame:Show()
        else
            TransmogFrameTitleText:SetText("Outfits (Preview)")
		        for _, key in ipairs(FramesNames.Buttons) do
			          frame.OutfitCollection[key]:SetShown(false)
		        end
            frame.WardrobeCollection.TabHeaders.tabs[4]:SetShown(false)
            frame:Show()
        end
    end

    function CleanupFrame()
        local frame = TransmogFrame
        frame:Hide()
		    for _, key in ipairs(FramesNames.Buttons) do
			      frame.OutfitCollection[key]:SetShown(true)
		    end
        frame.WardrobeCollection.TabHeaders.tabs[3]:SetShown(true)
    end

    if not TransmogFrame then
        Transmog_LoadUI()
		    TransmogFrame:HookScript("OnShow", ShowFrame)
        TransmogFrame:HookScript("OnHide", CleanupFrame)
    end

    if TransmogFrame:IsShown() then
        TransmogFrame:Hide()
    else
        TransmogFrame:Show()
    end
end

function addon.SlashCmd.Initialize()
    SLASH_INTERFACE_TWEAKS1 = "/interfacetweaks"
    SLASH_INTERFACE_TWEAKS2 = "/it"
    SLASH_INTERFACE_TWEAKS_OUTFITS1 = "/itoutfits"
    SlashCmdList["INTERFACE_TWEAKS"] = addon.SlashCmd.Open
    SlashCmdList["INTERFACE_TWEAKS_OUTFITS"] = addon.SlashCmd.Outfits
end
