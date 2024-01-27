extends TextureButton

@export var spawnerPreview: PackedScene
@export var spawner: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(onClick)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func onClick():
	var gameState = get_node("/root/Gamestate")
	var factory = SpawnerBuilderFactory.new(spawnerPreview, spawner)
	gameState.activateBuildMode.emit(factory)
	pass
