extends Node3D
class_name Spawner

@export var direction: Vector2 = Vector2.ZERO
@export var interval: float = 0
@export var spawns: int = 0
@export var upVelocity: float = 1
@export var forwardVelocity: float = 1
@export var enemy: PackedScene
@export var spawnRoot: Node

var spawnOrigin: Vector3 = Vector3.ZERO
var spawnTimer: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Gamestate.activate_spawner(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawnTimer += delta

	if (spawnTimer > interval && spawns > 0):
		spawnTimer -= interval
		spawns -= 1
		var enemyInstance: Animal = enemy.instantiate()
		enemyInstance.transform.origin = spawnOrigin
		enemyInstance.set(
			"linear_velocity",
			Vector3(
				direction.x * forwardVelocity,
				upVelocity,
				direction.y * forwardVelocity
			)
		)
		spawnRoot.add_child(enemyInstance)
		Gamestate.register_animal(enemyInstance)

	if (spawns <= 0):
		Gamestate.deactivate_spawner(self)
		queue_free()
