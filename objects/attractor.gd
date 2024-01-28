extends Node3D
class_name Attractor

@export var base_strength: float = 1.0
@export var happiness_influence: float = 0.0
@export var max_distance: float = 20.0
@export var distance_influence: float = 0.0

func get_attraction_strength(_position: Vector3, happiness: float = 0.0) -> float:
	var strength := base_strength
	strength += happiness_influence * happiness
	var distance = global_position.distance_to(_position)
	if max_distance >= 0.0:
		if distance >= max_distance:
			return 0.0
		strength += (1.0 - distance / max_distance) * distance_influence
	return strength
