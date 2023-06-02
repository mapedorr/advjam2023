extends CanvasLayer

@onready var btn_continue: TextureButton = %BtnContinue


func _ready() -> void:
	C.character_spoke.connect(_enable_continue)
	
	btn_continue.hide()


func _on_btn_change_channel_pressed() -> void:
	E.goto_room('Jurassic' if R.current.script_name == 'Tests' else 'LionKing01')


func _on_btn_continue_pressed() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(
		$MainContainer/LblTemp, "visible_ratio",
		0.0, 0.3
	).from(1.0)
	
	btn_continue.hide()
	G.continue_clicked.emit()


func _enable_continue(_c: PopochiuCharacter, m: String) -> void:
	$MainContainer/LblTemp.text = m
	
	var tween := get_tree().create_tween()
	tween.tween_property(
		$MainContainer/LblTemp, "visible_ratio",
		1.0, 2.0
	).from(0.0)
	
	btn_continue.show()
