extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_collision)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _collision(node):
	get_parent_node_3d()._increase_meeple_happiness(get_parent_node_3d().happinessIncrease, node)
