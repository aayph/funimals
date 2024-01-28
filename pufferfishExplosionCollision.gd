extends CollisionShape3D

@export var area: Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	area = get_parent_node_3d()
	area.get_parent_node_3d().explode.connect(_enable)




func _enable(happinessIncrease):
	var meeples = area.get_overlapping_bodies()
	for meeple in meeples:
		if (meeple.has_method("change_happiness")):
			meeple.change_happiness(happinessIncrease)
