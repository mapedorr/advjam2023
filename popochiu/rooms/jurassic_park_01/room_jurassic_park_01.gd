@tool
extends PopochiuRoom

const Data := preload('room_jurassic_park_01_state.gd')

var state: Data = load('res://popochiu/rooms/jurassic_park_01/room_jurassic_park_01.tres')
@onready var _animator: AnimationPlayer = $Props/AnimationPlayer

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
# TODO: Overwrite Godot's methods


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# What happens when Popochiu loads the room. At this point the room is in the
# tree but it is not visible
func _on_room_entered() -> void:
	$Props.y_sort_enabled = false
	await get_tree().create_timer(.2).timeout
	A.mx_jurassicpark_sc01.play()


# What happens when the room changing transition finishes. At this point the room
# is visible.
func _on_room_transition_finished() -> void:
	_animator.play('01')
	await  _animator.animation_finished
	E.queue(['Narrator[3]: A hundred million years ago...'])
	
	_animator.play('02')
	await  _animator.animation_finished
	C.Grandpa.show()
	
	var response: PopochiuDialogOption = await D.show_inline_dialog(
		'A damned mosquito bit...',
		[
			'a Dinosaur', 'a Popochiu'
		]
	)
	
	var actor = 'Popochiu' if response.id == '1' else 'Dinosaur'
	$Props.get_node(actor).show()
	C.Grandpa.play('01_up')
	await C.Grandpa.say(response.text)
	
	
	match response.id:
		'0':
			Globals.jurassic_park_branch = Globals.Branch.DINOSAURS
		'1':
			Globals.jurassic_park_branch = Globals.Branch.POPOCHIUS
	
	Globals.jurassic_park_seq += 1
	G.change_channel_requested.emit()



# What happens before Popochiu unloads the room.
# At this point, the screen is black, processing is disabled and all characters
# have been removed from the $Characters node.
func _on_room_exited() -> void:
	A.mx_jurassicpark_sc01.stop()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
# You could put public functions here


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
# You could put private functions here
