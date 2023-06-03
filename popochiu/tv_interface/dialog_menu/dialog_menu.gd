extends Control

signal shown

const PopochiuDialogOption :=\
preload('res://addons/popochiu/engine/objects/dialog/popochiu_dialog_option.gd')

@export var option_scene: PackedScene

var current_options := []

var _max_height := 0.0
var _visible_options := 0

@onready var panel: PanelContainer = $Panel
@onready var options_container: VBoxContainer = $Panel/ScrollContainer/OptionsContainer


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	D.inline_dialog_requested.connect(_create_inline_options)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _create_inline_options(opts: Array) -> void:
	var tmp_opts := []
	for idx in opts.size():
		var new_opt: PopochiuDialogOption = PopochiuDialogOption.new()
		
		new_opt.id = str(idx)
		new_opt.text = opts[idx]
		
		tmp_opts.append(new_opt)

	_create_options(tmp_opts, true)


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


func _on_option_clicked(opt: PopochiuDialogOption) -> void:
	hide()
	D.option_selected.emit(opt)
