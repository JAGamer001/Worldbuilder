extends Node3D

@export var normal_speed := 5.0
@export var fast_multiplier := 3.0
@export var slow_multiplier := 0.3
@export var rotate_sensitivity := 0.002
@export var pan_sensitivity := 0.01

@onready var pitch = $Pitch

func get_mouse_scale_factor() -> float:
	var viewport_size = get_viewport().get_visible_rect().size
	return max(viewport_size.x, viewport_size.y) / 1080.0

func _input(event):
	if event is InputEventMouseMotion:
		var mScale = get_mouse_scale_factor()
		
		# rotation
		if Input.is_action_pressed("cam_rotate"):
			rotate_y(-event.relative.x * rotate_sensitivity * mScale)
			pitch.rotation.x -= event.relative.y * rotate_sensitivity * mScale
			pitch.rotation.x = clamp(pitch.rotation.x, deg_to_rad(-89), deg_to_rad(89))
		
		# pan
		if Input.is_action_pressed("cam_pan"):
			var right = global_transform.basis.x
			var up = pitch.global_transform.basis.y
			global_position += (-right * event.relative.x + up * event.relative.y) * pan_sensitivity * mScale


func _process(delta):
	var dir := Vector3.ZERO
	var actual_speed = normal_speed
	
	# speed controls
	if Input.is_action_pressed("cam_fast"):
		actual_speed *= fast_multiplier
	if Input.is_action_pressed("cam_slow"):
		actual_speed *= slow_multiplier
	
	# cam controls
	if Input.is_action_pressed("cam_forward"):
		dir += -global_transform.basis.z
	if Input.is_action_pressed("cam_back"):
		dir += global_transform.basis.z
	if Input.is_action_pressed("cam_left"):
		dir += -global_transform.basis.x
	if Input.is_action_pressed("cam_right"):
		dir += global_transform.basis.x
	if Input.is_action_pressed("cam_up"):
		dir += Vector3.UP
	if Input.is_action_pressed("cam_down"):
		dir += Vector3.DOWN
	
	global_position += dir * actual_speed * delta
