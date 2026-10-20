local addonName, addon = ...

local function InitializeSettings()
    -- Main LimaUI category
    local mainCategory, _ = Settings.RegisterVerticalLayoutCategory(addonName)
    addon.settingsCategory = mainCategory
    addon.settingsCategoryID = mainCategory:GetID()
    Settings.RegisterAddOnCategory(mainCategory)

    -- Minimalism
    local minimalismCategory, _ = Settings.RegisterVerticalLayoutSubcategory(mainCategory, "Minimalism")
    Settings.RegisterAddOnCategory(minimalismCategory)
    do
        local name = "Hide Keybindings"
        local variable = "HideKeybindingsText"
        local defaultValue = false
        local tooltip = "Hides Action Bar Keybindings text."

        local function GetValue()
            return addon.database.HideKeybindingsText or defaultValue
        end

        local function SetValue(value)
            local alpha = value and 0 or 1
			      for i = 1, 12 do
				        _G["ActionButton"..i.."HotKey"]:SetAlpha(alpha)
				        _G["MultiBarBottomRightButton"..i.."HotKey"]:SetAlpha(alpha)
				        _G["MultiBarBottomLeftButton"..i.."HotKey"]:SetAlpha(alpha)
				        _G["MultiBarRightButton"..i.."HotKey"]:SetAlpha(alpha)
				        _G["MultiBarLeftButton"..i.."HotKey"]:SetAlpha(alpha)
				        _G["MultiBar5Button" .. i .. "HotKey"]:SetAlpha(alpha)
				        _G["MultiBar6Button" .. i .. "HotKey"]:SetAlpha(alpha)
				        _G["MultiBar7Button" .. i .. "HotKey"]:SetAlpha(alpha)
			      end
            addon.database.HideKeybindingsText = value
        end

        local setting = Settings.RegisterProxySetting(minimalismCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(minimalismCategory, setting, tooltip)

        SetValue(GetValue())
    end

    do
        local name = "Hide Macro Names"
        local variable = "HideMacroText"
        local defaultValue = false
        local tooltip = "Hides Action Bar Macro names."

        local function GetValue()
            return addon.database.HideMacroText or defaultValue
        end

        local function SetValue(value)
            local alpha = value and 0 or 1
			      for i = 1, 12 do
				        _G["ActionButton"..i.."Name"]:SetAlpha(alpha)
				        _G["MultiBarBottomRightButton"..i.."Name"]:SetAlpha(alpha)
				        _G["MultiBarBottomLeftButton"..i.."Name"]:SetAlpha(alpha)
				        _G["MultiBarRightButton"..i.."Name"]:SetAlpha(alpha)
				        _G["MultiBarLeftButton"..i.."Name"]:SetAlpha(alpha)
				        _G["MultiBar5Button" .. i .. "Name"]:SetAlpha(alpha)
				        _G["MultiBar6Button" .. i .. "Name"]:SetAlpha(alpha)
				        _G["MultiBar7Button" .. i .. "Name"]:SetAlpha(alpha)
			      end
            addon.database.HideMacroText = value
        end

        local setting = Settings.RegisterProxySetting(minimalismCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(minimalismCategory, setting, tooltip)

        SetValue(GetValue())
    end

    do
        local name = "Hide Stance Bar"
        local variable = "HideStanceBar"
        local defaultValue = false
        local tooltip = "Hides the class Stance Bar."

        local function GetValue()
            return addon.database.HideStanceBar or defaultValue
        end

			  local EmptyStanceBar = CreateFrame("FRAME", nil, UIParent)
        EmptyStanceBar:Hide()
        local function SetValue(value)
            if value then
			          StanceBar:SetParent(EmptyStanceBar)
            else
			          StanceBar:SetParent(UIParent)
            end
            addon.database.HideStanceBar = value
        end

        local setting = Settings.RegisterProxySetting(minimalismCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(minimalismCategory, setting, tooltip)

        SetValue(GetValue())
    end

    do
        local name = "Hide Portrait Hit Indicators"
        local variable = "HidePortraitHitIndicator"
        local defaultValue = false
        local tooltip = "Hides Portrait hit indicators spam."

        local function GetValue()
            return addon.database.HidePortraitHitIndicator or defaultValue
        end

        local function SetValue(value)
            if value then
			          PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HitIndicator:Hide()
            else
			          PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HitIndicator:Show()
            end
            addon.database.HidePortraitHitIndicator = value
        end

        local setting = Settings.RegisterProxySetting(minimalismCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(minimalismCategory, setting, tooltip)

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

        local setting = Settings.RegisterProxySetting(minimalismCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(minimalismCategory, setting, tooltip)

        SetValue(GetValue())
    end

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

        local setting = Settings.RegisterProxySetting(minimalismCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(minimalismCategory, setting, tooltip)

        SetValue(GetValue())
    end

    do
        local name = "Hide Bag Bar"
        local variable = "HideBagBar"
        local defaultValue = false
        local tooltip = "Hides Bag Bar."

        local function GetValue()
            return addon.database.HideBagBar or defaultValue
        end

        local function SetValue(value)
            if value then BagsBar:Hide() else BagsBar:Show() end
            addon.database.HideBagBar = value
        end
        addon.SetBagsVisibility = SetValue

        local setting = Settings.RegisterProxySetting(minimalismCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(minimalismCategory, setting, tooltip)

        SetValue(GetValue())
    end

    do
        local name = "Hide Objectives Header"
        local variable = "HideObjectiveTrackerHeader"
        local defaultValue = false
        local tooltip = "Hide Objective Tracker header when collapsed."

        local function GetValue()
            return addon.database.HideObjectiveTrackerHeader or defaultValue
        end

        local function SetValue(value)
            if value and not addon.session.ObjectiveTrackerFrameHooked then
                ObjectiveTrackerFrame.Header.MinimizeButton:HookScript("OnClick", function(self)
                    if not addon.database.HideObjectiveTrackerHeader then return end
                    local isCollapsed = ObjectiveTrackerFrame.isCollapsed
                    ObjectiveTrackerFrame.Header.Background:SetAlpha(isCollapsed and 0 or 1)
                    ObjectiveTrackerFrame.Header.Text:SetAlpha(isCollapsed and 0 or 1)
                end)
                addon.session.ObjectiveTrackerFrameHooked = true
            end
            addon.database.HideObjectiveTrackerHeader = value
        end

        local setting = Settings.RegisterProxySetting(minimalismCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(minimalismCategory, setting, tooltip)

        SetValue(GetValue())
    end


    -- Interface Scaling category
    local uiScaleCategory, _ = Settings.RegisterVerticalLayoutSubcategory(mainCategory, "Interface Scaling")
    Settings.RegisterAddOnCategory(uiScaleCategory)

    do
        local name = "Game Menu"
        local variable = "GameMenuScale"
        local defaultValue = 1
        local minValue = 0.5
        local maxValue = 1.5
        local step = 0.01
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
        local name = "World Map"
        local variable = "WorldMapFrameScale"
        local defaultValue = 1
        local minValue = 0.5
        local maxValue = 1.5
        local step = 0.01
        local tooltip = "Adjust the World Map size to a more comfortable level."

        local function GetValue()
            return addon.database.WorldMapFrameScale or defaultValue
        end

        local function SetValue(value)
            WorldMapFrame:SetScale(value)
            addon.database.WorldMapFrameScale = value
        end

        local setting = Settings.RegisterProxySetting(mainCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)

        local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, FormatPercentageRounded)
        Settings.CreateSlider(uiScaleCategory, setting, options, tooltip)

        SetValue(GetValue())
    end

    do
        local name = "Talent Pane and Spellbook"
        local variable = "PlayerSpellsFrameScale"
        local defaultValue = 1
        local minValue = 0.5
        local maxValue = 1.5
        local step = 0.01
        local tooltip = "Adjust the Talents Pane and Spellbook size to a more comfortable level."

        local function GetValue()
            return addon.database.PlayerSpellsFrameScale or defaultValue
        end

        local function SetValue(value)
	          if not PlayerSpellsFrame then
		            PlayerSpellsFrame_LoadUI()
	          end
            PlayerSpellsFrame:HookScript("OnShow", function(self)
                PlayerSpellsFrame:SetScale(value)
            end)
            addon.database.PlayerSpellsFrameScale = value
        end

        local setting = Settings.RegisterProxySetting(mainCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)

        local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, FormatPercentageRounded)
        Settings.CreateSlider(uiScaleCategory, setting, options, tooltip)

        SetValue(GetValue())
    end

    do
        local name = "Legacy Pane"
        local variable = "LegacySystemFrameScale"
        local defaultValue = 1
        local minValue = 0.5
        local maxValue = 1.5
        local step = 0.01
        local tooltip = "Adjust the Legacy Pane size to a more comfortable level."

        local function GetValue()
            return addon.database.LegacySystemFrameScale or defaultValue
        end

        local function SetValue(value)
	          if not LegacySystemFrame then
		            LegacySystemFrame_LoadUI()
	          end
            LegacySystemFrame:HookScript("OnShow", function(self)
                LegacySystemFrame:SetScale(value)
            end)
            addon.database.LegacySystemFrameScale = value
        end

        local setting = Settings.RegisterProxySetting(mainCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)

        local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, FormatPercentageRounded)
        Settings.CreateSlider(uiScaleCategory, setting, options, tooltip)

        SetValue(GetValue())
    end

    do
        local name = "Guild Pane"
        local variable = "CommunitiesFrameScale"
        local defaultValue = 1
        local minValue = 0.5
        local maxValue = 1.5
        local step = 0.01
        local tooltip = "Adjust the Guild Pane size to a more comfortable level."

        local function GetValue()
            return addon.database.CommunitiesFrameScale or defaultValue
        end

        local function SetValue(value)
	          if not CommunitiesFrame then
		            CommunitiesFrame_LoadUI()
	          end
            CommunitiesFrame:HookScript("OnShow", function(self)
                CommunitiesFrame:SetScale(value)
            end)
            addon.database.CommunitiesFrameScale = value
        end

        local setting = Settings.RegisterProxySetting(mainCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)

        local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, FormatPercentageRounded)
        Settings.CreateSlider(uiScaleCategory, setting, options, tooltip)

        SetValue(GetValue())
    end

    do
        local name = "Collections Pane"
        local variable = "CollectionsJournalScale"
        local defaultValue = 1
        local minValue = 0.5
        local maxValue = 1.5
        local step = 0.01
        local tooltip = "Adjust the Collections Pane size to a more comfortable level."

        local function GetValue()
            return addon.database.CollectionsJournalScale or defaultValue
        end

        local function SetValue(value)
	          if not CollectionsJournal then
		            CollectionsJournal_LoadUI()
	          end
            CollectionsJournal:HookScript("OnShow", function(self)
                CollectionsJournal:SetScale(value)
            end)
            addon.database.CollectionsJournalScale = value
        end

        local setting = Settings.RegisterProxySetting(mainCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)

        local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, FormatPercentageRounded)
        Settings.CreateSlider(uiScaleCategory, setting, options, tooltip)

        SetValue(GetValue())
    end

    do
        local name = "Looking For Group"
        local variable = "LFGParentFrameScale"
        local defaultValue = 1
        local minValue = 0.5
        local maxValue = 1.5
        local step = 0.01
        local tooltip = "Adjust the Looking For Group pane size to a more comfortable level."

        local function GetValue()
            return addon.database.LFGParentFrameScale or defaultValue
        end

        local function SetValue(value)
            LFGParentFrame:SetScale(value)
            addon.database.LFGParentFrameScale = value
        end

        local setting = Settings.RegisterProxySetting(mainCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)

        local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, FormatPercentageRounded)
        Settings.CreateSlider(uiScaleCategory, setting, options, tooltip)
        addon.database.LFGParentFrameScale = GetValue()
    end

    do
        local name = "Character Pane"
        local variable = "CharacterFrameScale"
        local defaultValue = 1
        local minValue = 0.5
        local maxValue = 1.5
        local step = 0.01
        local tooltip = "Adjust the Character Pane size to a more comfortable level."

        local function GetValue()
            return addon.database.CharacterFrameScale or defaultValue
        end

        local function SetValue(value)
            CharacterFrame:SetScale(value)
            addon.database.CharacterFrameScale = value
        end

        local setting = Settings.RegisterProxySetting(mainCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)

        local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, FormatPercentageRounded)
        Settings.CreateSlider(uiScaleCategory, setting, options, tooltip)

        SetValue(GetValue())
    end

    do
        local name = "Professions Pane"
        local variable = "ProfessionsFrameScale"
        local defaultValue = 1
        local minValue = 0.5
        local maxValue = 1.5
        local step = 0.01
        local tooltip = "Adjust the Professions Pane size to a more comfortable level."

        local function GetValue()
            return addon.database.ProfessionsFrameScale or defaultValue
        end

        local function SetValue(value)
	          if not ProfessionsFrame then
		            ProfessionsFrame_LoadUI()
	          end
            ProfessionsFrame:HookScript("OnShow", function(self)
                ProfessionsFrame:SetScale(value)
            end)
            addon.database.ProfessionsFrameScale = value
        end

        local setting = Settings.RegisterProxySetting(mainCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)

        local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, FormatPercentageRounded)
        Settings.CreateSlider(uiScaleCategory, setting, options, tooltip)

        SetValue(GetValue())
    end

    do
        local name = "Status Bar"
        local variable = "StatusTrackBarScale"
        local defaultValue = 1
        local minValue = 0.5
        local maxValue = 1.5
        local step = 0.01
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
        local name = "Secondary Status Bar"
        local variable = "SecondaryStatusTrackBarScale"
        local defaultValue = 1
        local minValue = 0.5
        local maxValue = 1.5
        local step = 0.01
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

    do

        local name = "Unit Frame level indicator"
        local variable = "UnitFrameLevelIndicator"
        local defaultValue = 1
        local minValue = 0.5
        local maxValue = 1.5
        local step = 0.01
        local tooltip = "Adjust the Unit Frame level circle and text size to a more comfortable level."

        local function GetValue()
            return addon.database.UnitFrameLevelIndicator or defaultValue
        end

        local function SetValue(value)
            -- set scale
            PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.LevelBackgroundCircle:SetScale(value)
            TargetFrame.TargetFrameContent.TargetFrameContentMain.LevelBackgroundCircle:SetScale(value)
            FocusFrame.TargetFrameContent.TargetFrameContentMain.LevelBackgroundCircle:SetScale(value)
            PlayerLevelText:SetScale(value)
            TargetFrame.TargetFrameContent.TargetFrameContentMain.LevelText:SetScale(value)
            FocusFrame.TargetFrameContent.TargetFrameContentMain.LevelText:SetScale(value)
            -- center text
            PlayerLevelText:SetPoint("CENTER", PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.LevelBackgroundCircle, "CENTER", 0, 0)
            TargetFrame.TargetFrameContent.TargetFrameContentMain.LevelText:SetPoint("CENTER", TargetFrame.TargetFrameContent.TargetFrameContentMain.LevelBackgroundCircle, "CENTER", 0, 0)
            FocusFrame.TargetFrameContent.TargetFrameContentMain.LevelText:SetPoint("CENTER", FocusFrame.TargetFrameContent.TargetFrameContentMain.LevelBackgroundCircle, "CENTER", 0, 0)
            addon.database.UnitFrameLevelIndicator = value
        end

        local setting = Settings.RegisterProxySetting(mainCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)

        local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, FormatPercentageRounded)
        Settings.CreateSlider(uiScaleCategory, setting, options, tooltip)

        SetValue(GetValue())
    end


    -- Unit Frames category
    local unitFramesCategory, unitFramesLayout = Settings.RegisterVerticalLayoutSubcategory(mainCategory, "Unit Frames")
    Settings.RegisterAddOnCategory(unitFramesCategory)

	  unitFramesLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Player"));
    do
        local name = "Name class color"
        local variable = "PlayerNameClassColor"
        local defaultValue = false
        local tooltip = "Adds class color to the Player name text."

        local function GetValue()
            return addon.database.PlayerNameClassColor or defaultValue
        end

        local function SetValue(value)
            if value then
                PlayerName:SetVertexColor(addon.session.PlayerColor.r, addon.session.PlayerColor.g, addon.session.PlayerColor.b)
            else
                PlayerName:SetVertexColor(1, 0.82352942228317, 0)
            end
            addon.database.PlayerNameClassColor = value
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

    unitFramesLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Target and Focus"))
    do
        local name = "Name class color"
        local variable = "TargetFocusReputationClassColor"
        local defaultValue = false
        local tooltip = "Adds class color to the Target and Focus name text."

        local function CleanupTarget()
            TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetVertexColor(1, 0.82352942228317, 0)
            TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:Show()
        end

        local function CleanupFocus()
            FocusFrame.TargetFrameContent.TargetFrameContentMain.Name:SetVertexColor(1, 0.82352942228317, 0)
            FocusFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:Show()
        end

        local function ColorFrameName()
            if UnitIsPlayer("target") then
                local c = RAID_CLASS_COLORS[select(2, UnitClass("target"))]
                TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetVertexColor(c.r, c.g, c.b)
                TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:Hide()
            else
                CleanupTarget()
            end
            if UnitIsPlayer("focus") then
                local c = RAID_CLASS_COLORS[select(2, UnitClass("focus"))]
                FocusFrame.TargetFrameContent.TargetFrameContentMain.Name:SetVertexColor(c.r, c.g, c.b)
                FocusFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:Hide()
            else
                CleanupFocus()
            end
        end

        local function RegisterEvents()
            local EmptyNameColorFrame = addon.session.EmptyNameColorFrame
            if not EmptyNameColorFrame then
                EmptyNameColorFrame = CreateFrame("FRAME")
                EmptyNameColorFrame:SetScript("OnEvent", ColorFrameName)
            end
            EmptyNameColorFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
            EmptyNameColorFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
            EmptyNameColorFrame:RegisterEvent("PLAYER_FOCUS_CHANGED")
            EmptyNameColorFrame:RegisterEvent("UNIT_FACTION")
            addon.session.EmptyNameColorFrame = EmptyNameColorFrame
        end

        local function UnregisterEvents()
            local EmptyNameColorFrame = addon.session.EmptyNameColorFrame
            if not EmptyNameColorFrame then return end
            EmptyNameColorFrame:UnregisterAllEvents()
            CleanupTarget()
            CleanupFocus()
        end

        local function GetValue()
            return addon.database.TargetFocusReputationClassColor or defaultValue
        end

        local function SetValue(value)
            addon.database.TargetFocusReputationClassColor = value
            if value then
                RegisterEvents()
                ColorFrameName()
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
    -- Key Bindings category
    local keyBindingsCategory, keyBindingsLayout = Settings.RegisterVerticalLayoutSubcategory(mainCategory, "Key Bindings")
    Settings.RegisterAddOnCategory(keyBindingsCategory)

    do
        local action = "LIMAUI_OPEN"
        _G["BINDING_NAME_"..action] = "Open Lima UI"
        local bindingIndex = C_KeyBindings.GetBindingIndex(action)
        local initializer = CreateKeybindingEntryInitializer(bindingIndex, true)
        keyBindingsLayout:AddInitializer(initializer)

        if not GetMacroInfo("LIMAUI_OUTFITS") then
            CreateMacro("LIMAUI_OUTFITS", 135056, "/luioutfits", false)
        end

        local action = "LIMAUI_OPEN_OUTFITS"
        _G["BINDING_NAME_"..action] = "Open Outfits"
        local bindingIndex = C_KeyBindings.GetBindingIndex(action)
        local initializer = CreateKeybindingEntryInitializer(bindingIndex, true)
        keyBindingsLayout:AddInitializer(initializer)

        local action = "LIMAUI_RELOAD"
        _G["BINDING_NAME_"..action] = "Reload UI"
        local bindingIndex = C_KeyBindings.GetBindingIndex(action)
        local initializer = CreateKeybindingEntryInitializer(bindingIndex, true)
        keyBindingsLayout:AddInitializer(initializer)

        local action = "ITEM Hearthstone"
        _G["BINDING_NAME_"..action] = "Hearthstone"
        local bindingIndex = C_KeyBindings.GetBindingIndex(action)
        local initializer = CreateKeybindingEntryInitializer(bindingIndex, true)
        keyBindingsLayout:AddInitializer(initializer)

        if not GetMacroInfo("LIMAUI_FOCUS") then
            CreateMacro("LIMAUI_FOCUS", 132284, "/focus [@mouseover,exists][]", false)
        end

        local action = "MACRO LIMAUI_FOCUS"
        _G["BINDING_NAME_"..action] = "Focus Mouseover"
        local bindingIndex = C_KeyBindings.GetBindingIndex(action)
        local initializer = CreateKeybindingEntryInitializer(bindingIndex, true)
        keyBindingsLayout:AddInitializer(initializer)
    end

    -- Automation category
    local automationCategory, automationLayout = Settings.RegisterVerticalLayoutSubcategory(mainCategory, "Automation")
    Settings.RegisterAddOnCategory(automationCategory)

    do
        local name = "Auto Repair"
        local variable = "AutomationRepairGear"
        local defaultValue = false
        local tooltip = "Automatically repairs gear when a merchant window is open."
			  local function RepairFunc()
				    if CanMerchantRepair() then
					      local RepairCost, CanRepair = GetRepairAllCost()
					      if CanRepair then
                    RepairAllItems()
							      print("Repaired for "..C_CurrencyInfo.GetCoinText(RepairCost)..".")
					      end
				    end
			  end

        local function GetValue()
            return addon.database.AutomationRepairGear or defaultValue
        end

        local RepairFrame = CreateFrame("FRAME")
        RepairFrame:SetScript("OnEvent", RepairFunc)

        local function SetValue(value)
            if value then
					      RepairFrame:RegisterEvent("MERCHANT_SHOW")
				    else
					      RepairFrame:UnregisterEvent("MERCHANT_SHOW")
            end
            addon.database.AutomationRepairGear = value
        end

        local setting = Settings.RegisterProxySetting(automationCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(automationCategory, setting, tooltip)

        SetValue(GetValue())
    end

    do
        local name = "Fast Loot"
        local variable = "FastLoot"
        local defaultValue = false
        local tooltip = "Increases looting speed by reducing loot window delay."

        local function GetValue()
            return addon.database.FastLoot or defaultValue
        end

        local tDelay = 0
        local lootDelay = 0.3 -- setting delay lower than this doesn't improve results

			  local function FastLoot()
				    if GetTime() - tDelay >= lootDelay then
					      tDelay = GetTime()
					      if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
						        for i = GetNumLootItems(), 1, -1 do
							          LootSlot(i)
						        end
						        tDelay = GetTime()
					      end
				    end
			  end

			  local FastLootFrame = CreateFrame("Frame")
			  FastLootFrame:SetScript("OnEvent", FastLoot)

        local function SetValue(value)
            if value then
			          FastLootFrame:RegisterEvent("LOOT_READY")
				    else
			          FastLootFrame:UnregisterEvent("LOOT_READY")
            end
            addon.database.FastLoot = value
        end

        local setting = Settings.RegisterProxySetting(automationCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(automationCategory, setting, tooltip)

        SetValue(GetValue())
    end

    -- Variables category
    local variablesCategory, variablesLayout = Settings.RegisterVerticalLayoutSubcategory(mainCategory, "Variables")
    Settings.RegisterAddOnCategory(variablesCategory)

    do
        local variablesList = {
            [1] = { name = "Interface", separator = true },
            [2] = {
                cvar = "rotateMinimap",
                name = "Rotate Minimap",
                varType = Settings.VarType.Boolean,
                format = Formatter,
                min = 0, max = 1, step = 1,
                tooltip = "Rotates minimap."
            },
            [3] = {
                cvar = "cameraDistanceMaxZoomFactor",
                name = "Max Camera Distance",
                varType = Settings.VarType.Number,
                format = Formatter,
                min = 1, max = 4, step = 1,
                tooltip = "Set max camera zoom level."
            },
            [4] = { name = "Graphics: Image Quality", separator = true },
            [5] = {
                cvar = "ResampleAlwaysSharpen",
                name = "Resample Always Sharpen",
                varType = Settings.VarType.Boolean,
                format = Formatter,
                min = 0, max = 1, step = 1,
                tooltip = "Forces always-on image sharpening. Also check Resample Quality and Resample Sharpness in the Graphics options."
            },
            [6] = { name = "Graphics: Ground Effects", separator = true },
            [7] = {
                cvar = "groundEffectDist",
                name = "Ground Effect Distance",
                varType = Settings.VarType.Number,
                format = Formatter,
                min = 40, max = 500, step = 1,
                tooltip = "Ground foliage max render distance."
            },
            [8] = {
                cvar = "groundEffectFade",
                name = "Ground Effect Fade",
                varType = Settings.VarType.Number,
                format = Formatter,
                min = 0, max = 500, step = 1,
                tooltip = "Controls how much distance the ground foliage fades over."
            },
            [9] = {
                cvar = "groundEffectDensity",
                name = "Ground Effect Density",
                varType = Settings.VarType.Number,
                format = Formatter,
                min = 16, max = 256, step = 1,
                tooltip = "Sets grass and ground foliage density level."
            },
            [10] = { name = "Graphics: Weather", separator = true },
            [11] = {
                cvar = "weatherDensity",
                name = "Weather Density",
                varType = Settings.VarType.Number,
                format = Formatter,
                min = 0, max = 3, step = 1,
                tooltip = "Controls the intensity of Weather effects such as rain and snow."
            },
            [12] = {
                cvar = "reflectionMode",
                name = "Reflection Mode",
                varType = Settings.VarType.Number,
                format = Formatter,
                min = 0, max = 4, step = 1,
                tooltip = "Render a second pass for realistic reflections on water, trees, and character models."
            },
            [13] = { name = "Graphics: Object Culling", separator = true },
            [14] = {
                cvar = "lodObjectCullDist",
                name = "Object Culling Distance",
                varType = Settings.VarType.Number,
                format = FormatNumber,
                min = 1, max = 120, step = 1,
                tooltip = "Set Object Culling distance."
            },
            [15] = {
                cvar = "lodObjectCullSize",
                name = "Object Culling Size",
                varType = Settings.VarType.Number,
                format = FormatNumber,
                min = 1, max = 60, step = 1,
                tooltip = "Set Object Culling size."
            },
            [16] = {
                cvar = "lodObjectFadeScale",
                name = "Object Fade Scale",
                varType = Settings.VarType.Number,
                format = FormatNumber,
                min = 50, max = 200, step = 1,
                tooltip = "Set Object Culling fade scale."
            },
            [17] = {
                cvar = "lodObjectMinSize",
                name = "Object Minimum Size",
                varType = Settings.VarType.Number,
                format = FormatNumber,
                min = 1, max = 200, step = 1,
                tooltip = "Set Object Culling minimum size."
            },
            [18] = {
                cvar = "lodObjectSizeScale",
                name = "Object Size Scale",
                varType = Settings.VarType.Number,
                format = FormatNumber,
                min = 1, max = 50, step = 1,
                tooltip = "Set Object Culling size scale."
            },
        }
        for i, info in ipairs(variablesList) do
            if info.separator then
                variablesLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer(info.name))
            else
                getValue, setValue, getDefaultValue = Settings.CreateCVarAccessorClosures(info.cvar, info.varType)
                defaultValue = getDefaultValue()
                tooltip = info.tooltip.." (Default: "..tostring(defaultValue)..")"
		            local setting = Settings.RegisterProxySetting(variablesCategory, info.name, type(defaultValue), info.name, defaultValue, getValue, setValue);
                local options
                if info.varType == Settings.VarType.Boolean then
                    Settings.CreateCheckbox(variablesCategory, setting, tooltip)
                else
                    local options = Settings.CreateSliderOptions(info.min, info.max, info.step)
                    options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, info.format)
                    Settings.CreateSlider(variablesCategory, setting, options, tooltip)
                end
            end
        end
    end
end

local function LFGSettings()
    LFGParentFrame:SetScale(addon.database.LFGParentFrameScale)
end

addon.InitializeSettings = InitializeSettings
addon.LFGSettings = LFGSettings
