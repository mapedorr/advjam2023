@tool
extends PopochiuRoom

const Data := preload('room_lion_king_04_state.gd')

var state: Data = load('res://popochiu/rooms/lion_king_04/room_lion_king_04.tres')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
# TODO: Overwrite Godot's methods


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# What happens when Popochiu loads the room. At this point the room is in the
# tree but it is not visible
func _on_room_entered() -> void:
	pass


# What happens when the room changing transition finishes. At this point the room
# is visible.
func _on_room_transition_finished() -> void:
	match Globals.lion_king_branch:
		Globals.Branch.SIMBA:
#			await C.Mufasa.say('But the King is dead')
#			await C.Mufasa.say("And if it weren't for you,")
#			await C.Mufasa.say("he'd still be alive")
#			await C.Mufasa.say("...")
			await C.Mufasa.say("What will your mother think?")
			await C.Simba.say("What am I gonna do?")
			await C.Simba.say("Run away, Simba.")

			var response: PopochiuDialogOption = await D.show_inline_dialog([
				'Obey Scar',
				'Try to kill Scar',
				'Propose a deal to Scar'
			])


# What happens before Popochiu unloads the room.
# At this point, the screen is black, processing is disabled and all characters
# have been removed from the $Characters node.
func _on_room_exited() -> void:
	pass


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
# You could put public functions here


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
# You could put private functions here
