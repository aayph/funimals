extends TextureButton

var floorSpawnerPreview: PackedScene = load("res://assets/gameplay/FloorSpawnerPreview.tscn")
var floorSpawner: PackedScene = load("res://assets/gameplay/FloorSpawner.tscn")
var buildMenu: Node

# Called when the node enters the scene tree for the first time.
func _ready():#
	pressed.connect(self.onClick)
	buildMenu = get_node("..")
	pass # Replace with function body.

func onClick():
	buildMenu.activateBuildMode.emit(floorSpawnerPreview.instantiate(), floorSpawner)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
