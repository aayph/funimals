extends Animal

signal splatter()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(10)
	body_entered.connect(_collide)



func _collide(node):
	get_node("Mesh").visible = false
	splatter.emit()
