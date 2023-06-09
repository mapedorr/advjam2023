@tool
extends PopochiuRoom

const Data := preload('room_lion_king_05_state.gd')

var state: Data = load('res://popochiu/rooms/lion_king_05/room_lion_king_05.tres')


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
			get_prop('Simba').enable()
			
			if Globals.lion_king_ending == Globals.Ending.SIMBA_A:
				Globals.current_music = A.mx_lionking_sc05a
				
				get_prop('SimbaEnding5a').enable()
			else:
				Globals.current_music = A.mx_lionking_sc05b
		
		Globals.Branch.POPOCHIU_KING:
			Globals.current_music = A.mx_lionking_sc06_popochiu
			
			get_prop('Popochius').enable()


# What happens when the room changing transition finishes. At this point the room
# is visible.
func _on_room_transition_finished() -> void:
	Globals.current_music.play()
	
	match Globals.lion_king_branch:
		Globals.Branch.SIMBA:
			if Globals.lion_king_ending == Globals.Ending.SIMBA_A:
				await E.queue([
					G.queue_display("Combined, Scar's ambition and Simba's \
intelligence initiated plans for domination over unknown lands."),
					"Mufasa: This is great.",
					"Mufasa: Look at our mighty hyena army.",
					"Simba: Yes, sire.",
					"Simba: The elephant command has reached its destination, \
and they are surrounding the enemy.",
					"Mufasa: Excellent. Everything is going according to plan.",
					"Mufasa: Soon we will take control of Whispering Wastelands."
				])
				
				# TODO: Mostrar el título de la pelícua modificado?
				
				# TODO: ¿Guardar algo para que vuelva a iniciar la historia?
				Globals.lion_king_seq += 2 # Para saltarse el acto 6
				G.change_channel_requested.emit()
				
				return
			else:
				await G.display("Simba, nearly dying, was rescued by Timon and \
Pumba, who taught him to be humble and eat scraps from the ground.")
				
				$AnimationPlayer.play("simba_growth")
				
				await E.queue([
					"Narrator: Simba grew up and became stronger.",
					"Narrator: And one day, Nala came in search of him.",
					"Narrator: She told him about the decline of the kingdom \
at the hands of Scar.",
					"Narrator: not without engaging in sexual relations \
multiple times.",
					"Narrator: They even involved Timon and Pumba.",
				])
				
				await G.display("After more sex and drugs, Simba decides to \
return to Pride Lands to confront Scar.")
		Globals.Branch.POPOCHIU_KING:
			await G.display("Despite the Popochius being all about love, \
Mufasa began to worry about the future of the kingdom.")
			
			await E.queue([
				"Mufasa: We can't abandon hunting altogether just to show \
affection to all of ya.",
				"Mufasa: Look at young Simba, he barely has the will to get up.",
				"PopochiuKing: ...",
				"PopochiuKing: I don't know. We're fine, aren't we, Simba?",
				"Simba: I want another hug.",
				"Mufasa: Cursed good-for-nothing son."
			])
			
			var response: PopochiuDialogOption = await D.show_inline_dialog(
				"How will this mess be resolved?",
				[
					"Popochius take control",
					"Help each other",
					"Mufasa starts eating Popochius",
				]
			)
			
			match response.id:
				'0':
					await E.queue([
						"PopochiuKing: Ok ok ok, dad Mufasa...",
						"PopochiuKing: I'll talk with my epatius about this.",
						"PopochiuKing: You'll see that when we set our little \
minds to it, we can be very hardworking.",
						"Simba[2]: What do I have to do to get a damn hug?"
					])
					
					Globals.lion_king_ending = Globals.Ending.POPOCHIU_KING_A
				'1':
					await E.queue([
						"PopochiuKing: I guess you're right...",
						"PopochiuKing: The kingdom has declined a bit since our arrival.",
						"Mufasa: Don't tell me.",
						"PopochiuKing: I promise that we will work together \
to make everyone proud again of the Pride Lands.",
					])
					
					Globals.lion_king_ending = Globals.Ending.POPOCHIU_KING_B
				'2':
					await E.queue([
						"Mufasa: You know what?",
						"PopochiuKing: What?",
						"Mufasa: [shake]FUCK YOU ALL!!![/shake]",
						"Mufasa: I'm going to start a Popochius diet",
						"PopochiuKing[1]: Wait! What!?"
					])
					
					Globals.lion_king_ending = Globals.Ending.POPOCHIU_KING_C
	
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
