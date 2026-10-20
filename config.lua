local addonName, addon = ...

local category, layout = Settings.RegisterVerticalLayoutCategory(addonName)
addon.settingsCategory = category

local function InitializeSettings(database)
    Settings.RegisterAddOnCategory(category)

    do
        local name = "Game Menu scale"
        local variable = "GameMenuScale"
        local defaultValue = 1
        local minValue = 0.65
        local maxValue = 1.15
        local step = 0.05
        local tooltip = "Adjust the Game Menu size to a more comfortable level."

        local function GetValue()
            return database.GameMenuScale or defaultValue
        end

        local function SetValue(value)
            database.GameMenuScale = value
            GameMenuFrame:SetScale(value)
        end

        local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)

        local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, FormatPercentageRounded)
        Settings.CreateSlider(category, setting, options, tooltip)

        SetValue(GetValue())
    end

    do
        local name = "Hide Bag Bar art"
        local variable = "HideBagBarArt"
        local defaultValue = false
        local tooltip = "Hides Bag Bar border art."

        local function GetValue()
            return database.HideBagBarArt or defaultValue
        end

        local function SetValue(value)
            database.HideBagBarArt = value
            if value then
                BagsBar.BorderArt:Hide()
            else
                BagsBar.BorderArt:Show()
            end
        end

        local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(category, setting, tooltip)

        SetValue(GetValue())
    end

    do
        local name = "Hide Micro Menu art"
        local variable = "HideMicroMenuArt"
        local defaultValue = false
        local tooltip = "Hides Micro Menu border and background arts."

        local function GetValue()
            return database.HideMicroMenuArt or defaultValue
        end

        local function SetValue(value)
            database.HideMicroMenuArt = value
            if value then
                MicroMenu.BackgroundArt:Hide()
                MicroMenu.BorderArt:Hide()
            else
                MicroMenu.BackgroundArt:Show()
                MicroMenu.BorderArt:Show()
            end
        end

        local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(category, setting, tooltip)

        SetValue(GetValue())
    end
end

addon.InitializeSettings = InitializeSettings
