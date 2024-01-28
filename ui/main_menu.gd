extends Node

@export var LevelList: Array[LevelData]
@export var LevelLabel: Label

var selected_level: LevelData

func _ready() -> void:
	set_level(LevelList[0])
	Gamestate.change_state.connect(_on_state_change)


func set_level(level: LevelData):
	selected_level = level
	LevelLabel.text = level.LevelName

func _on_next():
	var index = LevelList.find(selected_level) + 1
	if index >= LevelList.size():
		set_level(LevelList[0])
	else:
		set_level(LevelList[index])

func _on_prev():
	var index = LevelList.find(selected_level) - 1
	if index < 0:
		set_level(LevelList[LevelList.size() - 1])
	else:
		set_level(LevelList[index])

func _on_start():
	if Gamestate.current_state != Gamestate.StateChange.MAIN_MENU:
		return
	var level = selected_level.LevelScene.instantiate()
	get_parent().add_child(level)
	Gamestate._start_level(selected_level)

func _on_state_change(new_state: Gamestate.StateChange):
	match new_state:
		Gamestate.StateChange.MAIN_MENU:
			enable_menu()
		Gamestate.StateChange.LEVEL_START:
			disable_menu()

func disable_menu():
	self.visible = false

func enable_menu():
	self.visible = true
