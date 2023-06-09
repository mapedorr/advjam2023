extends CanvasLayer

const ROTATION := 360.0 / 5.0

@onready var btn_power: TextureButton = %BtnPower
@onready var btn_channel_indicator: TextureRect = %BtnChannelIndicator
@onready var btn_choice_indicator: TextureRect = %BtnChoiceIndicator
@onready var rtl_dialog: RichTextLabel = %RtlDialog
@onready var dialog_menu_title: Label = %DialogMenuTitle
@onready var btn_continue: TextureButton = %BtnContinue
@onready var black_container: PanelContainer = %BlackContainer
@onready var rtl_black_speaker: RichTextLabel = %RtlBlackSpeaker
@onready var reality_black: ColorRect = %RealityBlack
@onready var rtl_reality_dialog: RichTextLabel = %RtlRealityDialog


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	rtl_dialog.text = ""
	rtl_reality_dialog.text = ""
	dialog_menu_title.text = ""
	dialog_menu_title.set_meta('ori_y', dialog_menu_title.position.y)
	
	C.character_spoke.connect(_show_character_text)
	G.title_setted.connect(_set_dialog_menu_title)
	G.change_channel_requested.connect(_on_btn_channel_pressed)
	G.show_box_requested.connect(_show_black_speaker)
	Globals.channel_change_started.connect(_toggle_buttons.bind(true))
	Globals.channel_change_finished.connect(_toggle_buttons.bind(false))
	Globals.intro_triggered.connect($RealityLayer.show)
	Globals.intro_finished.connect($RealityLayer.hide)
	Globals.reality_said.connect(_show_reality_dialog)
	
	btn_continue.hide()
	black_container.hide()
	
	$RealityLayer.hide()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _show_character_text(c: PopochiuCharacter, m: String) -> void:
	var text := '[center]%s[/center]'
	
	match c:
		C.Narrator:
			rtl_dialog.text = text % m
		C.Coco:
			rtl_dialog.text = text % (
				'%s: [shake rate=20.0 level=10.0]%s[/shake]' % [c.description, m]
			)
		_:
			rtl_dialog.text = text % ('%s: %s' % [c.description, m])
	
	btn_continue.show()
	
	if E.auto_continue_after > 0.0:
		await get_tree().create_timer(E.auto_continue_after).timeout
		
		if btn_continue.visible:
			_on_btn_continue_pressed()


func _on_btn_continue_pressed() -> void:
	rtl_dialog.text = ""
	rtl_black_speaker.text = ''
	
	btn_continue.hide()
	black_container.hide()
	rtl_reality_dialog.text = ''
	
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
	btn_channel_indicator.rotation_degrees += ROTATION


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


func _show_black_speaker(msg: String) -> void:
	btn_continue.show()
	black_container.show()
	rtl_black_speaker.text = '[center]%s[/center]' % msg


func _show_reality_dialog(msg: String) -> void:
	if not $RealityLayer.visible:
		$RealityLayer.show()
		reality_black.hide()
	
	btn_continue.show()
	rtl_reality_dialog.text = "[center]%s[/center]" % msg
