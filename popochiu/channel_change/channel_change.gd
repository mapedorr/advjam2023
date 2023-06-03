extends CanvasLayer

signal transition_finished


func _ready() -> void:
	$VFX.hide()
	$Label.hide()


func play_room_change_start() -> void:
	A.sfx_tv_channel_switch.play()
	$Label.hide()
	$VFX.show()
	
	A.sfx_tv_static_lp.play()
	await get_tree().create_timer(0.1).timeout
	
	transition_finished.emit()
	A.sfx_tv_lp.stop()


func play_room_change_end() -> void:
	for ch in Globals.channels:
		if R.current.script_name.find(ch) > -1:
			$Label.text = 'CH - %s' % Globals.channels[ch].code
			break
	$Label.show()
	
	A.sfx_tv_static_lp.stop()
	await get_tree().create_timer(0.3).timeout
	$VFX.hide()
	
	transition_finished.emit()
	A.sfx_tv_lp.play()
	
	await get_tree().create_timer(1.5).timeout
	
	$Label.hide()
