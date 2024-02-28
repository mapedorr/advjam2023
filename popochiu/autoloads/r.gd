@tool
extends "res://addons/popochiu/engine/interfaces/i_room.gd"

# classes ----
const PRTests := preload('res://popochiu/rooms/tests/room_tests.gd')
const PRLionKing01 := preload('res://popochiu/rooms/lion_king_01/room_lion_king_01.gd')
const PRLionKing02 := preload('res://popochiu/rooms/lion_king_02/room_lion_king_02.gd')
const PRLionKing03 := preload('res://popochiu/rooms/lion_king_03/room_lion_king_03.gd')
const PRMainMenu := preload('res://popochiu/rooms/main_menu/room_main_menu.gd')
const PRTitanic := preload('res://popochiu/rooms/titanic/room_titanic.gd')
const PRTerminator2 := preload('res://popochiu/rooms/terminator_2/room_terminator_2.gd')
const PRMatrix := preload('res://popochiu/rooms/matrix/room_matrix.gd')
const PRLionKing04 := preload('res://popochiu/rooms/lion_king_04/room_lion_king_04.gd')
const PRJurassicPark01 := preload('res://popochiu/rooms/jurassic_park_01/room_jurassic_park_01.gd')
const PRJurassicPark02 := preload('res://popochiu/rooms/jurassic_park_02/room_jurassic_park_02.gd')
const PRLionKing05 := preload('res://popochiu/rooms/lion_king_05/room_lion_king_05.gd')
const PRLionKing06 := preload('res://popochiu/rooms/lion_king_06/room_lion_king_06.gd')
const PRLionKing07 := preload('res://popochiu/rooms/lion_king_07/room_lion_king_07.gd')
const PRJurassicPark03 := preload('res://popochiu/rooms/jurassic_park_03/room_jurassic_park_03.gd')
const PRJurassicPark04 := preload('res://popochiu/rooms/jurassic_park_04/room_jurassic_park_04.gd')
const PRJoker := preload('res://popochiu/rooms/joker/room_joker.gd')
const PRArrival := preload('res://popochiu/rooms/arrival/room_arrival.gd')
const PRKillBill := preload('res://popochiu/rooms/kill_bill/room_kill_bill.gd')
const PRLOTR1 := preload('res://popochiu/rooms/lotr_1/room_lotr_1.gd')
# ---- classes

# nodes ----
var Tests: PRTests : get = get_Tests
var LionKing01: PRLionKing01 : get = get_LionKing01
var LionKing02: PRLionKing02 : get = get_LionKing02
var LionKing03: PRLionKing03 : get = get_LionKing03
var MainMenu: PRMainMenu : get = get_MainMenu
var Titanic: PRTitanic : get = get_Titanic
var Terminator2: PRTerminator2 : get = get_Terminator2
var Matrix: PRMatrix : get = get_Matrix
var LionKing04: PRLionKing04 : get = get_LionKing04
var JurassicPark01: PRJurassicPark01 : get = get_JurassicPark01
var JurassicPark02: PRJurassicPark02 : get = get_JurassicPark02
var LionKing05: PRLionKing05 : get = get_LionKing05
var LionKing06: PRLionKing06 : get = get_LionKing06
var LionKing07: PRLionKing07 : get = get_LionKing07
var JurassicPark03: PRJurassicPark03 : get = get_JurassicPark03
var JurassicPark04: PRJurassicPark04 : get = get_JurassicPark04
var Joker: PRJoker : get = get_Joker
var Arrival: PRArrival : get = get_Arrival
var KillBill: PRKillBill : get = get_KillBill
var LOTR1: PRLOTR1 : get = get_LOTR1
# ---- nodes

# functions ----
func get_Tests() -> PRTests: return super.get_runtime_room('Tests')
func get_LionKing01() -> PRLionKing01: return super.get_runtime_room('LionKing01')
func get_LionKing02() -> PRLionKing02: return super.get_runtime_room('LionKing02')
func get_LionKing03() -> PRLionKing03: return super.get_runtime_room('LionKing03')
func get_MainMenu() -> PRMainMenu: return super.get_runtime_room('MainMenu')
func get_Titanic() -> PRTitanic: return super.get_runtime_room('Titanic')
func get_Terminator2() -> PRTerminator2: return super.get_runtime_room('Terminator2')
func get_Matrix() -> PRMatrix: return super.get_runtime_room('Matrix')
func get_LionKing04() -> PRLionKing04: return super.get_runtime_room('LionKing04')
func get_JurassicPark01() -> PRJurassicPark01: return super.get_runtime_room('JurassicPark01')
func get_JurassicPark02() -> PRJurassicPark02: return super.get_runtime_room('JurassicPark02')
func get_LionKing05() -> PRLionKing05: return super.get_runtime_room('LionKing05')
func get_LionKing06() -> PRLionKing06: return super.get_runtime_room('LionKing06')
func get_LionKing07() -> PRLionKing07: return super.get_runtime_room('LionKing07')
func get_JurassicPark03() -> PRJurassicPark03: return super.get_runtime_room('JurassicPark03')
func get_JurassicPark04() -> PRJurassicPark04: return super.get_runtime_room('JurassicPark04')
func get_Joker() -> PRJoker: return super.get_runtime_room('Joker')
func get_Arrival() -> PRArrival: return super.get_runtime_room('Arrival')
func get_KillBill() -> PRKillBill: return super.get_runtime_room('KillBill')
func get_LOTR1() -> PRLOTR1: return super.get_runtime_room('LOTR1')
# ---- functions

