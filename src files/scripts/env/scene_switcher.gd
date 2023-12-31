extends Node

var new_scene_path : String
var new_scene : PackedScene
var scene_id : int


#selectable values for each scene 
#only used for export values
enum Scenes {
	MAIN = 1,
	LEVEL_SELECT = 2,
	FIRST_LEVEL = 3,
}

#the file name of the scene without .tscn
var scene_dictionary = {
	1: "main_menu",
	2: "level_select",
	3: "first_level",
}

func switching_scene(id):
	new_scene_path = "res://scenes/level/" + str(scene_dictionary[scene_id]) + ".tscn"
	new_scene = load(new_scene_path)
	#print("putton pressed")
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_packed(new_scene)
	#print("changed")
