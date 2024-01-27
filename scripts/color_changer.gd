extends Node
@export var mesh: MeshInstance3D

func set_happiness(new_happiness: float):
	mesh.set_instance_shader_parameter("Happiness", new_happiness)
