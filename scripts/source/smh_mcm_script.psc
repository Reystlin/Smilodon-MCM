ScriptName SMH_MCM_Script Extends SKI_ConfigBase


Actor Property PlayerRef Auto
Spell Property ConfigSpell Auto
Globalvariable Property SMH_Mechanics_Global_AttacksCostStamina_1H Auto  ; Int
Globalvariable Property SMH_Mechanics_Global_AttacksCostStamina_2H Auto  ; Int
Globalvariable Property SMH_Mechanics_Global_AttacksCostStamina_Bow Auto  ; Int
Globalvariable Property SMH_Mechanics_Global_DisableAttacksOfOpprtunity Auto  ; Int
Globalvariable Property SMH_Mechanics_Global_DisableBowInterrupt Auto  ; Int
Globalvariable Property SMH_Mechanics_Global_DisableDragonPenalties Auto  ; Int
Globalvariable Property SMH_Mechanics_Global_DisableDynamicCombat Auto  ; Int
Globalvariable Property SMH_Mechanics_Global_DisableMeleeBoost Auto  ; Int
Globalvariable Property SMH_Mechanics_Global_DisableSpeedNerfZeroStamina Auto  ; Int
Globalvariable Property SMH_Mechanics_Global_DisableTimedBlock Auto  ; Int
Globalvariable Property SMH_Mechanics_Global_MinimumStaminaCostBash Auto  ; Int
Globalvariable Property SMH_Mechanics_Global_MinimumStaminaCostPowerAttack Auto  ; Int
Globalvariable Property SMH_Mechanics_Global_StaggerType Auto  ; Int
Spell Property SMH_DynamicCombat_Cloak_Spell_Ab Auto
Spell Property SMH_DynamicCombat_Spell_Ab Auto
Spell Property SMH_Mechanics_Spell_Ab Auto


String[] _menuEntriesStaggerType
Int _menuEntriesStaggerTypeIdx = 0


; Called when the config menu is initialized.
Event OnConfigInit()
	ModName = "$SMH_ModName"
	pages = New String[1]
	pages[0] = "$SMH_pages0"

	_menuEntriesStaggerType = New String[3]
	_menuEntriesStaggerType[0] = "$SMH_StaggerType0"
	_menuEntriesStaggerType[1] = "$SMH_StaggerType1"
	_menuEntriesStaggerType[2] = "$SMH_StaggerType2"
EndEvent


; Called when the config menu is closed.
Event OnConfigClose()
	If (SMH_Mechanics_Spell_Ab)
		PlayerRef.RemoveSpell(SMH_Mechanics_Spell_Ab)
	EndIf
	PlayerRef.AddSpell(SMH_Mechanics_Spell_Ab, False)
	If (SMH_DynamicCombat_Cloak_Spell_Ab)
		PlayerRef.RemoveSpell(SMH_DynamicCombat_Cloak_Spell_Ab)
	EndIf
	If (SMH_DynamicCombat_Spell_Ab)
		PlayerRef.RemoveSpell(SMH_DynamicCombat_Spell_Ab)
	EndIf
	If (!SMH_Mechanics_Global_DisableDynamicCombat.GetValue() As Bool)
		PlayerRef.AddSpell(SMH_DynamicCombat_Cloak_Spell_Ab, False)
		PlayerRef.AddSpell(SMH_DynamicCombat_Spell_Ab, False)
	EndIf
EndEvent


; Called when a version update of this script has been detected.
; a_version - The new version.
Event OnVersionUpdate(Int a_version)
EndEvent


; Called when a new page is selected, including the initial empty page.
; a_page - The name of the the current page, or "" if no page is selected.
Event OnPageReset(String a_page)
	If (a_page == "$SMH_pages0")
		SetCursorFillMode(LEFT_TO_RIGHT)

		AddHeaderOption("$SMH_HeaderOption_General")
		AddHeaderOption("")
		AddToggleOptionST("SMH_DisableAttacksOfOpprtunity_B", "$SMH_ToggleOption_DisableAttacksOfOpprtunity", !SMH_Mechanics_Global_DisableAttacksOfOpprtunity.GetValue() As Bool)
		AddSliderOptionST("SMH_MinimumStaminaCostPowerAttack_S", "$SMH_SliderOption_MinimumStaminaCostPowerAttack", SMH_Mechanics_Global_MinimumStaminaCostPowerAttack.GetValue() As Float)
		AddToggleOptionST("SMH_DisableMeleeBoost_B", "$SMH_ToggleOption_DisableMeleeBoost", !SMH_Mechanics_Global_DisableMeleeBoost.GetValue() As Bool)
		AddSliderOptionST("SMH_MinimumStaminaCostBash_S", "$SMH_SliderOption_MinimumStaminaCostBash", SMH_Mechanics_Global_MinimumStaminaCostBash.GetValue() As Float)
		AddToggleOptionST("SMH_DisableDragonPenalties_B", "$SMH_ToggleOption_DisableDragonPenalties", !SMH_Mechanics_Global_DisableDragonPenalties.GetValue() As Bool)
		AddEmptyOption()

		AddHeaderOption("$SMH_HeaderOption_DynamicCombat")
		AddHeaderOption("")
		AddToggleOptionST("SMH_DisableDynamicCombat_B", "$SMH_ToggleOption_DisableDynamicCombat", !SMH_Mechanics_Global_DisableDynamicCombat.GetValue() As Bool)
		AddEmptyOption()
		If (!SMH_Mechanics_Global_DisableDynamicCombat.GetValue() As Bool)
			AddToggleOptionST("SMH_DisableTimedBlock_B", "$SMH_ToggleOption_DisableTimedBlock", !SMH_Mechanics_Global_DisableTimedBlock.GetValue() As Bool)
			AddMenuOptionST("SMH_StaggerType_M", "$SMH_MenuOption_StaggerType", _menuEntriesStaggerType[_menuEntriesStaggerTypeIdx])
			AddToggleOptionST("SMH_DisableSpeedNerfZeroStamina_B", "$SMH_ToggleOption_DisableSpeedNerfZeroStamina", !SMH_Mechanics_Global_DisableSpeedNerfZeroStamina.GetValue() As Bool)
			AddSliderOptionST("SMH_AttacksCostStamina_1H_S", "$SMH_SliderOption_AttacksCostStamina_1H", SMH_Mechanics_Global_AttacksCostStamina_1H.GetValue() As Float)
			AddToggleOptionST("SMH_DisableBowInterrupt_B", "$SMH_ToggleOption_DisableBowInterrupt", !SMH_Mechanics_Global_DisableBowInterrupt.GetValue() As Bool)
			AddSliderOptionST("SMH_AttacksCostStamina_2H_S", "$SMH_SliderOption_AttacksCostStamina_2H", SMH_Mechanics_Global_AttacksCostStamina_2H.GetValue() As Float)
		EndIf

		AddHeaderOption("$SMH_HeaderOption_Misc")
		AddHeaderOption("")
		AddTextOptionST("SMH_Save_T", "$SAVE", "")
		AddTextOptionST("SMH_RemoveSpell_T", "$SMH_TextOption_RemoveSpell", "")
		AddTextOptionST("SMH_Load_T", "$LOAD", "")
	EndIf
EndEvent


State SMH_DisableAttacksOfOpprtunity_B
	Event OnSelectST()
		ToggleBool(SMH_Mechanics_Global_DisableAttacksOfOpprtunity)
		SetToggleOptionValueST(!SMH_Mechanics_Global_DisableAttacksOfOpprtunity.GetValue() As Bool)
	EndEvent

	Event OnDefaultST()
		SMH_Mechanics_Global_DisableAttacksOfOpprtunity.SetValue(0)
		SetToggleOptionValueST(!SMH_Mechanics_Global_DisableAttacksOfOpprtunity.GetValue() As Bool)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SMH_InfoText_DisableAttacksOfOpprtunity")
	EndEvent
EndState


State SMH_MinimumStaminaCostPowerAttack_S
	Event OnSliderOpenST()
		SetSliderDialogStartValue(SMH_Mechanics_Global_MinimumStaminaCostPowerAttack.GetValue() As Float)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 30)
		SetSliderDialogInterval(5)
	EndEvent

	Event OnSliderAcceptST(Float a_value)
		SMH_Mechanics_Global_MinimumStaminaCostPowerAttack.SetValue(a_value)
		SetSliderOptionValueST(a_value)
	EndEvent

	Event OnDefaultST()
		SMH_Mechanics_Global_MinimumStaminaCostPowerAttack.SetValue(0)
		SetSliderOptionValueST(0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SMH_InfoText_MinimumStaminaCostPowerAttack")
	EndEvent
EndState


State SMH_DisableMeleeBoost_B
	Event OnSelectST()
		ToggleBool(SMH_Mechanics_Global_DisableMeleeBoost)
		SetToggleOptionValueST(!SMH_Mechanics_Global_DisableMeleeBoost.GetValue() As Bool)
	EndEvent

	Event OnDefaultST()
		SMH_Mechanics_Global_DisableMeleeBoost.SetValue(0)
		SetToggleOptionValueST(!SMH_Mechanics_Global_DisableMeleeBoost.GetValue() As Bool)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SMH_InfoText_DisableMeleeBoost")
	EndEvent
EndState


State SMH_MinimumStaminaCostBash_S
	Event OnSliderOpenST()
		SetSliderDialogStartValue(SMH_Mechanics_Global_MinimumStaminaCostBash.GetValue() As Float)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 30)
		SetSliderDialogInterval(5)
	EndEvent

	Event OnSliderAcceptST(Float a_value)
		SMH_Mechanics_Global_MinimumStaminaCostBash.SetValue(a_value)
		SetSliderOptionValueST(a_value)
	EndEvent

	Event OnDefaultST()
		SMH_Mechanics_Global_MinimumStaminaCostBash.SetValue(0)
		SetSliderOptionValueST(0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SMH_InfoText_MinimumStaminaCostBash")
	EndEvent
EndState


State SMH_DisableDragonPenalties_B
	Event OnSelectST()
		ToggleBool(SMH_Mechanics_Global_DisableDragonPenalties)
		SetToggleOptionValueST(!SMH_Mechanics_Global_DisableDragonPenalties.GetValue() As Bool)
	EndEvent

	Event OnDefaultST()
		SMH_Mechanics_Global_DisableDragonPenalties.SetValue(0)
		SetToggleOptionValueST(!SMH_Mechanics_Global_DisableDragonPenalties.GetValue() As Bool)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SMH_InfoText_DisableDragonPenalties")
	EndEvent
EndState


State SMH_DisableDynamicCombat_B
	Event OnSelectST()
		ToggleBool(SMH_Mechanics_Global_DisableDynamicCombat)
		SetToggleOptionValueST(!SMH_Mechanics_Global_DisableDynamicCombat.GetValue() As Bool)
		ForcePageReset()
	EndEvent

	Event OnDefaultST()
		SMH_Mechanics_Global_DisableDynamicCombat.SetValue(0)
		SetToggleOptionValueST(!SMH_Mechanics_Global_DisableDynamicCombat.GetValue() As Bool)
		ForcePageReset()
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SMH_InfoText_DisableDynamicCombat")
	EndEvent
EndState


State SMH_DisableTimedBlock_B
	Event OnSelectST()
		ToggleBool(SMH_Mechanics_Global_DisableTimedBlock)
		SetToggleOptionValueST(!SMH_Mechanics_Global_DisableTimedBlock.GetValue() As Bool)
		If (!SMH_Mechanics_Global_DisableTimedBlock.GetValue() As Bool)
			ForcePageReset()
		EndIf
	EndEvent

	Event OnDefaultST()
		SMH_Mechanics_Global_DisableTimedBlock.SetValue(0)
		SetToggleOptionValueST(!SMH_Mechanics_Global_DisableTimedBlock.GetValue() As Bool)
		ForcePageReset()
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SMH_InfoText_DisableTimedBlock")
	EndEvent
EndState


State SMH_StaggerType_M
	Event OnMenuOpenST()
		SetMenuDialogStartIndex(_menuEntriesStaggerTypeIdx)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(_menuEntriesStaggerType)
	EndEvent

	Event OnMenuAcceptST(Int a_index)
		_menuEntriesStaggerTypeIdx = a_index
		SMH_Mechanics_Global_StaggerType.SetValue(a_index)
		SetMenuOptionValueST(_menuEntriesStaggerType[_menuEntriesStaggerTypeIdx])
	EndEvent

	Event OnDefaultST()
		_menuEntriesStaggerTypeIdx = 0
		SMH_Mechanics_Global_StaggerType.SetValue(0)
		SetMenuOptionValueST(_menuEntriesStaggerType[_menuEntriesStaggerTypeIdx])
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SMH_InfoText_StaggerType")
	EndEvent
EndState


State SMH_DisableSpeedNerfZeroStamina_B
	Event OnSelectST()
		ToggleBool(SMH_Mechanics_Global_DisableSpeedNerfZeroStamina)
		SetToggleOptionValueST(!SMH_Mechanics_Global_DisableSpeedNerfZeroStamina.GetValue() As Bool)
		If (!SMH_Mechanics_Global_DisableSpeedNerfZeroStamina.GetValue() As Bool)
			ForcePageReset()
		EndIf
	EndEvent

	Event OnDefaultST()
		SMH_Mechanics_Global_DisableSpeedNerfZeroStamina.SetValue(0)
		SetToggleOptionValueST(!SMH_Mechanics_Global_DisableSpeedNerfZeroStamina.GetValue() As Bool)
		ForcePageReset()
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SMH_InfoText_DisableSpeedNerfZeroStamina")
	EndEvent
EndState


State SMH_AttacksCostStamina_1H_S
	Event OnSliderOpenST()
		SetSliderDialogStartValue(SMH_Mechanics_Global_AttacksCostStamina_1H.GetValue() As Float)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 25)
		SetSliderDialogInterval(5)
	EndEvent

	Event OnSliderAcceptST(Float a_value)
		SMH_Mechanics_Global_AttacksCostStamina_1H.SetValue(a_value)
		SetSliderOptionValueST(a_value)
	EndEvent

	Event OnDefaultST()
		SMH_Mechanics_Global_AttacksCostStamina_1H.SetValue(10)
		SetSliderOptionValueST(10)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SMH_InfoText_AttacksCostStamina_1H")
	EndEvent
EndState


State SMH_DisableBowInterrupt_B
	Event OnSelectST()
		ToggleBool(SMH_Mechanics_Global_DisableBowInterrupt)
		SetToggleOptionValueST(!SMH_Mechanics_Global_DisableBowInterrupt.GetValue() As Bool)
		If (!SMH_Mechanics_Global_DisableBowInterrupt.GetValue() As Bool)
			ForcePageReset()
		EndIf
	EndEvent

	Event OnDefaultST()
		SMH_Mechanics_Global_DisableBowInterrupt.SetValue(0)
		SetToggleOptionValueST(!SMH_Mechanics_Global_DisableBowInterrupt.GetValue() As Bool)
		ForcePageReset()
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SMH_InfoText_DisableBowInterrupt")
	EndEvent
EndState


State SMH_AttacksCostStamina_2H_S
	Event OnSliderOpenST()
		SetSliderDialogStartValue(SMH_Mechanics_Global_AttacksCostStamina_2H.GetValue() As Float)
		SetSliderDialogDefaultValue(15)
		SetSliderDialogRange(0, 25)
		SetSliderDialogInterval(5)
	EndEvent

	Event OnSliderAcceptST(Float a_value)
		SMH_Mechanics_Global_AttacksCostStamina_2H.SetValue(a_value)
		SMH_Mechanics_Global_AttacksCostStamina_Bow.SetValue(a_value)
		SetSliderOptionValueST(a_value)
	EndEvent

	Event OnDefaultST()
		SMH_Mechanics_Global_AttacksCostStamina_2H.SetValue(15)
		SMH_Mechanics_Global_AttacksCostStamina_Bow.SetValue(15)
		SetSliderOptionValueST(15)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SMH_InfoText_AttacksCostStamina_2H")
	EndEvent
EndState


State SMH_Save_T
	Event OnSelectST()
		BeginSavePreset()
	EndEvent

	Event OnDefaultST()
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SMH_InfoText_Save")
	EndEvent
EndState


State SMH_RemoveSpell_T
	Event OnSelectST()
		If (ConfigSpell && PlayerRef.RemoveSpell(ConfigSpell))
			ShowMessage("$SMH_RemoveSpell_Success", False, "$OK")
		Else
			ShowMessage("$SMH_RemoveSpell_Failure", False, "$OK")
		EndIf
	EndEvent

	Event OnDefaultST()
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SMH_InfoText_RemoveSpell")
	EndEvent
EndState


State SMH_Load_T
	Event OnSelectST()
		BeginLoadPreset()
		ForcePageReset()
	EndEvent

	Event OnDefaultST()
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SMH_InfoText_Load")
	EndEvent
EndState


; Returns the static version of this script.
; RETURN - The static version of this script.
; History:
; 1 - Initial Release (v1.0.0)
Int Function GetVersion()
	Return 1
EndFunction


; Saves the current preset using FISS
Function BeginSavePreset()
	If (!ShowMessage("$SMH_Save_AreYouSure") || !ShowMessage("$SMH_PleaseWait"))
		Return
	EndIf

	FISSInterface fiss = FISSFactory.getFISS()
	If (!fiss)
		ShowMessage("$SMH_FISSNotFound", False, "$OK")
		Return
	EndIf

	fiss.beginSave("SmilodonCombatOfSkyrimMCM.xml", "Smilodon - Combat of Skyrim MCM")

	fiss.saveInt("SMH_DisableAttacksOfOpprtunity_B", SMH_Mechanics_Global_DisableAttacksOfOpprtunity.GetValue() As Int)
	fiss.saveInt("SMH_MinimumStaminaCostPowerAttack_S", SMH_Mechanics_Global_MinimumStaminaCostPowerAttack.GetValue() As Int)
	fiss.saveInt("SMH_DisableMeleeBoost_B", SMH_Mechanics_Global_DisableMeleeBoost.GetValue() As Int)
	fiss.saveInt("SMH_MinimumStaminaCostBash_S", SMH_Mechanics_Global_MinimumStaminaCostBash.GetValue() As Int)
	fiss.saveInt("SMH_DisableDragonPenalties_B", SMH_Mechanics_Global_DisableDragonPenalties.GetValue() As Int)
	fiss.saveInt("SMH_DisableDynamicCombat_B", SMH_Mechanics_Global_DisableDynamicCombat.GetValue() As Int)
	fiss.saveInt("SMH_DisableTimedBlock_B", SMH_Mechanics_Global_DisableTimedBlock.GetValue() As Int)
	fiss.saveInt("SMH_StaggerType_M", SMH_Mechanics_Global_StaggerType.GetValue() As Int)
	fiss.saveInt("SMH_DisableSpeedNerfZeroStamina_B", SMH_Mechanics_Global_DisableSpeedNerfZeroStamina.GetValue() As Int)
	fiss.saveInt("SMH_AttacksCostStamina_1H_S", SMH_Mechanics_Global_AttacksCostStamina_1H.GetValue() As Int)
	fiss.saveInt("SMH_DisableBowInterrupt_B", SMH_Mechanics_Global_DisableBowInterrupt.GetValue() As Int)
	fiss.saveInt("SMH_AttacksCostStamina_2H_S", SMH_Mechanics_Global_AttacksCostStamina_2H.GetValue() As Int)
	fiss.saveInt("SMH_AttacksCostStamina_Bow_S", SMH_Mechanics_Global_AttacksCostStamina_Bow.GetValue() As Int)

	String saveResult = fiss.endSave()

	If (saveResult != "")
		ShowMessage("$SMH_Save_Failure", False, "$OK")
	Else
		ShowMessage("$SMH_Save_Success", False, "$OK")
	EndIf
EndFunction


; Loads the saved preset using FISS
Function BeginLoadPreset()
	If (!ShowMessage("$SMH_Load_AreYouSure") || !ShowMessage("$SMH_PleaseWait"))
		Return
	EndIf

	FISSInterface fiss = FISSFactory.getFISS()
	If (!fiss)
		ShowMessage("$SMH_FISSNotFound", False, "$OK")
		Return
	EndIf

	fiss.beginLoad("SmilodonCombatOfSkyrimMCM.xml")

	SMH_Mechanics_Global_DisableAttacksOfOpprtunity.SetValue(fiss.loadInt("SMH_DisableAttacksOfOpprtunity_B"))
	SMH_Mechanics_Global_MinimumStaminaCostPowerAttack.SetValue(fiss.loadInt("SMH_MinimumStaminaCostPowerAttack_S"))
	SMH_Mechanics_Global_DisableMeleeBoost.SetValue(fiss.loadInt("SMH_DisableMeleeBoost_B"))
	SMH_Mechanics_Global_MinimumStaminaCostBash.SetValue(fiss.loadInt("SMH_MinimumStaminaCostBash_S"))
	SMH_Mechanics_Global_DisableDragonPenalties.SetValue(fiss.loadInt("SMH_DisableDragonPenalties_B"))
	SMH_Mechanics_Global_DisableDynamicCombat.SetValue(fiss.loadInt("SMH_DisableDynamicCombat_B"))
	SMH_Mechanics_Global_DisableTimedBlock.SetValue(fiss.loadInt("SMH_DisableTimedBlock_B"))
	SMH_Mechanics_Global_StaggerType.SetValue(fiss.loadInt("SMH_StaggerType_M"))
	_menuEntriesStaggerTypeIdx = fiss.loadInt("SMH_StaggerType_M")
	SMH_Mechanics_Global_DisableSpeedNerfZeroStamina.SetValue(fiss.loadInt("SMH_DisableSpeedNerfZeroStamina_B"))
	SMH_Mechanics_Global_AttacksCostStamina_1H.SetValue(fiss.loadInt("SMH_AttacksCostStamina_1H_S"))
	SMH_Mechanics_Global_DisableBowInterrupt.SetValue(fiss.loadInt("SMH_DisableBowInterrupt_B"))
	SMH_Mechanics_Global_AttacksCostStamina_2H.SetValue(fiss.loadInt("SMH_AttacksCostStamina_2H_S"))
	SMH_Mechanics_Global_AttacksCostStamina_Bow.SetValue(fiss.loadInt("SMH_AttacksCostStamina_Bow_S"))

	String loadResult = fiss.endLoad()

	If (loadResult != "")
		ShowMessage("$SMH_Load_Failure", False, "$OK")
	Else
		ShowMessage("$SMH_Load_Success", False, "$OK")
	EndIf
EndFunction


; Toggles the GlobalVariable True/False
; a_globalVar - The GlobalVariable to toggle
Function ToggleBool(GlobalVariable a_globalVar)
	If (a_globalVar.GetValue() As Bool)
		a_globalVar.SetValue(0)
	Else
		a_globalVar.SetValue(1)
	EndIf
EndFunction