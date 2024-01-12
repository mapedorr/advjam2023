@tool
extends PopochiuRoom

const Data := preload('room_jurassic_park_03_state.gd')

var state: Data = load('res://popochiu/rooms/jurassic_park_03/room_jurassic_park_03.tres')
@onready var _animator: AnimationPlayer = $Props/AnimationPlayer

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
# TODO: Overwrite Godot's methods


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# What happens when Popochiu loads the room. At this point the room is in the
# tree but it is not visible
func _on_room_entered() -> void:
	$Characters.y_sort_enabled = false
	$Props.y_sort_enabled = false
	
	match Globals.jurassic_park_branch:
		Globals.Branch.DINOSAURS:
			_animator.play('RESET')
		Globals.Branch.POPOCHIUS:
			_animator.play('Wimpy')


# What happens when the room changing transition finishes. At this point the room
# is visible.
func _on_room_transition_finished() -> void:
	match Globals.jurassic_park_branch:
		Globals.Branch.DINOSAURS:
			var response: PopochiuDialogOption = await D.show_inline_dialog(
				'I will distract the T-rex!',
				[
					'The sexy Dr.Ian throw a bengal next to Robert', 'The sexy Dr.Ian throw a bengal next to the kids'
				]
			)
			
			match response.id:
				'0': 
					_animator.play("Throw_left")
					await  _animator.animation_finished
					
					_animator.play("Eat")
					await C.Narrator.say('F***! Bad luck Robert')
					
					_animator.play('Computer_on')
					var response_2: PopochiuDialogOption = await D.show_inline_dialog(
						'I will try to reboot the system so we can escape on a helicopter',
						[
							'Click, click, click, for reboot', 'Unplug for reboot'
						]
					)
					print(response_2.id)
					match response_2.id:
						'0': 
							await E.queue([
								"Kid: It worked! I'm traumatized but we are save now"])
							Globals.jurassic_park_ending = Globals.Ending.DINO_A
							Globals.progress_movie(Globals.Branch.DINOSAURS)
							
						'1': 
							_animator.play('Computer_off')
							await E.queue([
								"Kid: No idea what I'm doing"])
							Globals.jurassic_park_ending = Globals.Ending.DINO_B
							Globals.progress_movie(Globals.Branch.DINOSAURS)
					
				'1':
					_animator.play("Throw_right")
					await  _animator.animation_finished
					
					_animator.play("Burn")
					await E.queue([
						'DrIan: [shake]No! What I have done?[/shake]',
						'DrIan: Dr. Sattler will no longer find me attractive.'])
					await C.Narrator.say('Dumb but sexy Dr.Ian burned the kids')
					await C.Narrator.say('And now the Park has legal problems')
					
					Globals.jurassic_park_ending = Globals.Ending.DINO_C
					Globals.progress_movie(Globals.Branch.DINOSAURS)
		
		Globals.Branch.POPOCHIUS:
			_animator.play('Wimpy')
			await C.Narrator.say('Popochius were huge but too cute to spook')
			
			_animator.play('Hit')
			await C.Narrator.say('They were so nice that kids were bored in the park')
			
			_animator.play('Choise')
			var response: PopochiuDialogOption = await D.show_inline_dialog(
					'Even feeding them was boring ...',
					[
						'Give an apple to a Popochiu', 'Give a goat to a Popochiu'
					]
				)
				
			match response.id:
				'0':
					_animator.play('Apple')
					await C.Narrator.say('They like apples')
					await E.queue([
						"Popochiu: I loooooove it.",
						"Popochiu: [shake]I loooooove it.[/shake]",
						"Popochiu: I loooooove it."])
					
					await C.Narrator.say('Popochiu kissed the apple')
					await C.Narrator.say('And then Popochiu eated it with his cute little mouth')
					Globals.jurassic_park_ending = Globals.Ending.POPO_A
					Globals.progress_movie(Globals.Branch.POPOCHIUS)
				'1':
					_animator.play('Goat')
					await C.Narrator.say('They like goats')
					await E.queue([
						"Popochiu: I loooooove you.",
						"Popochiu: [shake]I loooooove you.[/shake]",
						"Popochiu: I loooooove you, goat.",
						"Popochiu: I will called you gooooooat"])
					
					await C.Narrator.say('Popochiu kissed the goat')
					await C.Narrator.say('And then Popochiu hug the goat with his cute little arms')
					
					_animator.play('gif')
					await C.Narrator.say("It was not what people wanted to see")
					await C.Narrator.say("They wanted to see blood,")
					await C.Narrator.say("they wanted to see lust,")
					await C.Narrator.say("and above all they wanted midgets")
					
					Globals.jurassic_park_ending = Globals.Ending.POPO_B
					Globals.progress_movie(Globals.Branch.POPOCHIUS)

# What happens before Popochiu unloads the room.
# At this point, the screen is black, processing is disabled and all characters
# have been removed from the $Characters node.
func _on_room_exited() -> void:
	pass


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
# You could put public functions here


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░

