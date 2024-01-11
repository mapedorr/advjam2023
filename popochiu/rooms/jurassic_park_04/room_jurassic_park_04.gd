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
					await C.Narrator.say('They left the park')
					await C.Narrator.say("And then they made Jurassic Park II. But I didn't see that movie")
					
					Globals.restart_jurassic_park()
					G.change_channel_requested.emit()
					
				Globals.Ending.DINO_B:
					_animator.play('gif')
					await C.Narrator.say("Ah Ah Ah! You didn't say the magic word!")
					await C.Narrator.say("It didn't work as planned so all of them died")
					
					Globals.restart_jurassic_park()
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
					
					Globals.restart_jurassic_park()
					G.change_channel_requested.emit()
		
		Globals.Branch.POPOCHIUS:
			match Globals.jurassic_park_ending:
				Globals.Ending.POPO_A:
					_animator.play('Friends')
					await C.Narrator.say('They loved each other')
					await E.queue([
						"Popochiu: I loooooove you.",
						"Popochiu: I loooooove you.",
						"Popochiu: I loooooove you,"])
					
					_animator.play('Lovers')
					await C.Narrator.say('They loved each other so much that ...')
					
					Globals.restart_jurassic_park()
					G.change_channel_requested.emit()
				
				Globals.Ending.POPO_B:
					_animator.play('closed')
					await C.Narrator.say('Nobody wanted to visit the park')
					await C.Narrator.say('And Popochius lived happily with the goats')
					
					Globals.restart_jurassic_park()
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
		'My client Mr. John Hammond? has been accused',
		'But he has been wrongly accused. He is innocent',
		'Sure. But before we proceed I would like to request you to move the date for the hearing',
		'Sure my lord. I have already dispatched one copy to the concerned entity',
		'Thank you my lord for your consideration',
		'Yes my lord. This is a murder case',
		'I object my lord. They just had a trivial dinosaur issue',
		'No! That’s absolutely not true',
		'Oh please! John Hammond does not belongs in prison'
		
	]
	
	var judge_lines := [
		'I belive your case was going to be going to trial this Monday but the following Monday',
		'Well I will decide that',
		'For that you need to submit a written request to me and to the opponent’s lawyer',
		'After receiving the approval from the lawyer I will be decide upon the next date of hearing',
		'Does the lawyer have something to say on the behalf of his client?',
		'You have the constitutional right to be a dumbass',
		"Okay, I'm going to refer you to the district attorney's office",
		'Order! Order! Both the lawyers settle down and maintain the decorum of court'
	] 
	
	var line = judge_lines if actor == 'Judge' else lawyer_lines
	line.shuffle()
	dialog = line[0]
	return dialog
