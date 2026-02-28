extends Node

var current_level: int = 1
var level_unlocked: int = 1
var max_level: int = 5

func unlock_level(level_to_unlock: int) -> void: 
	if level_to_unlock > level_unlocked: 
		level_unlocked = level_to_unlock
		

func _load_level(level_to_load: int) -> String:
	if level_to_load > max_level:
		return "res://assets/schenes/Credits.tscn"
	return str("res://assets/schenes/levels/Map",level_to_load,".tscn")
	
		









# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
