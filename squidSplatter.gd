extends RigidBody3D

class_name SquidSplatter

@export var squid: Animal
@export var meeplesHit: Array
# Called when the node enters the scene tree for the first time.
func _ready():
	squid = get_parent_node_3d()
	body_entered.connect(_collision)


func _collision(node):
	squid._increase_meeple_happiness(squid.happinessIncrease, node)
