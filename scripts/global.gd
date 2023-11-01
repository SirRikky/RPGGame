
extends Node

#Is the palyer attacking?
var player_current_attack = false

#Player location information
var current_scene = "world"
var transition_scene = false

var player_start_position = [432,404]
var left_world_exit = [0,0]
var right_world_exit = [0,0]
var bottom_world_exit = [0,0]

func finish_scene_transition(new_scene):
	if transition_scene:
		print(current_scene)
		transition_scene = false
		if current_scene != new_scene:
			current_scene = new_scene
			print(current_scene)
		
