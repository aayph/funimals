extends CharacterBody3D
class_name Meeple

var happiness: float

func change_happiness(happiness_change: float) -> float:
	happiness += happiness_change
	happiness = clamp(happiness, -1.0, 1.0)
	return happiness

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity.x = 1.0
	move_and_slide()
