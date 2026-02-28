extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var hasChosenShi: bool = false

func _process(delta: float) -> void:
	if not hasChosenShi:
		show_random_frame("default")
		hasChosenShi = true
	if $AnimatedSprite2D.self_modulate.a>0: $AnimatedSprite2D.self_modulate.a -= 0.01

func show_random_frame(animation:String) -> void:
	animated_sprite_2d.animation = animation
	var frame_count = animated_sprite_2d.sprite_frames.get_frame_count(animated_sprite_2d.animation)
	animated_sprite_2d.frame = randi_range(0, frame_count)
