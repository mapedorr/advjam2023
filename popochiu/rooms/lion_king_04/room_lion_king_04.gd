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
	$Props.y_sort_enabled = false
	
	C.Scar.disable()
	
	match Globals.lion_king_branch:
		Globals.Branch.COCO:
			Globals.current_music = A.mx_lionking_sc04_coco
			# Aquí termina la historia del coco
			match Globals.lion_king_ending:
				Globals.Ending.COCO_A:
					get_prop('CocoEndingA').enable()
				Globals.Ending.COCO_B:
					get_prop('CocoEndingB').enable()
				Globals.Ending.COCO_C:
					get_prop('CocoEndingC').enable()
		Globals.Branch.POPOCHIUS:
			Globals.current_music = A.mx_lionking_sc04_popochiu
		Globals.Branch.SIMBA:
			Globals.current_music = A.mx_lionking_sc04
			C.Scar.enable()

	await get_tree().create_timer(.2).timeout
	Globals.current_music.play()

# What happens when the room changing transition finishes. At this point the room
# is visible.
func _on_room_transition_finished() -> void:
	match Globals.lion_king_branch:
		Globals.Branch.SIMBA:
			await C.Simba.say("What am I gonna do?")
			await C.Scar.say("Run away, Simba.")

			var response: PopochiuDialogOption = await D.show_inline_dialog(
				"What should Simba do?",
				[
					'Obey Scar',
					'Try to kill Scar',
					'Propose a deal to Scar'
				]
			)
			
			match response.id:
				'0':
					$AnimationPlayer.play("simba_leaves")
					await $AnimationPlayer.animation_finished
					await C.Scar.say("Kill him!")
				"1":
					C.Simba.play("04b")
					await C.Simba.say("You won't tell anyone a shit!")
				"2":
					C.Simba.play("04c")
					await C.Simba.say("Let's make a deal")
					await C.Simba.say("We say it was an accident and I'll let you inherit the kingdom")
			
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
