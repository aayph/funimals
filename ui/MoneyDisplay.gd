extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	var gameState = get_node("/root/Gamestate")
	gameState.connect("money_changed", onMoneyChanged)

func onMoneyChanged(_money_added: float, total_money: float):
	text = ("%.0f" % total_money) + " Meeps"

