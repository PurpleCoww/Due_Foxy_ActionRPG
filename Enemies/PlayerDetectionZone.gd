extends Area2D


var player = null


# If player does not equal null then it returns true (you can see the player)
func can_see_player():
	return player != null

# Inside the detection
func _on_PlayerDetectionZone_body_entered(body):
	player = body

# Outside the detection
func _on_PlayerDetectionZone_body_exited(body):
	player = null
