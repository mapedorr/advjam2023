extends CanvasLayer

signal transition_finished

@onready var _channel_vfx := [
	$VFX/NTSCBasic,
	$VFX/TV,
	$VFX/Glitch,
]
@onready var _change_vfx := [
	$VFX/Grain,
	$VFX/SimpleGrain,
]


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	_toggle_channel_vfx(false)
	_toggle_change_vfx(false)
	
	G.turned_on.connect(_toggle_channel_vfx.bind(true))
	G.turned_off.connect(_toggle_channel_vfx.bind(false), CONNECT_REFERENCE_COUNTED)
	G.turned_off.connect(_toggle_change_vfx.bind(false), CONNECT_REFERENCE_COUNTED)
	
	$Label.hide()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
func play_room_change_start() -> void:
	Globals.channel_change_started.emit()
	
	$Label.hide()
	_toggle_channel_vfx(false)
	_toggle_change_vfx(true)
	A.sfx_tv_channel_switch.play()
	
	A.sfx_tv_static_lp.play()
	await get_tree().create_timer(0.1).timeout
	
	transition_finished.emit()
	A.sfx_tv_lp.stop()


func play_room_change_end() -> void:
	for ch in Globals.channels:
		if R.current.script_name.find(ch) > -1:
			$Label.text = 'CH - %s' % Globals.channels[ch].code
			break
	$Label.show()
	
	await get_tree().create_timer(0.3).timeout
	A.sfx_tv_static_lp.stop()
	
	_toggle_channel_vfx(true)
	_toggle_change_vfx(false)
	
	transition_finished.emit()
	Globals.channel_change_finished.emit()
	A.sfx_tv_lp.play()
	
	await get_tree().create_timer(1.5).timeout
	
	if $Label.visible:
		$Label.hide()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _toggle_channel_vfx(is_visible: bool) -> void:
	for n in _channel_vfx:
		(n as Control).visible = is_visible


func _toggle_change_vfx(is_visible: bool) -> void:
	for n in _change_vfx:
		(n as Control).visible = is_visible
