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
			Globals.current_music = A.mx_lionking_sc03_coco
			C.Mufasa.disable()
			C.Rafiki.enable()
			get_prop('Kingdom').disable()
		Globals.Branch.POPOCHIUS:
			Globals.current_music = A.mx_lionking_sc03_popochiu
		Globals.Branch.SIMBA:
			Globals.current_music = A.mx_lionking_sc03_lion
	
	await get_tree().create_timer(.2).timeout
	Globals.current_music.play()


# What happens when the room changing transition finishes. At this point the room
# is visible.
func _on_room_transition_finished() -> void:
	match Globals.lion_king_branch:
		Globals.Branch.COCO:
			await C.Narrator.say("Over time Rafiki became the official translator of the coconut.")
			await C.Coco.say('...')
			await C.Rafiki.say('What did you say?')
			
			var response: PopochiuDialogOption = await D.show_inline_dialog(
				"What did the coconut say?",
				[
					'You are the chosen one',
					'Mufasa has abused small animals',
					'Kill the King, if you really love me'
				]
			)
			
			match response.id:
				'0':
					Globals.lion_king_ending = Globals.Ending.COCO_A
					await C.Rafiki.say('The planet of the micos')
				'1':
					Globals.lion_king_ending = Globals.Ending.COCO_B
					await C.Rafiki.say('The elections')
				'2':
					Globals.lion_king_ending = Globals.Ending.COCO_C
					await C.Rafiki.say('The missadventures of Rafiki and the coconut')
				
			Globals.lion_king_seq += 1
			G.change_channel_requested.emit()
		Globals.Branch.SIMBA:
			await C.Mufasa.say('Everything the light touches is our kingdom.')
			
			var response: PopochiuDialogOption = await D.show_inline_dialog(
				"And Simba say...",
				[
					'Why?',
					'What about the caves?',
					"Does that make us landowners then?"
				]
			)
			
			await C.Simba.say(response.text)
			
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
