extends Spawner
class_name FloorSpawner

# Called when the node enters the scene tree for the first time.
func _ready():
	spawnOrigin = transform.origin + transform.basis.y
