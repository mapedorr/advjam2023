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
	$Props.y_sort_enabled = false
	
	match Globals.lion_king_branch:
		Globals.Branch.COCO:
			Globals.current_music = A.mx_lionking_sc03_coco
			G.display("")
			
			get_prop('Coco').show()
		Globals.Branch.SIMBA:
			Globals.current_music = A.mx_lionking_sc03_lion
			
			['Kingdom', 'Mufasa', 'Simba'].all(enable_prop)
		Globals.Branch.POPOCHIU_KING:
			Globals.current_music = A.mx_lionking_sc03_popochiu
			
			['Kingdom', 'Mufasa', 'Popochiu'].all(enable_prop)
	
	await get_tree().create_timer(.2).timeout
	Globals.current_music.play()


# What happens when the room changing transition finishes. At this point the room
# is visible.
func _on_room_transition_finished() -> void:
	match Globals.lion_king_branch:
		Globals.Branch.COCO:
			await G.display(
				"Over time Rafiki became the official translator of the coconut"
			)
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
			
			await C.Coco.say('...')
			
			match response.id:
				'0':
					Globals.lion_king_ending = Globals.Ending.COCO_A
					
					await E.queue([
						"Rafiki: Oh really?",
						"Rafiki: And what that does mean?",
						"Coco: ...",
						"Rafiki: So I have to be the king to start a new kingdom",
						"Coco: ...",
						"Rafiki: And how I'm gonna do that?",
						"Coco: ...",
						"Rafiki[2]: Oh my fucking monkey with a banana hat!!!"
					])
				'1':
					Globals.lion_king_ending = Globals.Ending.COCO_B
					
					await E.queue([
						"Rafiki: But what are you telling me?",
						"Coco: ...!!!",
						"Rafiki: Do you have evidence of that?",
						"Coco: ...",
						"Rafiki: Show me"
					])
				'2':
					Globals.lion_king_ending = Globals.Ending.COCO_C
					
					await E.queue([
						"Rafiki: I can't do it.",
						"Rafiki: Mufasa has trusted me for decades.",
						"Coco: ...",
						"Rafiki: Yes, I love you, but what you're asking doesn't make sense.",
						"Coco: ...",
						"Rafiki: What!? You can't do that.",
						"Rafiki: My love for you has nothing to do with him.",
						"Coco: ...........!!!",
						"Rafiki: No, no, no! Wait... don't go.",
						"Rafiki: If you really want me to do it as a test of love, then I'll do it.",
						"Coco: ...",
					])
				
			Globals.lion_king_seq += 1
			G.change_channel_requested.emit()
		Globals.Branch.SIMBA:
			await C.Mufasa.say('Everything the light touches is our kingdom.')
			
			var response: PopochiuDialogOption = await D.show_inline_dialog(
				"And Simba asked...",
				[
					'Why?',
					'What about the caves?',
					"Does that make us landowners then?"
				]
			)
			
			await C.Simba.say(response.text)
			
			Globals.lion_king_seq += 1
			G.change_channel_requested.emit()
		Globals.Branch.POPOCHIU_KING:
			pass


# What happens before Popochiu unloads the room.
# At this point, the screen is black, processing is disabled and all characters
# have been removed from the $Characters node.
func _on_room_exited() -> void:
	Globals.current_music.stop()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
# You could put public functions here


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
# You could put private functions here
