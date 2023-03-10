extends KinematicBody

###################-VARIABLES-####################

# Camera
export(float) var mouse_sensitivity = 8.0
export(NodePath) var head_path = "Head"
export(NodePath) var cam_path = "Head/Camera"
export(float) var FOV = 80.0
var mouse_axis := Vector2()
onready var head: Spatial = get_node(head_path)
onready var cam: Camera = get_node(cam_path)
onready var aim = $Head/aimer
# Move
var velocity := Vector3()
var direction := Vector3()
var move_axis := Vector2()
var snap := Vector3()
var sprint_enabled := true
var sprinting := false
var coyoteTime = 0
var coyoteMax = 18
var jumping = false

var tabbed = false

var lookedAt = false
var lookPos2D = 0
var lookAt = false
var target
var retPos = Vector2()
# Walk
const FLOOR_MAX_ANGLE: float = deg2rad(46.0)
export(float) var gravity = 30.0
export(int) var walk_speed = 10
export(int) var sprint_speed = 16
export(int) var acceleration = 8
export(int) var deacceleration = 10
export(float, 0.0, 1.0, 0.05) var air_control = 0.3
export(int) var jump_height = 10
var _speed: int
var _is_sprinting_input := false
var _is_jumping_input := false
#Push
export(float) var push = 100

enum states {MOVING, UNDERWATER, INVENTORY,}

var state = states.MOVING

var mural_in_range: Spatial = null

onready var advisor = $advisorScene

##################################################

# Called when the node enters the scene tree
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	cam.fov = FOV
	
	BackgroundMusic.play(1)

func waterIn():
	state = states.UNDERWATER
	

func toggle_water():
	if state == states.MOVING:
		state = states.UNDERWATER
	elif state == states.UNDERWATER:
		state = states.MOVING
		
func toggle_waterview():
	$watereffect.visible = !$watereffect.visible

func change_state():
	if state == states.MOVING:
		state = states.INVENTORY
	elif state == states.INVENTORY:
		state = states.MOVING


# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("tab"):
		tabbed = !tabbed
		if tabbed:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.is_action_just_pressed("interact") and mural_in_range != null:
		mural_in_range.discover()

	move_axis.x = Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward")
	move_axis.y = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if Input.is_action_pressed("move_sprint"):
		_is_sprinting_input = true
		
#	if Input.is_action_just_pressed("mouse_left"):
#		if lookedAt:
#			target.queue_free()

func _physics_process(delta: float) -> void:
	if aim.is_colliding():
		target = aim.get_collider().get_parent()
		if target.is_in_group("interactable"):
			var lookPos = target.get_global_transform().origin
			if !lookedAt:
				#have happen once
				lookedAt = true
	else:
		lookedAt = false
	
	if state == states.MOVING:
		walk(delta)
	if state == states.UNDERWATER:
		water(delta)

func on_command_list():
	print("got em")

# Called when there is an input event
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_axis = event.relative
		camera_rotation()
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event is InputEventKey and event.pressed and event.scancode == KEY_ESCAPE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func water(delta: float) -> void:
	direction_input_water()
	snap = Vector3.ZERO
	sprint(delta)
	accelerate(delta)
	velocity = move_and_slide_with_snap(velocity, snap, Vector3.UP, true, 4, FLOOR_MAX_ANGLE,false)

func walk(delta: float) -> void:
	direction_input()
	if Input.is_action_just_pressed("move_jump"):
		_is_jumping_input = true
	if is_on_floor():
		jumping = false
		coyoteTime = 0
		snap = -get_floor_normal() - get_floor_velocity() * delta
		
		# Workaround for sliding down after jump on slope
		if velocity.y < 0:
			velocity.y = 0
		
		jump()
	else:
		if !jumping:
			if coyoteTime < coyoteMax:
				coyoteTime += 1
				jump()
		# Workaround for 'vertical bump' when going off platform
		if snap != Vector3.ZERO && velocity.y != 0:
			velocity.y = 0
		
		snap = Vector3.ZERO
		
		velocity.y -= gravity * delta
	
	sprint(delta)
	
	accelerate(delta)


	velocity = move_and_slide_with_snap(velocity, snap, Vector3.UP, true, 4, FLOOR_MAX_ANGLE,false)
	_is_jumping_input = false
	_is_sprinting_input = false
	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("bodies"):
			collision.collider.apply_central_impulse(-collision.normal * push)

func camera_rotation() -> void:
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return
	if mouse_axis.length() > 0:
		var horizontal: float = -mouse_axis.x * (mouse_sensitivity / 100)
		var vertical: float = -mouse_axis.y * (mouse_sensitivity / 100)
		
		mouse_axis = Vector2()
		
		rotate_y(deg2rad(horizontal))
		head.rotate_x(deg2rad(vertical))
		
		# Clamp mouse rotation
		var temp_rot: Vector3 = head.rotation_degrees
		temp_rot.x = clamp(temp_rot.x, -90, 90)
		head.rotation_degrees = temp_rot

func direction_input_water() -> void:
	direction = Vector3()
	var aim: Basis = head.global_transform.basis
	if move_axis.x >= 0.5:
		direction = -aim.z
	if move_axis.x <= -0.5:
		direction = aim.z
	if move_axis.y <= 0.5:
		direction -= aim.x
	if move_axis.y >= -0.5:
		direction += aim.x
	direction = direction.normalized()

func direction_input() -> void:
	direction = Vector3()
	var aim: Basis = get_global_transform().basis
	if move_axis.x >= 0.5:
		direction -= aim.z
	if move_axis.x <= -0.5:
		direction += aim.z
	if move_axis.y <= -0.5:
		direction -= aim.x
	if move_axis.y >= 0.5:
		direction += aim.x
	direction.y = 0
	direction = direction.normalized()


func accelerate(delta: float) -> void:
	# Where would the player go
	var _temp_vel: Vector3 = velocity
	var _temp_accel: float
	var _target: Vector3 = direction * _speed
	
	if state != states.UNDERWATER:
		_temp_vel.y = 0
		
	if direction.dot(_temp_vel) > 0:
		_temp_accel = acceleration
		
	else:
		_temp_accel = deacceleration
	
	if not is_on_floor():
		_temp_accel *= air_control
	
	# Interpolation
	_temp_vel = _temp_vel.linear_interpolate(_target, _temp_accel * delta)
	
	velocity.x = _temp_vel.x
	velocity.z = _temp_vel.z
	if state == states.UNDERWATER:
		velocity.y = _temp_vel.y
	
	# Make too low values zero
	if direction.dot(velocity) == 0:
		var _vel_clamp := 0.01
		if abs(velocity.x) < _vel_clamp:
			velocity.x = 0
		if abs(velocity.z) < _vel_clamp:
			velocity.z = 0
		if state == states.UNDERWATER:
			if abs(velocity.y) < _vel_clamp:
				velocity.y = 0


func jump() -> void:
	if _is_jumping_input:
		jumping = true
		velocity.y = jump_height
		snap = Vector3.ZERO


func sprint(delta: float) -> void:
	if can_sprint():
		_speed = sprint_speed
#		cam.set_fov(lerp(cam.fov, FOV * 1.05, delta * 8))
		sprinting = true
		
	else:
		_speed = walk_speed
#		cam.set_fov(lerp(cam.fov, FOV, delta * 8))
		sprinting = false


func can_sprint() -> bool:
	return (sprint_enabled and _is_sprinting_input)

func approach_mural(mural: Spatial) -> void:
	mural_in_range = mural

func leave_mural() -> void:
	mural_in_range = null
