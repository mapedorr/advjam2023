@tool
extends "res://addons/popochiu/engine/interfaces/i_character.gd"

# classes ----
const PCRafiki := preload('res://popochiu/characters/rafiki/character_rafiki.gd')
const PCCoco := preload('res://popochiu/characters/coco/character_coco.gd')
const PCSimba := preload('res://popochiu/characters/simba/character_simba.gd')
const PCPopochiuKing := preload('res://popochiu/characters/popochiu_king/character_popochiu_king.gd')
const PCMufasa := preload('res://popochiu/characters/mufasa/character_mufasa.gd')
const PCScar := preload('res://popochiu/characters/scar/character_scar.gd')
const PCNarrator := preload('res://popochiu/characters/narrator/character_narrator.gd')
const PCGrandpa := preload('res://popochiu/characters/grandpa/character_grandpa.gd')
const PCJudge := preload('res://popochiu/characters/judge/character_judge.gd')
const PCAttorney := preload('res://popochiu/characters/attorney/character_attorney.gd')
const PCKid := preload('res://popochiu/characters/kid/character_kid.gd')
# ---- classes

# nodes ----
var Rafiki: PCRafiki : get = get_Rafiki
var Coco: PCCoco : get = get_Coco
var Simba: PCSimba : get = get_Simba
var PopochiuKing: PCPopochiuKing : get = get_PopochiuKing
var Mufasa: PCMufasa : get = get_Mufasa
var Scar: PCScar : get = get_Scar
var Narrator: PCNarrator : get = get_Narrator
var Grandpa: PCGrandpa : get = get_Grandpa
var Judge: PCJudge : get = get_Judge
var Attorney: PCAttorney : get = get_Attorney
var Kid: PCKid : get = get_Kid
# ---- nodes

# functions ----
func get_Rafiki() -> PCRafiki: return super.get_runtime_character('Rafiki')
func get_Coco() -> PCCoco: return super.get_runtime_character('Coco')
func get_Simba() -> PCSimba: return super.get_runtime_character('Simba')
func get_PopochiuKing() -> PCPopochiuKing: return super.get_runtime_character('PopochiuKing')
func get_Mufasa() -> PCMufasa: return super.get_runtime_character('Mufasa')
func get_Scar() -> PCScar: return super.get_runtime_character('Scar')
func get_Narrator() -> PCNarrator: return super.get_runtime_character('Narrator')
func get_Grandpa() -> PCGrandpa: return super.get_runtime_character('Grandpa')
func get_Judge() -> PCJudge: return super.get_runtime_character('Judge')
func get_Attorney() -> PCAttorney: return super.get_runtime_character('Attorney')
func get_Kid() -> PCKid: return super.get_runtime_character('Kid')
# ---- functions

