@tool
extends "res://addons/popochiu/engine/interfaces/i_audio.gd"

# classes ----
#const AudioCueSound := load("res://addons/popochiu/engine/audio_manager/audio_cue_sound.gd")
#const AudioCueMusic := load("res://addons/popochiu/engine/audio_manager/audio_cue_music.gd")
# ---- classes

# cues ----
var sfx_tv_channel_switch: AudioCueSound = load("res://popochiu/tv_interface/audio/sfx_tv_channel_switch.tres")
var sfx_tv_lp: AudioCueSound = load("res://popochiu/tv_interface/audio/sfx_tv_lp.tres")
var sfx_tv_off: AudioCueSound = load("res://popochiu/tv_interface/audio/sfx_tv_off.tres")
var sfx_tv_on: AudioCueSound = load("res://popochiu/tv_interface/audio/sfx_tv_on.tres")
var sfx_tv_static_lp: AudioCueSound = load("res://popochiu/tv_interface/audio/sfx_tv_static_lp.tres")
var sfx_tv_switch_01: AudioCueSound = load("res://popochiu/tv_interface/audio/sfx_tv_switch_01.tres")
var sfx_tv_switch_02: AudioCueSound = load("res://popochiu/tv_interface/audio/sfx_tv_switch_02.tres")
var sfx_tv_switch_03: AudioCueSound = load("res://popochiu/tv_interface/audio/sfx_tv_switch_03.tres")
var mx_jurassicpark_sc01: AudioCueMusic = load("res://popochiu/rooms/_audio/mx_jurassicpark_sc01.tres")
var mx_lionking_sc01: AudioCueMusic = load("res://popochiu/rooms/_audio/mx_lionking_sc01.tres")
var sfx_matrix_pill: AudioCueSound = load("res://popochiu/rooms/_audio/sfx_matrix_pill.tres")
var sfx_terminator_baby: AudioCueSound = load("res://popochiu/rooms/_audio/sfx_terminator_baby.tres")
var sfx_titanic_jackdeath: AudioCueSound = load("res://popochiu/rooms/_audio/sfx_titanic_jackdeath.tres")
# ---- cues

