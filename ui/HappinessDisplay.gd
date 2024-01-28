extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	var gameState = get_node("/root/Gamestate")
	gameState.connect("total_happiness_changed", onTotalHappinessChanged)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func onTotalHappinessChanged(total_happiness: float):
	text = ("%.1f" % (Gamestate.get_relative_happiness() * 100.0)) + "% / " + ("%.1f" % (Gamestate.get_win_value() * 100.0)) + "% Meepiness "
