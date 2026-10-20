local addonName, addon = ...

local function InitializeSettings()
    -- Main LimaUI category
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

    -- Interface Scaling category
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


    -- Unit Frames category
    local unitFramesCategory, layout = Settings.RegisterVerticalLayoutSubcategory(mainCategory, "Unit Frames")
    Settings.RegisterAddOnCategory(unitFramesCategory)

	  layout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Player"));
    do
        local name = "Reputation class color"
        local variable = "PlayerReputationClassColor"
        local defaultValue = false
        local tooltip = "Adds class color to the Player reputation bar."

        local function GetValue()
            return addon.database.PlayerReputationClassColor or defaultValue
        end

        local function SetValue(value)
            addon.database.PlayerReputationClassColor = enable
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

        local setting = Settings.RegisterProxySetting(unitFramesCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(unitFramesCategory, setting, tooltip)
        SetValue(GetValue())
    end

    do
        local name = "Health Bar class color"
        local variable = "PlayerHealthBarClassColor"
        local defaultValue = false
        local tooltip = "Adds class color to the Player health bar."

        local function GetValue()
            return addon.database.PlayerHealthBarClassColor or defaultValue
        end

        local function SetValue(value)
            addon.database.PlayerHealthBarClassColor = enable
            local PlayerHealthBarFrame = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarsContainer.HealthBar
            if enable then
                PlayerHealthBarFrame:SetStatusBarDesaturated(true)
                PlayerHealthBarFrame:SetStatusBarColor(addon.session.PlayerColor.r, addon.session.PlayerColor.g, addon.session.PlayerColor.b)
            else
                PlayerHealthBarFrame:SetStatusBarDesaturated(false)
                PlayerHealthBarFrame:SetStatusBarColor(0, 1, 0, 1)
            end
        end

        local setting = Settings.RegisterProxySetting(unitFramesCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(unitFramesCategory, setting, tooltip)
        SetValue(GetValue())
    end

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Target and Focus"))
    do
        local name = "Reputation Bar class color"
        local variable = "TargetFocusReputationBarClassColor"
        local defaultValue = false
        local tooltip = "Adds class color to the Target reputation bar."

        local function ColorFrameReputationBar()
            if UnitIsPlayer("target") then
                local c = RAID_CLASS_COLORS[select(2, UnitClass("target"))]
                if c then TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(c.r, c.g, c.b) end
            end
            if UnitIsPlayer("focus") then
                local c = RAID_CLASS_COLORS[select(2, UnitClass("focus"))]
                if c then FocusFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(c.r, c.g, c.b) end
            end
        end

        local function UncolorFrameReputationBar()
            if UnitIsPlayer("target") then
                local c = RAID_CLASS_COLORS[select(2, UnitClass("target"))]
                if c then TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(0, 1, 0, 1) end
            end
            if UnitIsPlayer("focus") then
                local c = RAID_CLASS_COLORS[select(2, UnitClass("focus"))]
                if c then FocusFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(0, 1, 0, 1) end
            end
        end

        local function CreateFrame()
            local EmptyColorFrame = CreateFrame("FRAME")
            EmptyColorFrame:SetScript("OnEvent", ColorFrameReputationBar)
            addon.session.EmptyColorFrame = EmptyColorFrame
        end

        local function RegisterEvents()
            addon.session.EmptyColorFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
            addon.session.EmptyColorFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
            addon.session.EmptyColorFrame:RegisterEvent("PLAYER_FOCUS_CHANGED")
            addon.session.EmptyColorFrame:RegisterEvent("UNIT_FACTION")
        end
    
        local function GetValue()
            return addon.database.TargetFocusReputationBarClassColor or defaultValue
        end

        local function SetValue(value)
            if addon.session.EmptyColorFrame then
                if not value then
                    addon.session.EmptyColorFrame:UnregisterAllEvents()
                    UncolorFrameReputationBar()
                end
                return
            end
            if value then
                CreateFrame()
                RegisterEvents()
                ColorFrameReputationBar() -- TODO do I really need this on reload?
            end
        end

        local setting = Settings.RegisterProxySetting(unitFramesCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(unitFramesCategory, setting, tooltip)
        SetValue(GetValue())
    end
end

addon.InitializeSettings = InitializeSettings
