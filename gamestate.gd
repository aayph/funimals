extends Node
class_name State

enum StateChange {MAIN_MENU, LEVEL_START, LEVEL_WIN, LEVEL_LOOSE}

var Money: float
var MoneyPerHappiness: float = 20.0
var Data: LevelData
var MeepleList: Array[Meeple]
var _total_happiness: float
var current_state: StateChange = StateChange.MAIN_MENU
var SpawnerCosts: Dictionary = {
	"BasicSpawner": 100,
	"PufferfishSpawner": 400,
	"HamsterSpawner": 50
}

signal money_changed(money_added:float, total_money: float)
signal total_happiness_changed(total_happiness:float)
signal meeple_happiness_changed(meeple: Meeple, value: float, affect_money: bool)
signal change_state(active_scene: StateChange)
signal activateBuildMode(factory: SpawnerBuilderFactory)

func _ready() -> void:
	meeple_happiness_changed.connect(_on_meeple_happiness_changed)
	Gamestate.change_state.connect(_on_state_change)

func _on_state_change(active_scene: StateChange):
	current_state = active_scene

func set_money(new_money: float):
	var old_money := Money
	Money = new_money
	money_changed.emit(Money - old_money, Money)

func add_money(add_value: float):
	Money += add_value
	money_changed.emit(add_value, Money)

func _on_meeple_happiness_changed(_meeple: Meeple, value: float, affect_money: bool):
	if affect_money and value > 0.0:
		add_money(value * MoneyPerHappiness)
	_total_happiness += value
	total_happiness_changed.emit(_total_happiness)
	if _total_happiness / MeepleList.size() > Data.WinValue:
		win_level()
	elif _total_happiness / MeepleList.size() < Data.DeathValue:
		loose_level()

func _start_level(data: LevelData):
	Data = data
	MeepleList.clear()
	_total_happiness = 0.0
	total_happiness_changed.emit(_total_happiness)
	set_money(data.StartingMoney)
	change_state.emit(StateChange.LEVEL_START)

func get_relative_happiness() -> float:
	return _total_happiness / MeepleList.size()

func get_win_value() -> float:
	return Data.WinValue

func get_loose_value() -> float:
	return Data.DeathValue

func loose_level():
	change_state.emit(StateChange.LEVEL_LOOSE)
	return_mainmenu()

func win_level():
	change_state.emit(StateChange.LEVEL_WIN)

func return_mainmenu():
	change_state.emit(StateChange.MAIN_MENU)

func register_meeple(meeple: Meeple):
	MeepleList.append(meeple)
	_total_happiness += meeple.happiness
	total_happiness_changed.emit(_total_happiness)
