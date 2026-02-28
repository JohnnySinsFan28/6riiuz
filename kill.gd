extends Area2D

func _on_body_entered(body):
	if body.name == "Molly" or body.name == "Lester":
		body.respawn()
