extends Button

var level: int = 1
var is_unlocked: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = get_index()+1
	text = str(level)
	is_unlocked = level <= LevelManagger.level_unlocked
	modulate.a = 1.0 if is_unlocked else 0.5 
	
func _pressed() -> void:
	if is_unlocked: 
		LevelManagger.current_level = level
		get_tree().call_deferred("change_scene_to_file",LevelManagger._load_level(level) )


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
