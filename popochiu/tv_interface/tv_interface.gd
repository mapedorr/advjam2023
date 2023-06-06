extends CanvasLayer

@onready var btn_power: TextureButton = %BtnPower
@onready var btn_channel_indicator: TextureRect = %BtnChannelIndicator
@onready var btn_choice_indicator: TextureRect = %BtnChoiceIndicator
@onready var dialog_menu_title: Label = %DialogMenuTitle
@onready var btn_continue: TextureButton = %BtnContinue


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	$MainContainer/LblTemp.text = ''
	dialog_menu_title.text = ''
	dialog_menu_title.set_meta('ori_y', dialog_menu_title.position.y)
	
	C.character_spoke.connect(_enable_continue)
	G.title_setted.connect(_set_dialog_menu_title)
	G.change_channel_requested.connect(_on_btn_channel_pressed)
	Globals.channel_change_started.connect(_toggle_buttons.bind(true))
	Globals.channel_change_finished.connect(_toggle_buttons.bind(false))
	
	btn_continue.hide()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _enable_continue(c: PopochiuCharacter, m: String) -> void:
	if c == C.Narrator:
		$MainContainer/LblTemp.text = m
	else:
		$MainContainer/LblTemp.text = '%s: %s' % [c.description, m]
	
#	var tween := get_tree().create_tween()
#	tween.tween_property(
#		$MainContainer/LblTemp, "visible_ratio",
#		1.0, 1.0
#	).from(0.0)
	
	btn_continue.show()


func _on_btn_continue_pressed() -> void:
#	var tween := get_tree().create_tween()
#	tween.tween_property(
#		$MainContainer/LblTemp, "visible_ratio",
#		0.0, 0.1
#	).from(1.0)
	$MainContainer/LblTemp.text = ""
	
	btn_continue.hide()
	G.continue_clicked.emit()


func _on_btn_power_toggled(button_pressed: bool) -> void:
	if button_pressed:
		A.sfx_tv_on.play()
		A.sfx_tv_lp.play()
		Globals.change_channel(true)
		G.turned_on.emit()
	else:
		A.sfx_tv_lp.stop()
		A.sfx_tv_off.play()
		D.dialog_closed.emit()
		E.goto_room('MainMenu', false)
		G.turned_off.emit()


func _on_btn_channel_pressed() -> void:
	if not btn_power.button_pressed: return
	
	_turn_channel_knob()
	D.dialog_closed.emit()
	Globals.change_channel()


func _turn_channel_knob() -> void:
	btn_channel_indicator.rotation_degrees += 45


func _on_btn_choice_pressed() -> void:
	if not btn_power.button_pressed: return
	
	btn_choice_indicator.rotation_degrees += 90
	D.option_change_requested.emit()
#	TODO: hacer que sea un número random
	A.sfx_tv_switch_01.play()


func _on_btn_select_pressed() -> void:
	
	D.option_selection_requested.emit()
#	TODO: hacer que sea un número random y un sonido de selección
	A.sfx_tv_switch_03.play()


func _set_dialog_menu_title(title := '') -> void:
	if title.is_empty():
		dialog_menu_title.text = ''
		return
	
	var panel_size = await $MainContainer/DialogMenu.panel_resized
	
	dialog_menu_title.text = title
	dialog_menu_title.position.y =\
	dialog_menu_title.get_meta('ori_y') - panel_size.y


func _toggle_buttons(disable: bool) -> void:
	for b in get_tree().get_nodes_in_group('tv_button'):
		(b as BaseButton).disabled = disable
