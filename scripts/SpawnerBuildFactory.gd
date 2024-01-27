class_name SpawnerBuilderFactory
extends Object

var preview: PackedScene
var spawner: PackedScene

func _init(preview: PackedScene, spawner: PackedScene):
	self.preview = preview
	self.spawner = spawner
	
func createPreview() -> Node3D:
	return preview.instantiate()

func createSpawner(direction: Vector2, spawnRoot: Node3D) -> Spawner:
	var newSpawner: Spawner = spawner.instantiate()
	newSpawner.direction = direction
	newSpawner.spawnRoot = spawnRoot
	return newSpawner

func getSpawnerId() -> String:
	return spawner.get_state().get_node_name(0)

