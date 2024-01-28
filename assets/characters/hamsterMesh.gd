extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var hamster = get_parent_node_3d()
	hamster.change_facing.connect(_change_facing)
	pass # Replace with function body.



func _change_facing(facingVector):
	#print(basis.x.angle_to(facingVector))
	rotate(Vector3(0,1,0), basis.x.angle_to(facingVector))

