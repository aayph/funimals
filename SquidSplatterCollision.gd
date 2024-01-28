extends CollisionShape3D

@export var area: Area3D
@export var squid: Animal
@export var timer: float = 0
var collided: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	area = get_parent_node_3d()
	squid = area.get_parent_node_3d().get_parent_node_3d()
	
func _process(delta):
	timer += delta
	_collision()
	if (timer > 3):
		area.get_parent_node_3d().meeplesHit.clear()
		timer = 0

func _collision():
	var meeples = area.get_overlapping_bodies()
	for meeple in meeples:
		if (meeple.has_method("change_happiness") && area.get_parent_node_3d().meeplesHit.find(meeple) == -1):
			area.get_parent_node_3d().meeplesHit.append(meeple)
			meeple.change_happiness(squid.happinessIncrease) 

	
