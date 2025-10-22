extends Node3D
const cube_color = "red"
@export var speed = 5.0

func get_cube_color():
	return cube_color
	
func _process(delta):
	global_position.z += speed * delta
	
	if global_position.z > 1.0:
		queue_free()
