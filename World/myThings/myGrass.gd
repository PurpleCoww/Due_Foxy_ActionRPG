extends Node2D


# preload once and share the resource (injection)
const GrassEffect = preload("res://Effects/myGrassEffect.tscn") # Capital G is the actual scene


func create_grass_effect():
	# var GrassEffect = load("res://Effects/myGrassEffect.tscn")
	var grassEffect = GrassEffect.instance() # lowercase g is the path scene or instance or node
	# var world = get_tree().current_scene # get the current root node of the current scene
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position


func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free() # Destroy the grass
