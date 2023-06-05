extends CanvasLayer

@onready var btn_continue: TextureButton = %BtnContinue


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	$MainContainer/LblTemp.text = ''
	C.character_spoke.connect(_enable_continue)
	
	btn_continue.hide()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _enable_continue(_c: PopochiuCharacter, m: String) -> void:
	$MainContainer/LblTemp.text = m
	
	var tween := get_tree().create_tween()
	tween.tween_property(
		$MainContainer/LblTemp, "visible_ratio",
		1.0, 1.0
	).from(0.0)
	
	btn_continue.show()


func _on_btn_change_channel_pressed() -> void:
	Globals.change_channel()


func _on_btn_continue_pressed() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(
		$MainContainer/LblTemp, "visible_ratio",
		0.0, 0.1
	).from(1.0)
	
	btn_continue.hide()
	G.continue_clicked.emit()


func _on_btn_power_toggled(button_pressed: bool) -> void:
	if button_pressed:
		A.sfx_tv_on.play()
		A.sfx_tv_lp.play()
		Globals.change_channel(true)
	else:
		A.sfx_tv_lp.stop()
		A.sfx_tv_off.play()
		E.goto_room('MainMenu', false)
