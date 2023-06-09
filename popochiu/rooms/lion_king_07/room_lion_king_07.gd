@tool
extends PopochiuRoom

const Data := preload('room_lion_king_07_state.gd')

var state: Data = load('res://popochiu/rooms/lion_king_07/room_lion_king_07.tres')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
# TODO: Overwrite Godot's methods


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# What happens when Popochiu loads the room. At this point the room is in the
# tree but it is not visible
func _on_room_entered() -> void:
	$Characters.y_sort_enabled = false
	$Props.y_sort_enabled = false
	
	match Globals.lion_king_ending:
		Globals.Ending.SIMBA_B:
			Globals.current_music = A.mx_lionking_sc07a
			
			get_prop("SimbaEndingA").enable()
		Globals.Ending.SIMBA_C:
			get_prop("SimbaEndingB").enable()
			
			Globals.current_music = A.mx_lionking_sc07b


# What happens when the room changing transition finishes. At this point the room
# is visible.
func _on_room_transition_finished() -> void:
	Globals.current_music.play()
	
	match Globals.lion_king_ending:
		Globals.Ending.SIMBA_B:
			await E.queue([
				"Narrator: Scar killed Simba and recovered the power.",
				"Narrator: His first order was to kill the betrayers.",
				"Narrator: His reign didn't last long,",
				"Narrator: and the hyenas ended up devouring him and taking over what, was once known as,",
				"Narrator: Pride Lands.",
			])
			
			get_prop("SimbaEndingA").disable()
			get_prop("TheShameLands").enable()
		Globals.Ending.SIMBA_C:
			await E.queue([
				"Narrator: Simba threw Scar, and he was killed by the hyenas.",
				"Narrator: Everyone cried, and that caused it to start raining.",
				"Narrator: Or was it the other way around?",
				"Narrator: The kingdom regained its life.",
			])
			
			get_prop("SimbaEndingB").disable()
			get_prop("TheLionKing").enable()
	
	Globals.current_music.stop()
	A.sfx_lion_king_boom.play()
	
	await E.wait(3.0)
	
	# TODO: ¿Guardar algo para que vuelva a iniciar la historia?
	Globals.lion_king_seq += 1
	G.change_channel_requested.emit()


# What happens before Popochiu unloads the room.
# At this point, the screen is black, processing is disabled and all characters
# have been removed from the $Characters node.
func _on_room_exited() -> void:
	pass


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
# You could put public functions here


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
# You could put private functions here
