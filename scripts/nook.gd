extends Node2D

var new_scene = global.current_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()


# Handles scene change to world
func _on_nook_to_world_transition_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		new_scene = "world"
 
func _on_nook_to_world_transition_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func change_scene():
	if global.transition_scene: 
		if global.current_scene != new_scene:
			get_tree().change_scene_to_file("res://scenes/%s.tscn" % new_scene)
			global.finish_scene_transition(new_scene)

