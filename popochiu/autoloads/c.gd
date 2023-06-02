@tool
extends "res://addons/popochiu/engine/interfaces/i_character.gd"

# classes ----
const PCRafiki := preload('res://popochiu/characters/rafiki/character_rafiki.gd')
const PCCoco := preload('res://popochiu/characters/coco/character_coco.gd')
const PCSimba := preload('res://popochiu/characters/simba/character_simba.gd')
const PCPopochiuKing := preload('res://popochiu/characters/popochiu_king/character_popochiu_king.gd')
# ---- classes

# nodes ----
var Rafiki: PCRafiki : get = get_Rafiki
var Coco: PCCoco : get = get_Coco
var Simba: PCSimba : get = get_Simba
var PopochiuKing: PCPopochiuKing : get = get_PopochiuKing
# ---- nodes

# functions ----
func get_Rafiki() -> PCRafiki: return super.get_runtime_character('Rafiki')
func get_Coco() -> PCCoco: return super.get_runtime_character('Coco')
func get_Simba() -> PCSimba: return super.get_runtime_character('Simba')
func get_PopochiuKing() -> PCPopochiuKing: return super.get_runtime_character('PopochiuKing')
# ---- functions

