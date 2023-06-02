@tool
extends "res://addons/popochiu/engine/interfaces/i_room.gd"

# classes ----
const PRTests := preload('res://popochiu/rooms/tests/room_tests.gd')
const PRJurassic := preload('res://popochiu/rooms/jurassic/room_jurassic.gd')
const PRLionKing01 := preload('res://popochiu/rooms/lion_king_01/room_lion_king_01.gd')
const PRLionKing02 := preload('res://popochiu/rooms/lion_king_02/room_lion_king_02.gd')
# ---- classes

# nodes ----
var Tests: PRTests : get = get_Tests
var Jurassic: PRJurassic : get = get_Jurassic
var LionKing01: PRLionKing01 : get = get_LionKing01
var LionKing02: PRLionKing02 : get = get_LionKing02
# ---- nodes

# functions ----
func get_Tests() -> PRTests: return super.get_runtime_room('Tests')
func get_Jurassic() -> PRJurassic: return super.get_runtime_room('Jurassic')
func get_LionKing01() -> PRLionKing01: return super.get_runtime_room('LionKing01')
func get_LionKing02() -> PRLionKing02: return super.get_runtime_room('LionKing02')
# ---- functions

