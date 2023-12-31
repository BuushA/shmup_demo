extends "res://scripts/env/scene_switcher.gd"



func _on_first_pressed():
	scene_id = Scenes.FIRST_LEVEL #enum value from scene_switcher.gd - 3
	switching_scene(scene_id) #change to the first level


func _on_return_pressed():
	scene_id = Scenes.MAIN #int id - 1
	switching_scene(scene_id) #change to main menu
	
	
	
#I pause the game after a failed attempt
func _ready():
	get_tree().paused = false
