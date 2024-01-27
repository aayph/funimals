extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Gamestate.change_state.connect(_on_state_change)

func _on_state_change(new_state: Gamestate.StateChange):
	match new_state:
		Gamestate.StateChange.MAIN_MENU:
			queue_free()
