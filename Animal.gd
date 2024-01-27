extends RigidBody3D

class_name Animal

var happinessIncrease: float 
var life: float


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _decrease_life():
	life -= 1
	if (life == 0):
		queue_free()


func _increase_meeple_happiness(happinessIncrease, meeple):
	
	if (meeple.has_method("change_happiness")):
		meeple.change_happiness(happinessIncrease);
		return true
	return false
