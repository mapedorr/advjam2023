extends Node

enum Branch {
	NONE,
	SIMBA,
	COCO,
	POPOCHIU_KING,
	DINOSAURS,
	POPOCHIUS,
}

var branch_name := '' : get = get_branch_name
var lion_king_seq := 1
var lion_king_branch := 0
var channels := {
	lion_king = {
		scene = 'LionKing',
		code = '123',
		story = true,
	},
	titanic = {
		scene = 'Titanic',
		code = '789',
	},
	terminator_2 = {
		scene = 'Terminator2',
		code = '147',
	},
	jurassic_park = {
		scene = 'Jurassic',
		code = '456',
	},
	matrix = {
		scene = 'Matrix',
		code = '258',
	},
}

var _channels_to_visit := []
var _channel_idx := 0


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ READY ░░░░
func _ready() -> void:
	pass


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
func set_room_branch(room: PopochiuRoom, branch: int) -> void:
	# 
	E.goto_room(room.script_name, false)


func progress_movie(branch: int) -> void:
	match branch:
		Branch.SIMBA, Branch.COCO, Branch.POPOCHIU_KING:
			lion_king_seq += 1
			lion_king_branch = branch
			
			set_room_branch(R.get('LionKing%02d' % lion_king_seq), branch)


func get_branch_name() -> String:
	return str(Branch.keys()[lion_king_branch]).to_pascal_case()


func change_channel(was_off := false) -> void:
	if _channels_to_visit.is_empty():
		_channels_to_visit = channels.keys()
		
	# --- Random channel change ------------------------------------------------
#	var channel_key: String = _channels_to_visit.pick_random()
#	_channels_to_visit.erase(channel_key)
	# ------------------------------------------------ Random channel change ---
	
	# Ordered channel change
	if not was_off:
		_channel_idx = fposmod(_channel_idx + 1, _channels_to_visit.size())
	
	var channel_key: String = _channels_to_visit[_channel_idx]
	
	var channel: Dictionary = channels[channel_key]
	var channel_name: String = channel.scene
	
	if channel.has('story'):
		channel_name = '%s%02d' % [channel.scene, get(channel_key + '_seq')]
	
	E.goto_room(channel_name, !was_off)
