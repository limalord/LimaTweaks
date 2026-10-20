local addonName, addon = ...

local function InitializeSettings()
    -- Main LimaUI category
    local mainCategory, _ = Settings.RegisterVerticalLayoutCategory(addonName)
    addon.settingsCategory = mainCategory
    addon.settingsCategoryID = mainCategory:GetID()
    Settings.RegisterAddOnCategory(mainCategory)

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

        local setting = Settings.RegisterProxySetting(mainCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(mainCategory, setting, tooltip)

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

        local setting = Settings.RegisterProxySetting(mainCategory, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
        Settings.CreateCheckbox(mainCategory, setting, tooltip)

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
			          hooksecurefunc(PetHitIndicator, "Show", PetHitIndicator.Hide)
            else
			          PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HitIndicator:Show()
			          hooksecurefunc(PetHitIndicator, "Show", PetHitIndicator.Show)
            end
            addon.database.HidePortraitHitIndicator = value
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


    -- Unit Frames category
    local unitFramesCategory, unitFramesLayout = Settings.RegisterVerticalLayoutSubcategory(mainCategory, "Unit Frames")
    Settings.RegisterAddOnCategory(unitFramesCategory)

	  unitFramesLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Player"));
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

    unitFramesLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Target and Focus"))
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
    -- Key Bindings category
    local keyBindingsCategory, keyBindingsLayout = Settings.RegisterVerticalLayoutSubcategory(mainCategory, "Key Bindings")
    Settings.RegisterAddOnCategory(keyBindingsCategory)

    do
        local action = "LIMA_UI_OPEN"
        _G["BINDING_NAME_"..action] = "Open Lima UI"
        local bindingIndex = C_KeyBindings.GetBindingIndex(action)
        local initializer = CreateKeybindingEntryInitializer(bindingIndex, true)
        keyBindingsLayout:AddInitializer(initializer)

        local action = "LIMA_UI_RELOAD"
        _G["BINDING_NAME_"..action] = "Reload UI"
        local bindingIndex = C_KeyBindings.GetBindingIndex(action)
        local initializer = CreateKeybindingEntryInitializer(bindingIndex, true)
        keyBindingsLayout:AddInitializer(initializer)

        local action = "ITEM Hearthstone"
        _G["BINDING_NAME_"..action] = "Hearthstone"
        local bindingIndex = C_KeyBindings.GetBindingIndex(action)
        local initializer = CreateKeybindingEntryInitializer(bindingIndex, true)
        keyBindingsLayout:AddInitializer(initializer)

        if not GetMacroInfo("Z_FOCUS") then
            CreateMacro("Z_FOCUS", "INV_Misc_QuestionMark", "/focus [@mouseover,exists][]", false)
        end

        local action = "MACRO Z_FOCUS"
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
end

local function LFGSettings()
    LFGParentFrame:SetScale(addon.database.LFGParentFrameScale)
end

addon.InitializeSettings = InitializeSettings
addon.LFGSettings = LFGSettings
