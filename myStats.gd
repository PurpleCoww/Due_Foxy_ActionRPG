extends Node


export(int) var max_health = 1
onready var health = max_health setget set_health

# When youre node talk to one up in the hierarchy use SIGNALS
signal no_health

#func _process():
#	if health <= 0:
#		emit_signal("no_health")


func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")
