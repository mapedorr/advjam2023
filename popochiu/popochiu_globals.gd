extends Node

signal channel_change_started
signal channel_change_finished
signal intro_triggered
signal intro_finished
signal reality_said(msg)

enum Branch {
	NONE,
	SIMBA,
	COCO,
	POPOCHIU_KING,
	DINOSAURS,
	POPOCHIUS,
}
enum Ending {
	COCO_A,
	COCO_B,
	COCO_C,
	SIMBA_A, # 5a
	SIMBA_B, # 7a
	SIMBA_C, # 7b
	POPOCHIU_KING_A,
	POPOCHIU_KING_B,
	POPOCHIU_KING_C,
	DINO_A,
	DINO_B,
	DINO_C,
	POPO_A,
	POPO_B
}

var branch_name := '' : get = get_branch_name
var channels := {
	"123" = {
		scene = 'LionKing',
		code = '123',
		story = true,
	},
	"789" = {
		scene = "",
		code = '789',
	},
	"147" = {
		scene = "",
		code = '147',
	},
	"456" = {
		scene = 'JurassicPark',
		code = '456',
		story = true,
	},
	"258" = {
		scene = "",
		code = '258',
	},
}
var lion_king_seq := 1
var lion_king_branch := 0
var lion_king_ending := -1
var jurassic_park_seq := 1
var jurassic_park_branch := 0
var jurassic_park_ending := -1
var current_music : AudioCueMusic = null

var _channels_to_visit := []
var _channel_idx := 0
var _shown_simple_movies := []

@onready var simple_movies := [
	R.Terminator2, R.Matrix, R.Titanic, R.Joker, R.Arrival, R.KillBill, R.LOTR1
].map(func (room: PopochiuRoom): return room.script_name)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ READY ░░░░
func _ready() -> void:
	pass


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
func set_room_branch(room: PopochiuRoom, branch: int) -> void:
	E.goto_room(room.script_name, false)


func progress_movie(branch: int) -> void:
	match branch:
		Branch.SIMBA, Branch.COCO, Branch.POPOCHIU_KING:
			lion_king_seq += 1
			lion_king_branch = branch
			
			set_room_branch(R.get('LionKing%02d' % lion_king_seq), branch)
		
		Branch.DINOSAURS, Branch.POPOCHIUS:
			jurassic_park_seq += 1
			jurassic_park_branch = branch
			
			set_room_branch(R.get('JurassicPark%02d' % jurassic_park_seq), branch)


func get_branch_name() -> String:
	return str(Branch.keys()[lion_king_branch]).to_pascal_case()


func change_channel(dir : int, was_off := false) -> void:
	if _channels_to_visit.is_empty():
		_channels_to_visit = channels.keys()
	
	# --- Random channel change ------------------------------------------------
#	var channel_key: String = _channels_to_visit.pick_random()
#	_channels_to_visit.erase(channel_key)
	# ------------------------------------------------ Random channel change ---
	
	# Ordered channel change
	if not was_off:
		_channel_idx = fposmod(_channel_idx + dir, _channels_to_visit.size())
	
	var channel_key: String = _channels_to_visit[_channel_idx]
	var channel: Dictionary = channels[channel_key]
	var channel_name := ""
	
	if (channel.scene as String).is_empty():
		# Elegir una película al azar para más placer
		
		if simple_movies.size() == 1:
			channel_name = simple_movies.pop_front()
			simple_movies = _shown_simple_movies.duplicate()
			_shown_simple_movies.clear()
		else:
			channel_name = simple_movies.pick_random()
			simple_movies.erase(channel_name)
		
		_shown_simple_movies.append(channel_name)
	else:
		channel_name = channel.scene
	
	if channel.has('story'):
		channel_name = '%s%02d' % [
			channel.scene,
			get((channel.scene as String).to_snake_case() + '_seq')
		]
	
	E.goto_room(channel_name, !was_off)


func queue_say_in_reality(msg: String) -> Callable:
	return func () : await say_in_reality(msg)


func say_in_reality(msg: String) -> void:
	reality_said.emit(msg)
	
	await G.continue_clicked


func restart_lion_king() -> void:
	Globals.lion_king_seq = 1
	Globals.lion_king_branch = 0
	Globals.lion_king_ending = -1


func restart_jurassic_park() -> void:
	Globals.jurassic_park_seq = 1
	Globals.jurassic_park_branch = 0
	Globals.jurassic_park_ending = -1
