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
	$Characters.y_sort_enabled = false
	$Props.y_sort_enabled = false
	
	match Globals.lion_king_branch:
		Globals.Branch.COCO:
			# Aquí termina la historia del coco
			Globals.current_music = A.mx_lionking_sc04_coco
			
			G.display("")
			
			match Globals.lion_king_ending:
				Globals.Ending.COCO_A:
					get_prop('CocoEndingA').enable()
				Globals.Ending.COCO_B:
					get_prop('CocoEndingB').enable()
				Globals.Ending.COCO_C:
					get_prop('CocoEndingC').enable()
		
		Globals.Branch.POPOCHIU_KING:
			Globals.current_music = A.mx_lionking_sc04_popochiu
			
			get_prop('Popochius').enable()
		
		Globals.Branch.SIMBA:
			Globals.current_music = A.mx_lionking_sc04
			
			['Mufasa', 'Simba', 'Scar'].all(enable_prop)

	await get_tree().create_timer(.2).timeout
	Globals.current_music.play()

# What happens when the room changing transition finishes. At this point the room
# is visible.
func _on_room_transition_finished() -> void:
	match Globals.lion_king_branch:
		Globals.Branch.COCO:
			match Globals.lion_king_ending:
				Globals.Ending.COCO_A:
					await G.display("With the help of lemurs, apes, chimpanzees, gorillas, monkeys, baboons, and various collaborators Rafiki became the king of Pride Lands")
					
					await E.queue([
						"Rafiki: All this power feels so good.",
						"Coco: ...",
						"Coco: ......",
						"Rafiki: What should we do that?",
						"Coco: ...",
						"Rafiki: But this lands are enough, we don't need more.",
						"Coco: ...",
						"Rafiki: Oh... I see...",
						"Coco: ...",
						"Rafiki: I will start the preparations... the whole world will be ours.",
					])
					
					# TODO: Mostrar el título de la pelícua modificado?
				Globals.Ending.COCO_B:
					await E.queue([
						G.queue_display("And so, little by little, Rafiki eliminated, one by one, all the animals of the kingdom."),
						G.queue_display("Rafiki told everyone in the kingdom what Mufasa had done."),
						G.queue_display("And Mufasa was lynched and expelled from the kingdom along with his entire family."),
						"Narrator: So, for the very first time in Pride Lands, an election was called to choose a leader through popular vote.",
						"Rafiki: I'm not sure this was a good idea.",
						"Coco: ...",
						"Rafiki: If you say so.",
						"Coco: ...",
						"Rafiki: Hahahaha... that would be great, you know?",
						"Coco: ...",
					])
					
					# TODO: Mostrar el título de la pelícua modificado?
				Globals.Ending.COCO_C:
					await E.queue([
						"Rafiki: Buahahahahahahahahah!!!",
						"Coco: ...",
						"Rafiki: Brbrbrbbrbrbrbrrrbrbrbrbrbrbrb",
						"Coco: ..."
					])
					
					# TODO: Mostrar el título de la pelícua modificado?
			
			# TODO: ¿Guardar algo para que vuelva a iniciar la historia?
			Globals.lion_king_seq += 1
			G.change_channel_requested.emit()
			
			return
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
				# ---------------------------------------------------- Obey scar
				'0':
					$AnimationPlayer.play("simba_leaves")
					await $AnimationPlayer.animation_finished
					
					await C.Scar.say("Kill him!")
					await C.Narrator.say("And with that said, the hyenas went after Simba.")
				
				# --------------------------------------------------- Fight scar
				"1":
					await C.Simba.say("[shake]You won't tell anyone a shit you stupid \
hyenas fucker!!![/shake]")
					
					get_prop("Simba").current_frame = 1
					
					await C.Simba.say("Prepare to die!!!")
					
					get_prop("Scar").current_frame = 2
				
				# --------------------------------------------------------- Deal
				"2":
					get_prop("Simba").current_frame = 2
					
					await E.queue([
						"Simba: Let's make a deal.",
						"Simba: We say it was an accident and I'll let you \
inherit the kingdom.",
						"Scar: I'm starting to like you kid.",
						"Scar: Wait!!! How would I know you won't betray me?",
						"Simba: Uncle, I'm fucking die if I leave the Pride Lands.",
						"Simba: Say nothing, and I'll help you to govern the kingdom.",
					])
					
					Globals.lion_king_ending = Globals.Ending.SIMBA_A
		Globals.Branch.POPOCHIU_KING:
			await E.queue([
				"....",
				"Narrator: A horde of Popochius arrived in Pride Lands using \
all sorts of transportation.",
				"Narrator: And upon encountering the animals, they began to \
give them kisses and hugs."
			])
	
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
