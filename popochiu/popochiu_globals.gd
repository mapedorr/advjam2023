extends Node

enum Branch {
	SIMBA,
	COCO,
	POPOCHIU_KING
}


func set_room_branch(room: PopochiuRoom, branch: int) -> void:
	room.state.branch = branch
	
	E.goto_room(room.script_name, false)
