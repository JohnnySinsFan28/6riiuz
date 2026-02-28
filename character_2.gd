extends CharacterBody2D

@export var player_id : int = 2

const SPEED = 30.0
const JUMP_VELOCITY = -450.0

var took_damage = false

func _ready() -> void:
	add_to_group("Molly")
	animated_sprite.play("idle")

func respawn():
	self.global_position = Vector2(66, 460)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var cAnim: String = "idle"
#jelenlegi animacio

@onready var animated_sprite = $AnimatedSprite2D
@onready var Coyote: Timer = $Coyote

var coyote_time_activated: bool = false
var isPressingSpace: bool = false
var is_jumping: bool = false

	


func _physics_process(delta):



	#gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	#reset jump when landing
	else:
		is_jumping = false

	var left_action  = "p2_left" % player_id
	var right_action = "p2_right" % player_id
	var jump_action  = "p2_jump" % player_id
	var dust: Node2D

	#jump
	if Input.is_action_just_pressed(jump_action):
		if is_on_floor():
			for i in range(10):
				dust = preload("res://dust.tscn").instantiate()
				self.get_parent().add_child(dust)
				dust.global_position = self.global_position+Vector2(0, 20)
				var rng = RandomNumberGenerator.new()
				var randX = rng.randi_range (-15, 15);
				var randY = rng.randi_range (-5, 5);
				
				dust.global_position = Vector2(global_position.x+randX,global_position.y+randY );
			velocity.y = JUMP_VELOCITY
			is_jumping = true
	
	#movement
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

	#flip
	if direction < 0:
		animated_sprite.flip_v = false
	elif direction > 0:
		animated_sprite.flip_h = true
	
	
	animated_sprite.flip_h = false

	#if animated_sprite.animation != cAnim:
	
	animated_sprite.play(cAnim)
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		
		if collision.get_collider().name == "kill":
			if took_damage == false:
				took_damage = true
				respawn()
