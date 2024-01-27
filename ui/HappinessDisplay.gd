extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	var gameState = get_node("/root/Gamestate")
	gameState.connect("total_happiness_changed", onTotalHappinessChanged)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func onTotalHappinessChanged(total_happiness: float):
	text = ("%.0f" % abs(total_happiness * 10)) + " Meepiness"
