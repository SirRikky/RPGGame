extends Node2D

var new_scene = global.current_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	$player.position.x = global.last_position[0]
	$player.position.y = global.last_position[1]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()

# Handles scene change to glade
func _on_world_to_glade_transition_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		new_scene = "glade"
		global.last_position = global.left_world_exit

func _on_world_to_glade_transition_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false


# Handles scene change to nook
func _on_world_to_nook_transition_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		new_scene = "nook"
		global.last_position = global.bottom_world_exit

func _on_world_to_nook_transition_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false



func change_scene():
	if global.transition_scene: 
		if global.current_scene != new_scene:
			get_tree().change_scene_to_file("res://scenes/%s.tscn" % new_scene)
			global.finish_scene_transition(new_scene)



