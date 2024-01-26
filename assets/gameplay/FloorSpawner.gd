extends Node3D

@export var direction: Vector2 = Vector2.ZERO
@export var interval: float = 0
@export var spawns: int = 0
@export var enemy: PackedScene
@export var spawnRoot: Node

var spawnTimer: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawnTimer += delta
	if (spawnTimer > interval && spawns > 0):
		spawnTimer -= interval
		spawns -= 1
		var enemyInstance: Node = enemy.instantiate()
		enemyInstance.transform = Transform3D(transform).translated(Vector3.UP)
		enemyInstance.set("linear_velocity", Vector3(direction.x, 1, direction.y))
		spawnRoot.add_child(enemyInstance)
	pass
