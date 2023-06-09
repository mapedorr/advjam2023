@tool
extends PopochiuRoom

const Data := preload('room_main_menu_state.gd')

var state: Data = load('res://popochiu/rooms/main_menu/room_main_menu.tres')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
# TODO: Overwrite Godot's methods


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# What happens when Popochiu loads the room. At this point the room is in the
# tree but it is not visible
func _on_room_entered() -> void:
	if state.visited_times:
		Globals.intro_triggered.emit()


# What happens when the room changing transition finishes. At this point the room
# is visible.
func _on_room_transition_finished() -> void:
	if state.visited_times:
		await E.queue([
			"...",
			Globals.queue_say_in_reality("The adventure jam has started."),
			Globals.queue_say_in_reality("And I have no idea of what to do..."),
			Globals.queue_say_in_reality("Every year is the same"),
			Globals.queue_say_in_reality(". . . . . ."),
			Globals.queue_say_in_reality("Maybe some channel surfing could give me ideas"),
		])
		
		Globals.intro_finished.emit()


# What happens before Popochiu unloads the room.
# At this point, the screen is black, processing is disabled and all characters
# have been removed from the $Characters node.
func _on_room_exited() -> void:
	pass


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
# You could put public functions here


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
# You could put private functions here
