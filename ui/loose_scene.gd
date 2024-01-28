extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Gamestate.change_state.connect(_on_state_change)

func _on_state_change(new_state: Gamestate.StateChange):
	if new_state == Gamestate.StateChange.LEVEL_WIN:
		enable_menu()
	else:
		disable_menu()


func disable_menu():
	self.visible = false

func enable_menu():
	self.visible = true


func _on_return_pressed():
	disable_menu()
	Gamestate.return_mainmenu()
