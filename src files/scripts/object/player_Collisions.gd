extends Node

var player : CharacterBody2D
var collision_area : Area2D
var has_been_hit
var proc_coll = false
var hud_score : CanvasLayer
var main_scene : Node2D
@export var hit_music = AudioStreamMP3
var main_node_sounds : Node2D
var d_bus = "Deaths"


func _ready():
	if is_inside_tree():
		player = get_tree().get_first_node_in_group("player")
		collision_area = get_parent()
		hud_score = get_tree().get_first_node_in_group("Scores")
		main_node_sounds = get_tree().get_first_node_in_group("sound_source")
	has_been_hit = Callable(self, "_on_area_entered")
	collision_area.area_entered.connect(_on_area_entered)
	#add a delay of 0.5 - player can reactively bomb on that time
	
	#creates a hud
	hud_score.player_lives()
	
#then colliding executes the script
func _on_area_entered(area):
	
	#stops overflow
	if(proc_coll == false):
		proc_coll = true
		#updates lives by -1
		GlobalVariables.update_lifes()
		hud_score.player_lives()
		
		#makes you invulnerable + animation
		collision_area.set_deferred("monitoring", false)
		main_node_sounds.play_sound(hit_music, d_bus)
		
		await get_tree().create_timer(1).timeout
		#reverse
		collision_area.set_deferred("monitoring", true)
		proc_coll = false
