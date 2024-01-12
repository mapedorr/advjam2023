extends Control

signal shown
signal panel_resized(new_size)

const PopochiuDialogOption :=\
preload('res://addons/popochiu/engine/objects/dialog/popochiu_dialog_option.gd')

@export var option_scene: PackedScene

var current_options := []

var _max_height := 0.0
var _visible_options := 0
var _focus_idx := -1
var _focus_btn: Button

@onready var panel: PanelContainer = $Panel
@onready var options_container: VBoxContainer = $Panel/ScrollContainer/OptionsContainer


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	D.inline_dialog_requested.connect(_create_inline_options)
	D.option_change_requested.connect(focus_next_option)
	D.option_selection_requested.connect(select_focused_option)
	D.dialog_closed.connect(_close_dialog)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
func remove_options(_dialog: PopochiuDialog = null) -> void:
	_visible_options = 0
	
	if not current_options.is_empty():
		current_options.clear()

		for btn in options_container.get_children():
			(btn as Button).queue_free()
	
	await get_tree().process_frame

	panel.size.y = 0
	options_container.size.y = 0


func show_options() -> void:
	show()
	shown.emit()


func focus_next_option() -> void:
	_focus_idx = fposmod(_focus_idx + 1, current_options.size())
	_focus_btn = options_container.get_child(_focus_idx) as Button
	
	if _focus_btn == null: return
	_focus_btn.grab_focus()


func select_focused_option() -> void:
	if not _focus_btn: return
	
	G.title_setted.emit()
	_focus_btn.pressed.emit()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _create_inline_options(opts: Array) -> void:
	var tmp_opts := []
	for idx in opts.size():
		var new_opt: PopochiuDialogOption = PopochiuDialogOption.new()
		
		new_opt.id = str(idx)
		new_opt.text = opts[idx]
		
		tmp_opts.append(new_opt)

	await _create_options(tmp_opts, true)
	focus_next_option()


func _create_options(options := [], autoshow := false) -> void:
	remove_options()

	if options.is_empty():
		if not current_options.is_empty():
			show_options()
		return

	current_options = options.duplicate(true)

	for opt in options:
		var btn: Button = option_scene.instantiate() as Button
		var dialog_option: PopochiuDialogOption = opt

		btn.text = dialog_option.text
#		btn.add_theme_color_override('font_color', default)
#		btn.add_theme_color_override('font_hover_color', hover)
		
#		if dialog_option.used and not dialog_option.always_on:
#			btn.add_theme_color_override('font_color', used)
		
		btn.pressed.connect(_on_option_clicked.bind(dialog_option))

		options_container.add_child(btn)

		if dialog_option.disabled or not dialog_option.visible:
			btn.hide()
		else:
			btn.show()
			_visible_options += 1
		
		
		if _max_height == 0.0:
			_max_height = btn.size.y * E.settings.max_dialog_options
			_max_height += E.settings.max_dialog_options - 1

	if autoshow: show_options()
	
	await get_tree().process_frame

	panel.custom_minimum_size.y = min(options_container.size.y, _max_height)
	
	panel_resized.emit(panel.custom_minimum_size)


func _on_option_clicked(opt: PopochiuDialogOption) -> void:
	_focus_idx = -1
	_focus_btn = null
	
	hide()
	D.option_selected.emit(opt)


func _close_dialog(remove := true) -> void:
	if not visible: return
	
	if remove:
		remove_options()
	
	_focus_idx -= 1
	
	G.title_setted.emit()
	hide()
