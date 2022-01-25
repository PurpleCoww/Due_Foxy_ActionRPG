extends Node2D


func create_grass_effect():
		var GrassEffect = load("res://Effects/myGrassEffect.tscn") # actual scene
		var grassEffect = GrassEffect.instance() # path scene or instance or node
		var world = get_tree().current_scene # get the current root node of the current scene
		world.add_child(grassEffect)
		grassEffect.global_position = global_position
		queue_free()


func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free() # Destroy the grass
