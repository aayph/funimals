extends CollisionShape3D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent_node_3d().explode.connect(_enable)



func _enable():
	disabled = false
