extends Node3D
@onready var timer = $'Timer'
var beet_red = preload("res://CubicCubes_Red.tscn")
var beet_blue = preload("res://CubicCubes_Blue.tscn")

func _ready():
	_reset_timer()

func _reset_timer():
	timer.wait_time = randf_range(0.5, 2.0)
	timer.start()


func _on_timer_timeout():
	_spawn_cube()
	_reset_timer()
	
func _spawn_cube():
	var next_cube
	if randf() > 0.5:
		next_cube = beet_red.instantiate()
	else:
		next_cube = beet_blue.instantiate()
	
	var spawn_x = randf_range(-1.0, 2.0)
	var spawn_y = randf_range(-2.0, 2.0)
	var spawn_z = -10.0
	
	add_child(next_cube)
	next_cube.global_position = Vector3(spawn_x, spawn_y, spawn_z)
