extends CanvasLayer


func _on_btn_change_channel_pressed() -> void:
	E.goto_room('Jurassic' if R.current.script_name == 'Tests' else 'Tests')
