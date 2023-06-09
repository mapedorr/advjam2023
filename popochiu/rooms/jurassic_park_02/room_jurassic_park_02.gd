@tool
extends PopochiuRoom

const Data := preload('room_jurassic_park_02_state.gd')

var state: Data = load('res://popochiu/rooms/jurassic_park_02/room_jurassic_park_02.tres')
@onready var _animator: AnimationPlayer = $Props/AnimationPlayer

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
# TODO: Overwrite Godot's methods


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# What happens when Popochiu loads the room. At this point the room is in the
# tree but it is not visible
func _on_room_entered() -> void:
	$Props.y_sort_enabled = false


# What happens when the room changing transition finishes. At this point the room
# is visible.
func _on_room_transition_finished() -> void:
	_animator.play('01')
	
	match Globals.jurassic_park_branch:
		Globals.Branch.POPOCHIUS:
			await C.Narrator.say('The DNA of Popochiu was used')
			
			_animator.play('Egg_2')
			await C.Narrator.say('To create a stupid park')
			
			_animator.play('Run_2')
			await C.Narrator.say('But one day they almost escaped')
			
		Globals.Branch.DINOSAURS:
			await C.Narrator.say('The DNA of Dinosaur was used')
			
			_animator.play('Egg_1')
			await C.Narrator.say('To create a stupid park')
			
			_animator.play('Run_1')
			await C.Narrator.say('But one day they all ran away')
	
	_animator.play('End')
	await C.Narrator.say('They created chaos and destruction')
	
	Globals.jurassic_park_seq += 1
	G.change_channel_requested.emit()

# What happens before Popochiu unloads the room.
# At this point, the screen is black, processing is disabled and all characters
# have been removed from the $Characters node.
func _on_room_exited() -> void:
	pass


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
# You could put public functions here


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
# You could put private functions here
