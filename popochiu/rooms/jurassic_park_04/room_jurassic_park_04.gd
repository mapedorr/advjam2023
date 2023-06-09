@tool
extends PopochiuRoom

const Data := preload('room_jurassic_park_04_state.gd')

var state: Data = load('res://popochiu/rooms/jurassic_park_04/room_jurassic_park_04.tres')
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
			match Globals.jurassic_park_ending:
				Globals.Ending.DINO_A:
					_animator.play('Run')
					await C.Narrator.say('We are saved, stupid park!')
					
					G.change_channel_requested.emit()
					
				Globals.Ending.DINO_B:
					_animator.play('gif')
					await C.Narrator.say('Ah Ah Ah! you didnt say the magic word!')
					
					G.change_channel_requested.emit()
					
				Globals.Ending.DINO_C:
					_animator.play("Judge")
					await C.Judge.say(random_line("Judge"))
					await C.Attorney.say(random_line("Lawyer"))
					await C.Judge.say(random_line("Judge"))
					await C.Attorney.say(random_line("Lawyer"))
					await C.Judge.say(random_line("Judge"))
					await C.Judge.say(random_line("Judge"))
					await C.Attorney.say(random_line("Lawyer"))
					await C.Attorney.say(random_line("Lawyer"))
					await C.Judge.say(random_line("Judge"))
					await C.Attorney.say(random_line("Lawyer"))
					await C.Attorney.say(random_line("Lawyer"))
					await C.Judge.say(random_line("Judge"))
					await C.Attorney.say(random_line("Lawyer"))
					await C.Judge.say(random_line("Judge"))
					
					G.change_channel_requested.emit()
		
		Globals.Branch.DINOSAURS:
			match Globals.jurassic_park_ending:
				Globals.Ending.POPO_A:
					_animator.play('Friends')
					await C.Narrator.say('They loved each other')
					
					_animator.play('Lovers')
					await C.Narrator.say('They loved each other so much that ...')
					
					G.change_channel_requested.emit()
				
				Globals.Ending.POPO_B:
					_animator.play('closed')
					await C.Narrator.say('Nobody wanted to visit the park')
					
					G.change_channel_requested.emit()
		


# What happens before Popochiu unloads the room.
# At this point, the screen is black, processing is disabled and all characters
# have been removed from the $Characters node.
func _on_room_exited() -> void:
	pass


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
# You could put public functions here


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func random_line(actor : String) -> String:
	var dialog := ''
	var lawyer_lines := [
		'We have a matter lined up for the dowry case',
		'My client has been accused of demanding dowry',
		'But he has been wrongly accused. He is innocent',
		'Sure. But before we proceed I would like to request you to move the date for the hearing',
		'Sure my lord. I have already dispatched one copy to the concerned entity',
		'Thank you my lord for your consideration',
		'Yes my lord. My client was harassed for the dowry by hir in-laws since the very next day of her marriage',
		'I object my lord. They just had a verbal fight on a trivial domestic issue',
		'No! That’s absolutely not true',
		'Oh please! Your client is an unruly man and he belongs in prison'
		
	]
	
	var judge_lines := [
		'Yes go ahead. Present your case',
		'Well that I will decide that',
		'For that you need to submit a written request to me and to the opponent’s lawyer',
		'After receiving the approval from the plaintiff’s lawyer I will be decide upon the next date of hearing',
		'Does the plaintiff’s lawyer have something to say on the behalf of her client?',
		'Order! Order! Both the lawyers settle down and maintain the decorum of court'
	] 
	
	var line = judge_lines if actor == 'Judge' else lawyer_lines
	line.shuffle()
	dialog = line[0]
	return dialog
