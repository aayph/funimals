extends TextureButton

@export var spawnerPreview: PackedScene
@export var spawner: PackedScene

var spawnerId: String
var gameState: Gamestate
@export var label: Label
@export var price: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	spawnerId = spawner.get_state().get_node_name(0)
	gameState = get_node("/root/Gamestate")
	gameState.connect("money_changed", onMoneyChanged)
	label.text = spawnerId + " bauen"
	price.text = ("%d" % gameState.SpawnerCosts[spawnerId]) + " Meeps"
	updateIsEnabled()

func onClick():
	gameState = get_node("/root/Gamestate")
	var factory = SpawnerBuilderFactory.new(spawnerPreview, spawner)
	gameState.activateBuildMode.emit(factory)

func onMoneyChanged(_money_added:float, _total_money: float):
	updateIsEnabled()

func updateIsEnabled():
	disabled = gameState.Money < gameState.SpawnerCosts[spawnerId]
