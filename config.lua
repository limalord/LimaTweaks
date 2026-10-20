local addonName, addon = ...

local function InitializeSettings()
    -- mainCategory
    local mainCategory, _ = Settings.RegisterVerticalLayoutCategory(addonName)
    addon.settingsCategory = mainCategory
    Settings.RegisterAddOnCategory(mainCategory)

    do
        local name = "Hide Bag Bar art"
        local variable = "HideBagBarArt"
        local defaultValue = false
        local tooltip = "Hides Bag Bar border art."

        local function GetValue()
            return addon.database.HideBagBarArt or defaultValue
        end

        local function SetValue(value)
            if value then
                BagsBar.BorderArt:Hide()
            else
                BagsBar.BorderArt:Show()
            end
            addon.database.HideBagBarArt = value
        end

        local setting = Settings.RegisterProxySetting(mainCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(mainCategory, setting, tooltip)

        SetValue(GetValue())
    end

    do
        local name = "Hide Micro Menu art"
        local variable = "HideMicroMenuArt"
        local defaultValue = false
        local tooltip = "Hides Micro Menu border and background arts."

        local function GetValue()
            return addon.database.HideMicroMenuArt or defaultValue
        end

        local function SetValue(value)
            if value then
                MicroMenu.BackgroundArt:Hide()
                MicroMenu.BorderArt:Hide()
            else
                MicroMenu.BackgroundArt:Show()
                MicroMenu.BorderArt:Show()
            end
            addon.database.HideMicroMenuArt = value
        end

        local setting = Settings.RegisterProxySetting(mainCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(mainCategory, setting, tooltip)

        SetValue(GetValue())
    end

    -- uiScaleCategory
    local uiScaleCategory, _ = Settings.RegisterVerticalLayoutSubcategory(mainCategory, "Interface Scaling")
    Settings.RegisterAddOnCategory(uiScaleCategory)

    do
        local name = "Game Menu scale"
        local variable = "GameMenuScale"
        local defaultValue = 1
        local minValue = 0.65
        local maxValue = 1.15
        local step = 0.05
        local tooltip = "Adjust the Game Menu size to a more comfortable level."

        local function GetValue()
            return addon.database.GameMenuScale or defaultValue
        end

        local function SetValue(value)
            GameMenuFrame:SetScale(value)
            addon.database.GameMenuScale = value
        end

        local setting = Settings.RegisterProxySetting(mainCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)

        local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, FormatPercentageRounded)
        Settings.CreateSlider(uiScaleCategory, setting, options, tooltip)

        SetValue(GetValue())
    end

    do
        local name = "Character Frame tabs scale"
        local variable = "CharacterFrameTabScale"
        local defaultValue = 1
        local minValue = 0.65
        local maxValue = 1.15
        local step = 0.05
        local tooltip = "Adjust the Character Frame tabs size to a more comfortable level."

        local function GetValue()
            return addon.database.CharacterFrameTabScale or defaultValue
        end

        local function SetValue(value)
            CharacterFrameModeTabs:SetScale(value)
            addon.database.CharacterFrameTabScale = value
        end

        local setting = Settings.RegisterProxySetting(mainCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)

        local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, FormatPercentageRounded)
        Settings.CreateSlider(uiScaleCategory, setting, options, tooltip)

        SetValue(GetValue())
    end

    do
        local name = "Status Track Bar scale"
        local variable = "StatusTrackBarScale"
        local defaultValue = 1
        local minValue = 0.65
        local maxValue = 1.15
        local step = 0.05
        local tooltip = "Adjust the Status Track Bar size to a more comfortable level."

        local function GetValue()
            return addon.database.StatusTrackBarScale or defaultValue
        end

        local function SetValue(value)
            addon.database.StatusTrackBarScale = value
            MainStatusTrackingBarContainer:SetScale(value)
        end

        local setting = Settings.RegisterProxySetting(mainCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)

        local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, FormatPercentageRounded)
        Settings.CreateSlider(uiScaleCategory, setting, options, tooltip)

        SetValue(GetValue())
    end

    do
        local name = "Secondary Status Track Bar scale"
        local variable = "SecondaryStatusTrackBarScale"
        local defaultValue = 1
        local minValue = 0.65
        local maxValue = 1.15
        local step = 0.05
        local tooltip = "Adjust the Secondary Status Track Bar size to a more comfortable level."

        local function GetValue()
            return addon.database.SecondaryStatusTrackBarScale or defaultValue
        end

        local function SetValue(value)
            SecondaryStatusTrackingBarContainer:SetScale(value)
            addon.database.SecondaryStatusTrackBarScale = value
        end

        local setting = Settings.RegisterProxySetting(mainCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)

        local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, FormatPercentageRounded)
        Settings.CreateSlider(uiScaleCategory, setting, options, tooltip)

        SetValue(GetValue())
    end


    -- unitFramesCategory
    local unitFramesCategory, layout = Settings.RegisterVerticalLayoutSubcategory(mainCategory, "Unit Frames")
    Settings.RegisterAddOnCategory(unitFramesCategory)
	  layout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Player"));
    do
        local function TogglePlayerReputationClassColor(enable)
            frame = addon.session.PlayerReputationClassColorFrame

            if frame then
                if enable then
                    frame:Show()
                else
                    frame:Hide()
                end

                return
            end

            if enable then
                local PlayerFrame = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain:CreateTexture(
                    nil, "BACKGROUND"
                )
                PlayerFrame:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Type", true)
                PlayerFrame:SetTexCoord(1, 0, 0, 1)
                PlayerFrame:ClearAllPoints()
                PlayerFrame:SetPoint("TOPLEFT", 75, -25)
                PlayerFrame:SetVertexColor(addon.session.PlayerColor.r, addon.session.PlayerColor.g, addon.session.PlayerColor.b)
                addon.session.PlayerReputationClassColorFrame = PlayerFrame
            end
        end

        local name = "Reputation class color"
        local variable = "PlayerReputationClassColor"
        local defaultValue = false
        local tooltip = "Adds class color to the player reputation bar."

        local function GetValue()
            return addon.database.PlayerReputationClassColor or defaultValue
        end

        local function SetValue(value)
            TogglePlayerReputationClassColor(value)
            addon.database.PlayerReputationClassColor = value
        end

        local setting = Settings.RegisterProxySetting(unitFramesCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(unitFramesCategory, setting, tooltip)
        SetValue(GetValue())
    end
        
    -- local function AddClassColors()
    --     local c = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
    --     local PlayBarFN = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarsContainer.HealthBar
    -- 
    --     PlayBarFN:SetStatusBarDesaturated(true)
    --     if c then PlayBarFN:SetStatusBarColor(c.r, c.g, c.b, 1) end
    -- 
    --     if addon.database.ClassColorsOn then
    --         addon.database.ClassColorsTexture:Show()
    --         return
    --     end
    --     -- Create background frame for player frame
    --     local PlayFN = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain:CreateTexture(nil, "BACKGROUND")
    -- 
    --     PlayFN:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Type", true)
    --     PlayFN:SetTexCoord(1, 0, 0, 1)
    --     PlayFN:ClearAllPoints()
    --     PlayFN:SetPoint("TOPLEFT", 75, -25)
    --     addon.database.ClassColorsOn = true
    --     addon.database.ClassColorsTexture = PlayFN
    --     addon.database.ClassColorsBarTexture = PlayBarFN
    -- 
    --     if c then
    --         PlayFN:SetVertexColor(c.r, c.g, c.b)
    --     end
    -- 
    -- 
    --     -- Create color function for target and focus frames
    --     local function TargetFrameCol()
    --         if UnitIsPlayer("target") then
    --             local c = RAID_CLASS_COLORS[select(2, UnitClass("target"))]
    --             if c then TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(c.r, c.g, c.b) end
    --         end
    --         if UnitIsPlayer("focus") then
    --             local c = RAID_CLASS_COLORS[select(2, UnitClass("focus"))]
    --             if c then FocusFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(c.r, c.g, c.b) end
    --         end
    --     end
    -- 
    --     local ColTar = CreateFrame("FRAME")
    --     ColTar:SetScript("OnEvent", TargetFrameCol) -- Events are registered if target option is enabled
    -- 
    --     -- Function to set class colored frames
    --     local function SetClassColFrames()
    --         -- Player frame
    --         PlayFN:Show()
    --         ColTar:RegisterEvent("GROUP_ROSTER_UPDATE")
    --         ColTar:RegisterEvent("PLAYER_TARGET_CHANGED")
    --         ColTar:RegisterEvent("PLAYER_FOCUS_CHANGED")
    --         ColTar:RegisterEvent("UNIT_FACTION")
    --         TargetFrameCol()
    --     end
    -- 
    --     SetClassColFrames()
    -- end
    -- 
    -- local function RemoveClassColors()
    --     if addon.database.ClassColorsOn then
    --         addon.database.ClassColorsTexture:Hide()
    --         addon.database.ClassColorsBarTexture:SetStatusBarDesaturated(false)
    --         addon.database.ClassColorsBarTexture:SetStatusBarColor(0, 1, 0, 1)
    --     end
    -- end
    -- 
    -- local name = "Add class colors"
    -- local variable = "AddClassColors"
    -- local defaultValue = false
    -- local tooltip = "Adds class color to the reputation bar."
    -- 
    -- local function GetValue()
    --     return addon.database.AddClassColors or defaultValue
    -- end
    -- 
    -- local function SetValue(value)
    --     if value then
    --         AddClassColors()
    --     else
    --         RemoveClassColors()
    --     end
    --     addon.database.AddClassColors = value
    -- end
    -- 
    -- local setting = Settings.RegisterProxySetting(unitFramesCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
    -- Settings.CreateCheckbox(unitFramesCategory, setting, tooltip)
    -- 
    -- addon.database.ClassColorsOn = false
    -- SetValue(GetValue())
end

addon.InitializeSettings = InitializeSettings

