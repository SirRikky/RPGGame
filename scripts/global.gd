extends Node

# Startup information
var first_load_in = true

#Is the palyer attacking?
var player_current_attack = false

#Player location information
var current_scene = "world"
var transition_scene = false

var player_start_position = [397, 391]
var left_world_exit = [17, 505] #Glade
var right_world_exit = [1516, 802] 
var bottom_world_exit = [1009, 1235]
var last_position = player_start_position

func finish_scene_transition(new_scene):
	if transition_scene:
		transition_scene = false
		if current_scene != new_scene:
			current_scene = new_scene
		
