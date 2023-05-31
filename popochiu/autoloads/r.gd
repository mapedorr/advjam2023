@tool
extends "res://addons/popochiu/engine/interfaces/i_room.gd"

# classes ----
const PRTests := preload('res://popochiu/rooms/tests/room_tests.gd')
# ---- classes

# nodes ----
var Tests: PRTests : get = get_Tests
# ---- nodes

# functions ----
func get_Tests() -> PRTests: return super.get_runtime_room('Tests')
# ---- functions

