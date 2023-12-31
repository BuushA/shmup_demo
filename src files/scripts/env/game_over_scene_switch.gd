extends "res://scripts/env/scene_switcher.gd"



func _on_return_to_main_pressed():
	scene_id = Scenes.MAIN
	switching_scene(scene_id)
	
	

func _on_restart_pressed():
	scene_id = Scenes.LEVEL_SELECT
	switching_scene(scene_id)


func game_victory():
	game_over()
	$"back to game".show()
	
	
	
func _on_back_to_game_pressed():
	hide_buttons()
	$"back to game".hide()

func game_over():
	$Return_to_main.show()
	$Restart.show()


func hide_buttons():
	$Return_to_main.hide()
	$Restart.hide()



