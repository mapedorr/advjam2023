@tool
extends PopochiuRoom

const Data := preload('room_lion_king_02_state.gd')

var state: Data = load('res://popochiu/rooms/lion_king_02/room_lion_king_02.tres')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
# TODO: Overwrite Godot's methods


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# What happens when Popochiu loads the room. At this point the room is in the
# tree but it is not visible
func _on_room_entered() -> void:
	$Characters.y_sort_enabled = false
	Globals.current_music = A.mx_lionking_sc01_lion
	await get_tree().create_timer(.2).timeout
	Globals.current_music.play()
	


# What happens when the room changing transition finishes. At this point the room
# is visible.
func _on_room_transition_finished() -> void:
	match Globals.lion_king_branch:
		Globals.Branch.COCO:
			await C.Coco.say('...')
			await C.Rafiki.say('The coconut thank you all!')
			await C.Coco.say('...')
			await C.Rafiki.say('He will inherit the throne with honor')
			await C.Narrator.say('( All animals bawl in euphoria )')
		Globals.Branch.SIMBA:
			await C.Narrator.say('( All animals bawl in euphoria )')
		Globals.Branch.POPOCHIU_KING:
			await C.Rafiki.say('This... thing will inherit the throne')
			await C.PopochiuKing.say('Hiya all my little friends')
			await C.PopochiuKing.say("I'm hungry!!!")
			await C.Narrator.say('( All animals bawl in euphoria )')
	
	Globals.lion_king_seq += 1
	G.change_channel_requested.emit()


# What happens before Popochiu unloads the room.
# At this point, the screen is black, processing is disabled and all characters
# have been removed from the $Characters node.
func _on_room_exited() -> void:
	Globals.current_music.stop()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
# You could put public functions here


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
# You could put private functions here
