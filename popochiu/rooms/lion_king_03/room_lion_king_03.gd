@tool
extends PopochiuRoom

const Data := preload('room_lion_king_03_state.gd')

var state: Data = load('res://popochiu/rooms/lion_king_03/room_lion_king_03.tres')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
# TODO: Overwrite Godot's methods


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# What happens when Popochiu loads the room. At this point the room is in the
# tree but it is not visible
func _on_room_entered() -> void:
	C.Rafiki.disable()
	
	match Globals.lion_king_branch:
		Globals.Branch.COCO:
			C.Mufasa.disable()
			C.Rafiki.enable()
			get_prop('Kingdom').disable()


# What happens when the room changing transition finishes. At this point the room
# is visible.
func _on_room_transition_finished() -> void:
	match Globals.lion_king_branch:
		Globals.Branch.COCO:
			await C.Coco.say('...')
			await C.Rafiki.say('What did you say?')
			
			var response: PopochiuDialogOption = await D.show_inline_dialog([
				'You are the chosen one',
				'Mufasa has abused small animals',
				'Kill the King, if you really love me'
			])
			
			match response.id:
				'0':
					C.Rafiki.say('The planet of the micos')
				'1':
					C.Rafiki.say('The elections')
				'2':
					C.Rafiki.say('The missadventures of Rafiki and the coconut')
		Globals.Branch.SIMBA:
			var response: PopochiuDialogOption = await D.show_inline_dialog([
				'Everything the light touches is our kingdom.',
				'Your mom is so hot!',
				'Wanna hear a joke, boy?'
			])
			
			await C.Mufasa.say(response.text)
			
			Globals.lion_king_seq += 1
			Globals.change_channel()


# What happens before Popochiu unloads the room.
# At this point, the screen is black, processing is disabled and all characters
# have been removed from the $Characters node.
func _on_room_exited() -> void:
	pass


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
# You could put public functions here


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
# You could put private functions here