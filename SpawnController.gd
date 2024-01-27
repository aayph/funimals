extends Node

const collisionMaskFloor: int = 2
var level: Node3D
var buildModeActive: bool = false
var currentSpawnerPreview: Node3D
var currentSpawnerFactory: SpawnerBuilderFactory

# Called when the node enters the scene tree for the first time.
func _ready():
	var gameState = get_node("/root/Gamestate")
	gameState.connect("activateBuildMode", onBuildModeActivated)
	level = get_node("Level")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if (event is InputEventMouseMotion && buildModeActive && currentSpawnerPreview != null):
		var camera: Camera3D = level.get_node("Camera")
		if (camera != null):
			var mouse_pos: Vector2 = get_viewport().get_mouse_position()
			var ray_origin: Vector3 = camera.project_ray_origin(mouse_pos)
			var ray_direction: Vector3 = camera.project_ray_normal(mouse_pos) * 1000.0
			
			var space_state: PhysicsDirectSpaceState3D = level.get_world_3d().direct_space_state
			var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(ray_origin, ray_direction, collisionMaskFloor)
			query.exclude = [currentSpawnerPreview]
			var hit: Dictionary = space_state.intersect_ray(query)
			if (hit.size() > 0):
				currentSpawnerPreview.transform.origin = hit.position
	elif (event is InputEventMouseButton):
		if (event.button_index == MOUSE_BUTTON_RIGHT && buildModeActive):
			buildModeActive = false
			clearPreview()
		elif (event.button_index == MOUSE_BUTTON_LEFT && buildModeActive):
			buildModeActive = false
			if (currentSpawnerFactory != null && level != null):
				var newSpawner: Spawner = currentSpawnerFactory.createSpawner(Vector2(-1, -1), level)
				newSpawner.transform = currentSpawnerPreview.transform
				level.add_child(newSpawner)
			clearPreview()
		
func onBuildModeActivated(factory: SpawnerBuilderFactory):
	if (level != null):
		buildModeActive = true
		currentSpawnerFactory = factory
		currentSpawnerPreview = factory.createPreview()
		level.add_child(currentSpawnerPreview)

func clearPreview():
	if (currentSpawnerPreview != null):
		if (level != null):
			level.remove_child(currentSpawnerPreview)
		currentSpawnerPreview.queue_free()
		currentSpawnerPreview = null
