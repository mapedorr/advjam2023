extends CanvasLayer

signal transition_finished


func _ready() -> void:
	$VFX.hide()
	$Label.hide()


func play_room_change_start() -> void:
	$Label.hide()
	$VFX.show()
	
	await get_tree().create_timer(0.1).timeout
	
	transition_finished.emit()


func play_room_change_end() -> void:
	$Label.text = 'CH - %s' % R.current.state.channel
	$Label.show()
	
	await get_tree().create_timer(0.3).timeout
	$VFX.hide()
	
	transition_finished.emit()
	
	await get_tree().create_timer(1.5).timeout
	
	$Label.hide()
