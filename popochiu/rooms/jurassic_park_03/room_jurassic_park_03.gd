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


# What happens when the room changing transition finishes. At this point the room
# is visible.
func _on_room_transition_finished() -> void:
	match Globals.jurassic_park_branch:
		Globals.Branch.DINOSAURS:
			var response: PopochiuDialogOption = await D.show_inline_dialog(
				'Quick!, I will distract the T-rex towards my right.',
				[
					'No, to your left', 'Yes, do it now!'
				]
			)
			
			match response.id:
				'0': 
					_animator.play("Throw_left")
					await  _animator.animation_finished
					
					_animator.play("Eat")
					await C.Narrator.say('F***! bad luck Robert')
					
					_animator.play('Computer_on')
					var response_2: PopochiuDialogOption = await D.show_inline_dialog(
						'I can do it!',
						[
							'Explore for the answer', 'Unplug for reboot'
						]
					)
					match response.id:
						'0': 
							Globals.jurassic_park_ending = Globals.Ending.DINO_A
							Globals.progress_movie(Globals.Branch.DINOSAURS)
							
						'1': 
							_animator.play('Computer_off')
							await C.Narrator.say('No idea what I am doing')
							Globals.jurassic_park_ending = Globals.Ending.DINO_B
							Globals.progress_movie(Globals.Branch.DINOSAURS)
					
				'1':
					_animator.play("Throw_right")
					await  _animator.animation_finished
					
					_animator.play("Burn")
					await C.Narrator.say('The kids are dead now')
					
					Globals.jurassic_park_ending = Globals.Ending.DINO_C
					Globals.progress_movie(Globals.Branch.DINOSAURS)
		
		Globals.Branch.POPOCHIUS:
			_animator.play('Wimpy')
			await C.Narrator.say('These Popochius were huge but extremely wimpy')
			
			_animator.play('gif')
			await C.Narrator.say('Ah Ah Ah! All words are admitted!')
			
			_animator.play('Hit')
			await C.Narrator.say('They were so nice they were boring')
			
			_animator.play('Choise')
			var response: PopochiuDialogOption = await D.show_inline_dialog(
					'Even feeding them was boring.',
					[
						'give an apple', 'give a goat'
					]
				)
				
			match response.id:
				'0':
					_animator.play('Apple')
					await C.Narrator.say('They like apples')
					Globals.jurassic_park_ending = Globals.Ending.POPO_A
					Globals.progress_movie(Globals.Branch.POPOCHIUS)
				'1':
					_animator.play('Goat')
					await C.Narrator.say('They like goats')
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

