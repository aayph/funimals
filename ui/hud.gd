extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Gamestate.change_state.connect(_on_state_change)

func _on_state_change(new_state: Gamestate.StateChange):
	match new_state:
		Gamestate.StateChange.MAIN_MENU:
			disable_menu()
		Gamestate.StateChange.LEVEL_START:
			enable_menu()

func disable_menu():
	self.visible = false

func enable_menu():
	self.visible = true


func _on_quit_pressed():
	Gamestate.return_mainmenu()
