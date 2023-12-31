extends "res://scripts/env/scene_switcher.gd"



func _on_level_select_pressed():
	scene_id = Scenes.LEVEL_SELECT #enum value from scene_switcher.gd
	
	switching_scene(scene_id) #will switch the scene with the given int value


#I pause the game after a failed attempt
func _ready():
	get_tree().paused = false



