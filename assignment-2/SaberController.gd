extends XRController3D

@export var raycast_length = 1.0
@export var beet_saber: String = "red"
var grabbed_object = null
var collided_area = null
var saber_on = false

var last_pos = Vector3.ZERO
var velocity = Vector3.ZERO
@onready var cube_hit = CollisionShape3D
@onready var cube_destroyed = $AudioStreamPlayer3D



func _ready():
	last_pos = global_position
	$"BeetSaber".visible = false
	
	#if $Area3D.get_child_count()>0:
		#cube_hit = $Area3D.get_child(0)
	cube_destroyed.stream=load("res://explode.mp3")

func _process(delta):
	if grabbed_object:
		grabbed_object.global_position = global_position
		
	velocity = (global_position - last_pos) / delta
	last_pos = global_position
	
	if saber_on:
		$"BeetSaber".visible = true
		
	else:
		$"BeetSaber".visible = false
	
func _physics_process(delta):
	var space_state = get_world_3d().direct_space_state
	var origin = global_position
	var dir = global_basis.z * -1
	var end = origin + (dir * raycast_length)
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	
	$"BeetSaber".points[0] = origin
	$"BeetSaber".points[1] = end

	
	if result:
		$"BeetSaber".points[1] = result.position
	

func _on_area_3d_area_entered(area):
	
	
	var cube_collision = area.get_parent()
	
	print(cube_collision.name)
	#if cube_collision.has_method("get_cube_color") and cube_collision.get_cube_color() == beet_saber:
	cube_destroyed.play()
	cube_collision.queue_free()


func _on_area_3d_area_exited(area):
	collided_area = null


func _on_button_pressed(name):
	if name == 'grip_click':
		if collided_area:
			grabbed_object = collided_area
	if name == 'ax_button':
		saber_on = not saber_on
	


func _on_button_released(name):
	if name == 'grip_click':
		grabbed_object = null
