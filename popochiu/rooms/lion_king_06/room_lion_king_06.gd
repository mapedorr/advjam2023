@tool
extends PopochiuRoom

const Data := preload('room_lion_king_06_state.gd')

var state: Data = load('res://popochiu/rooms/lion_king_06/room_lion_king_06.tres')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
# TODO: Overwrite Godot's methods


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# What happens when Popochiu loads the room. At this point the room is in the
# tree but it is not visible
func _on_room_entered() -> void:
	$Characters.y_sort_enabled = false
	$Props.y_sort_enabled = false
	
	G.display("")
	
	match Globals.lion_king_branch:
		Globals.Branch.SIMBA:
			
			['Mufasa', 'Simba', 'Scar'].all(enable_prop)
		
		Globals.Branch.POPOCHIU_KING:
			match Globals.lion_king_ending:
				Globals.Ending.POPOCHIU_KING_A:
#					Globals.current_music = A.mx_lionking_sc06a
					get_prop('PopochiuEndingA').enable()
				Globals.Ending.POPOCHIU_KING_B:
#					Globals.current_music = A.mx_lionking_sc06b
					get_prop('PopochiuEndingB').enable()
				Globals.Ending.POPOCHIU_KING_C:
#					Globals.current_music = A.mx_lionking_sc06c
					get_prop('PopochiuEndingC').enable()


# What happens when the room changing transition finishes. At this point the room
# is visible.
func _on_room_transition_finished() -> void:
#	Globals.current_music.play()
	
	match Globals.lion_king_branch:
		Globals.Branch.SIMBA:
			pass
		Globals.Branch.POPOCHIU_KING:
			match Globals.lion_king_ending:
				Globals.Ending.POPOCHIU_KING_A:
					await E.queue([
						G.queue_display('King Mufasa never suspected what the \
hard work of the Popochius would mean...'),
						"Narrator: The Popochius began to build their houses \
and amusement parks.",
						"Narrator: They also built tourism resorts and shopping centers.",
						"Narrator: All the animals were displaced, and Mufasa \
died from depression."
					])
					
					# TODO: Mostrar el título de la pelícua modificado?
				Globals.Ending.POPOCHIU_KING_B:
					await G.display("The Popochius and the animals began to coexist peacefully.")
					
					$AnimationPlayer.play("ending_b")
					
					await E.wait(1.5)
					await C.Narrator.say("Soon, love took hold of everyone,")
					await C.Narrator.say("and the blending of species gave life to a new reign.")
					
					# TODO: Mostrar el título de la pelícua modificado?
				Globals.Ending.POPOCHIU_KING_C:
					await G.display("King Mufasa ate one of the Popochius in an \
attempt to intimidate them, but he didn't expect them to be so delicious, tender, and addictive.")
					
					await E.wait(5.0)
					# TODO: Mostrar el título de la pelícua modificado?
			
			# TODO: ¿Guardar algo para que vuelva a iniciar la historia?
			Globals.lion_king_seq += 1
			G.change_channel_requested.emit()
			
			return
	
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
