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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func onClick():
	gameState = get_node("/root/Gamestate")
	var factory = SpawnerBuilderFactory.new(spawnerPreview, spawner)
	gameState.activateBuildMode.emit(factory)
	
func onMoneyChanged(money_added:float, total_money: float):
	updateIsEnabled()
	
func updateIsEnabled():
	disabled = gameState.Money < gameState.SpawnerCosts[spawnerId]
