@tool
extends "res://addons/popochiu/engine/interfaces/i_room.gd"

# classes ----
const PRTests := preload('res://popochiu/rooms/tests/room_tests.gd')
const PRJurassic := preload('res://popochiu/rooms/jurassic/room_jurassic.gd')
# ---- classes

# nodes ----
var Tests: PRTests : get = get_Tests
var Jurassic: PRJurassic : get = get_Jurassic
# ---- nodes

# functions ----
func get_Tests() -> PRTests: return super.get_runtime_room('Tests')
func get_Jurassic() -> PRJurassic: return super.get_runtime_room('Jurassic')
# ---- functions

