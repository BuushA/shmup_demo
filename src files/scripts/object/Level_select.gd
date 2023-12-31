extends Button

@export var select_screen : Resource

func _on_pressed():
	if select_screen != null:
		get_tree().change_scene_to_file(select_screen.resource_path)
