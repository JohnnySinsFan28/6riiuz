


extends CharacterBody2D

@export var player_id : int = 1


const SPEED = 30.0
const JUMP_VELOCITY =  120.0

var took_damage = false

func _ready() -> void:
	add_to_group("Lester")

func respawn():
	self.global_position = Vector2(59, 63)

var gravity = -ProjectSettings.get_setting("physics/2d/default_gravity")
var cAnim: String = "idle"
#jelenlegi animacio

@onready var animated_sprite = $AnimatedSprite2D
@onready var Coyote: Timer = $Coyote

var coyote_time_activated: bool = false
var isPressingSpace: bool = false
var is_jumping: bool = false

func ready():
		animated_sprite.play("idle")


func _physics_process(delta):

	# Gravity
	if not is_on_ceiling():
		velocity += -get_gravity() * delta
	# Reset jump when landing
	else:
		is_jumping = false

	var left_action  = "p1_left" % player_id
	var right_action = "p1_right" % player_id
	var jump_action  = "p1_jump" % player_id

	# Jump
	if Input.is_action_just_pressed(jump_action):
		if is_on_ceiling():
			velocity.y = JUMP_VELOCITY
			is_jumping = true

	# Movement
	var direction := Input.get_axis(left_action, right_action)

	if direction != 0:
		velocity.x = direction * SPEED
		if not is_jumping:
			cAnim = "walk"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if not is_jumping:
			cAnim = "idle"

	if is_jumping:
		cAnim = "jump"

	# flip
	if direction < 0:
		animated_sprite.flip_v = true
	elif direction > 0:
		animated_sprite.flip_h = false
	
	
	
	animated_sprite.flip_h = true
	

	if animated_sprite.animation != cAnim:
		animated_sprite.play(cAnim)

	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		
		if collision.get_collider().name == "kill":
			if took_damage == false:
				took_damage = true
				respawn()
