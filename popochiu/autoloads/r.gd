@tool
extends "res://addons/popochiu/engine/interfaces/i_room.gd"

# classes ----
const PRTests := preload('res://popochiu/rooms/tests/room_tests.gd')
const PRJurassic := preload('res://popochiu/rooms/jurassic/room_jurassic.gd')
const PRLionKing01 := preload('res://popochiu/rooms/lion_king_01/room_lion_king_01.gd')
const PRLionKing02 := preload('res://popochiu/rooms/lion_king_02/room_lion_king_02.gd')
const PRLionKing03 := preload('res://popochiu/rooms/lion_king_03/room_lion_king_03.gd')
const PRMainMenu := preload('res://popochiu/rooms/main_menu/room_main_menu.gd')
const PRTitanic := preload('res://popochiu/rooms/titanic/room_titanic.gd')
const PRTerminator2 := preload('res://popochiu/rooms/terminator_2/room_terminator_2.gd')
const PRMatrix := preload('res://popochiu/rooms/matrix/room_matrix.gd')
# ---- classes

# nodes ----
var Tests: PRTests : get = get_Tests
var Jurassic: PRJurassic : get = get_Jurassic
var LionKing01: PRLionKing01 : get = get_LionKing01
var LionKing02: PRLionKing02 : get = get_LionKing02
var LionKing03: PRLionKing03 : get = get_LionKing03
var MainMenu: PRMainMenu : get = get_MainMenu
var Titanic: PRTitanic : get = get_Titanic
var Terminator2: PRTerminator2 : get = get_Terminator2
var Matrix: PRMatrix : get = get_Matrix
# ---- nodes

# functions ----
func get_Tests() -> PRTests: return super.get_runtime_room('Tests')
func get_Jurassic() -> PRJurassic: return super.get_runtime_room('Jurassic')
func get_LionKing01() -> PRLionKing01: return super.get_runtime_room('LionKing01')
func get_LionKing02() -> PRLionKing02: return super.get_runtime_room('LionKing02')
func get_LionKing03() -> PRLionKing03: return super.get_runtime_room('LionKing03')
func get_MainMenu() -> PRMainMenu: return super.get_runtime_room('MainMenu')
func get_Titanic() -> PRTitanic: return super.get_runtime_room('Titanic')
func get_Terminator2() -> PRTerminator2: return super.get_runtime_room('Terminator2')
func get_Matrix() -> PRMatrix: return super.get_runtime_room('Matrix')
# ---- functions

