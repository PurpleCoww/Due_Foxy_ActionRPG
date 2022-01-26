extends Area2D

#const HitEffect = preload("res://Effects/myHitEffect.tscn")

# Decido se far vedere l'animazione hit
# Imposto default a true e poi lo levo dall'inspector
export(bool) var show_hit = true

var invincible = false setget set_invincible

signal invincibility_started
signal invincibility_ended

onready var timer = $Timer
onready var collisionShape = $CollisionShape2D

func create_hit_effect():
		var HitEffect = load("res://Effects/myHitEffect.tscn")
		var effect = HitEffect.instance()
		var main = get_tree().current_scene
		main.add_child(effect)
		effect.global_position = global_position # - Vector2(0, 8) # si può fare con Offset

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")

func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)
	
func _on_Timer_timeout():
	self.invincible = false

# Fix for player overlaping with bat
func _on_Hurtbox_invincibility_started():
	collisionShape.set_deferred("disabled", true)
	
func _on_Hurtbox_invincibility_ended():
	collisionShape.disabled = false
