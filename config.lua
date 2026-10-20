local addonName, addon = ...

local function InitializeSettings()
    -- Main LimaUI category
    local mainCategory, _ = Settings.RegisterVerticalLayoutCategory(addonName)
    addon.settingsCategory = mainCategory
    addon.settingsCategoryID = mainCategory:GetID()
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
        local name = "Name bar class color"
        local variable = "PlayerReputationClassColor"
        local defaultValue = false
        local tooltip = "Adds class color to the Player name bar."

        local function GetValue()
            return addon.database.PlayerReputationClassColor or defaultValue
        end

        local function SetValue(value)
            addon.database.PlayerReputationClassColor = value
            frame = addon.session.PlayerReputationClassColorFrame

            if frame then
                if value then
                    frame:Show()
                else
                    frame:Hide()
                end

                return
            end

            if value then
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
        local name = "Health bar class color"
        local variable = "PlayerHealthBarClassColor"
        local defaultValue = false
        local tooltip = "Adds class color to the Player health bar."

        local function GetValue()
            return addon.database.PlayerHealthBarClassColor or defaultValue
        end

        local function SetValue(value)
            addon.database.PlayerHealthBarClassColor = value
            local PlayerHealthBarFrame = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarsContainer.HealthBar
            if value then
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
        local name = "Name bar class color"
        local variable = "TargetFocusReputationBarClassColor"
        local defaultValue = false
        local tooltip = "Adds class color to the Target and Focus name bar."

        local function ColorFrameReputationBar()
            if UnitIsPlayer("target") then
                local c = RAID_CLASS_COLORS[select(2, UnitClass("target"))]
                TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(c.r, c.g, c.b)
            end
            if UnitIsPlayer("focus") then
                local c = RAID_CLASS_COLORS[select(2, UnitClass("focus"))]
                FocusFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(c.r, c.g, c.b)
            end
        end

        local function RegisterEvents()
            local EmptyNameBarColorFrame = addon.session.EmptyNameBarColorFrame
            if not EmptyNameBarColorFrame then
                EmptyNameBarColorFrame = CreateFrame("FRAME")
                EmptyNameBarColorFrame:SetScript("OnEvent", ColorFrameReputationBar)
            end
            EmptyNameBarColorFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
            EmptyNameBarColorFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
            EmptyNameBarColorFrame:RegisterEvent("PLAYER_FOCUS_CHANGED")
            EmptyNameBarColorFrame:RegisterEvent("UNIT_FACTION")
            addon.session.EmptyNameBarColorFrame = EmptyNameBarColorFrame
        end

        local function UnregisterEvents()
            local EmptyNameBarColorFrame = addon.session.EmptyNameBarColorFrame
            if not EmptyNameBarColorFrame then return end
            EmptyNameBarColorFrame:UnregisterAllEvents()
        end
    
        local function GetValue()
            return addon.database.TargetFocusReputationBarClassColor or defaultValue
        end

        local function SetValue(value)
            addon.database.TargetFocusReputationBarClassColor = value
            if value then
                RegisterEvents()
                ColorFrameReputationBar()
            else
                UnregisterEvents()
					      TargetFrame.CheckFaction(TargetFrame)
					      TargetFrame.CheckFaction(FocusFrame)
            end
        end

        local setting = Settings.RegisterProxySetting(unitFramesCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(unitFramesCategory, setting, tooltip)
        SetValue(GetValue())
    end

    do
        local name = "Health bar class color"
        local variable = "TargetFocusHealthBarClassColor"
        local defaultValue = false
        local tooltip = "Adds class color to the Target and Focus name bar."

        local function ColorHealthBar()
            local TargetHealthBarFrame = TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBar
            if UnitIsPlayer("target") then
                local c = RAID_CLASS_COLORS[select(2, UnitClass("target"))]
                TargetHealthBarFrame:SetStatusBarDesaturated(true)
                TargetHealthBarFrame:SetStatusBarColor(c.r, c.g, c.b)
            else
                TargetHealthBarFrame:SetStatusBarDesaturated(false)
                TargetHealthBarFrame:SetStatusBarColor(0, 1, 0, 1)
            end

            local FocusHealthBarFrame = FocusFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBar
            if UnitIsPlayer("focus") then
                local c = RAID_CLASS_COLORS[select(2, UnitClass("focus"))]
                FocusHealthBarFrame:SetStatusBarDesaturated(true)
                FocusHealthBarFrame:SetStatusBarColor(c.r, c.g, c.b)
            else
                FocusHealthBarFrame:SetStatusBarDesaturated(false)
                FocusHealthBarFrame:SetStatusBarColor(0, 1, 0, 1)
            end
        end

        local function UncolorHealthBar()
            if not addon.session.EmptyHealthBarColorFrame then return end
            local TargetHealthBarFrame = TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBar
            TargetHealthBarFrame:SetStatusBarDesaturated(false)
            TargetHealthBarFrame:SetStatusBarColor(0, 1, 0, 1)
            local FocusHealthBarFrame = FocusFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBar
            FocusHealthBarFrame:SetStatusBarDesaturated(false)
            FocusHealthBarFrame:SetStatusBarColor(0, 1, 0, 1)
        end

        local function RegisterEvents()
            local EmptyHealthBarColorFrame = addon.session.EmptyHealthBarColorFrame
            if not EmptyHealthBarColorFrame then
                EmptyHealthBarColorFrame = CreateFrame("FRAME")
                EmptyHealthBarColorFrame:SetScript("OnEvent", ColorHealthBar)
            end
            EmptyHealthBarColorFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
            EmptyHealthBarColorFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
            EmptyHealthBarColorFrame:RegisterEvent("PLAYER_FOCUS_CHANGED")
            EmptyHealthBarColorFrame:RegisterEvent("UNIT_FACTION")
            addon.session.EmptyHealthBarColorFrame = EmptyHealthBarColorFrame
        end

        local function UnregisterEvents()
            local EmptyHealthBarColorFrame = addon.session.EmptyHealthBarColorFrame
            if not EmptyHealthBarColorFrame then return end
            EmptyHealthBarColorFrame:UnregisterAllEvents()
        end
    
        local function GetValue()
            return addon.database.TargetFocusHealthBarClassColor or defaultValue
        end

        local function SetValue(value)
            addon.database.TargetFocusHealthBarClassColor = value
            if value then
                RegisterEvents()
                ColorHealthBar()
            else
                UnregisterEvents()
                UncolorHealthBar()
            end
        end

        local setting = Settings.RegisterProxySetting(unitFramesCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(unitFramesCategory, setting, tooltip)
        SetValue(GetValue())
    end
end

addon.InitializeSettings = InitializeSettings
