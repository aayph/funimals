extends RigidBody3D

class_name Animal

@export var happinessIncrease: float
@export var life: float

func _ready():
	Gamestate.register_animal(self)

func _decrease_life():
	life -= 1
	if (life == 0):
		Gamestate.unregister_animal(self)
		queue_free()

func _increase_meeple_happiness(value, meeple):

	if (meeple.has_method("change_happiness")):
		meeple.change_happiness(value);
		return true
	return false
