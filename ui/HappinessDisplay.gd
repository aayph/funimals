extends PanelContainer

@export var label: Label
@export var progress: Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	var gameState = get_node("/root/Gamestate")
	gameState.connect("total_happiness_changed", onTotalHappinessChanged)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func onTotalHappinessChanged(_total_happiness: float):
	label.text = ("%.1f" % (Gamestate.get_relative_happiness() * 100.0)) + " Meepiness "
	progress.custom_minimum_size = Vector2(size.x * Gamestate.get_relative_happiness() / Gamestate.get_win_value(), 0)
