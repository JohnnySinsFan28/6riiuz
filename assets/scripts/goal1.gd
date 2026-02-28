extends Area2D


func _on_area_2d_body_entered(body: Area2D) -> void:
	if body .is_in_group("Lester"):
		LevelManagger.current_level +=1
		LevelManagger.unlock_level(LevelManagger.current_level)
		var level_to_load: String = LevelManagger._load_level(LevelManagger.current_level)
		if level_to_load == "":
			return
		get_tree().call_deferred("change_schene_to_file", level_to_load,)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
