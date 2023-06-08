@tool
extends PopochiuRoom

const Data := preload('room_lion_king_01_state.gd')

var state: Data = load('res://popochiu/rooms/lion_king_01/room_lion_king_01.tres')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
# TODO: Overwrite Godot's methods


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# What happens when Popochiu loads the room. At this point the room is in the
# tree but it is not visible
func _on_room_entered() -> void:
	$Props.y_sort_enabled = false
	$Characters.y_sort_enabled = false


# What happens when the room changing transition finishes. At this point the room
# is visible.
func _on_room_transition_finished() -> void:
	A.mx_lionking_sc01.play()
	
	var response: PopochiuDialogOption = await D.show_inline_dialog(
		'Who will inherit the throne?',
		[
			'The coconut', 'Simba', 'The Popochiu'
		]
	)
	
	match response.id:
		'0':
			Globals.progress_movie(Globals.Branch.COCO)
		'1':
			Globals.progress_movie(Globals.Branch.SIMBA)
		'2':
			Globals.progress_movie(Globals.Branch.POPOCHIU_KING)



# What happens before Popochiu unloads the room.
# At this point, the screen is black, processing is disabled and all characters
# have been removed from the $Characters node.
func _on_room_exited() -> void:
	A.mx_lionking_sc01.stop()
#	TODO: Hacer que esto sea menos chirri
	


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
# You could put public functions here


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
# You could put private functions here
