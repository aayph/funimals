class_name SpawnController
extends Node

const floorCollisionMask: int = 2
const directionSelectionCollisionMask: int = 4
var gameState: Gamestate
var level: Node3D
var camera: Camera3D
var directionIndicator: Line2D
var buildModeActive: bool = false
var selectDirectionModeActive: bool = false
var currentSpawnerPreview: Node3D
var currentSpawnerFactory: SpawnerBuilderFactory
var directionStartPoint: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	gameState = get_node("/root/Gamestate")
	gameState.connect("activateBuildMode", onBuildModeActivated)
	if (level != null):
		camera = level.get_node("Camera")
	directionIndicator = get_node("DirectionIndicator")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if (event is InputEventMouseMotion && buildModeActive && currentSpawnerPreview != null):
		if (selectDirectionModeActive):
			directionIndicator.clear_points()
			directionIndicator.add_point(directionStartPoint)
			directionIndicator.add_point(event.position)
		else:
			var hitPosition = getHitPosition(floorCollisionMask)
			if (hitPosition != null):
				currentSpawnerPreview.transform.origin = hitPosition
	elif (event is InputEventMouseButton):
		if (event.button_index == MOUSE_BUTTON_RIGHT && event.pressed && buildModeActive):
			buildModeActive = false
			selectDirectionModeActive = false
			directionIndicator.hide()
			clearPreview()
		elif (event.button_index == MOUSE_BUTTON_LEFT && event.pressed && buildModeActive):
			print_debug(selectDirectionModeActive)
			if (!selectDirectionModeActive):
				selectDirectionModeActive = true
				directionIndicator.show()
				directionIndicator.clear_points()
				directionStartPoint = event.position
			else:
				buildModeActive = false
				selectDirectionModeActive = false
				if (currentSpawnerFactory != null && level != null):
					directionIndicator.hide()
					
					var hitPosition = getHitPosition(floorCollisionMask)
					var direction: Vector2 = Vector2(1, 0)
					
					if (hitPosition != null):
						var diff = hitPosition - currentSpawnerPreview.transform.origin
						direction = Vector2(diff.x, diff.z).normalized()
					
					gameState.add_money(-gameState.SpawnerCosts[currentSpawnerFactory.getSpawnerId()])
					var newSpawner: Spawner = currentSpawnerFactory.createSpawner(direction, level)
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

func getHitPosition(mask: int):
	if (camera != null):
		var mouse_pos: Vector2 = get_viewport().get_mouse_position()
		var ray_origin: Vector3 = camera.project_ray_origin(mouse_pos)
		var ray_direction: Vector3 = camera.project_ray_normal(mouse_pos) * 1000.0
		
		var space_state: PhysicsDirectSpaceState3D = level.get_world_3d().direct_space_state
		var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(ray_origin, ray_direction, mask)
		query.exclude = [currentSpawnerPreview]
		var hit: Dictionary = space_state.intersect_ray(query)
		if (hit.size() > 0):
			return hit.position
			
	return null

