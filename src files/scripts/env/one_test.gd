extends Node2D
class_name Level

@export var start_event : Node
var HUD_score 
var character_start_pos : Vector2
@export var player_lives : int
@export var player_bombs : int

@export var events_path_value : int
@onready var audio = $Audio_manager
#manages the start event
func _ready():
	#I pause the game after a failed attempt
	get_tree().paused = false
	if start_event == null:
		start_event = $"EVENT - start"
	if is_inside_tree():
		HUD_score = get_tree().get_first_node_in_group("Scores")
	HUD_score.update_score()
	
	#after reloading it doesn't have a character
	if $Character != null:
		character_start_pos = $Character.position
	else:
		$Character.position = character_start_pos
	#hardcoded path values in each event
	
	start_event.activate(events_path_value - 1)
	new_game()
	
	
#func _physics_process(delta):
#	if enemy != null:
#		calculating_path(delta)
#		print(follow_path.position)
#		enemy.position = follow_path.position

#func calculating_path(delta):
#	follow_path.progress_ratio += delta * float_speed
func game_over():
	get_tree().paused = true
	HUD_score.hud_game_over()
	
func victory():
	HUD_score.hud_victory()

#updates all game values
func new_game():
	HUD_score.hud_new_game()
	GlobalVariables.player_life = player_lives
	HUD_score.player_lives()
	GlobalVariables.Score = 0
	HUD_score.update_score()
	GlobalVariables.bomb_count = player_bombs
	HUD_score.update_bomb_count()
	
func play_sound(sound_mp3 : AudioStreamMP3, bus : String):
	audio.stream = sound_mp3
	audio.set_bus(bus)
	audio.play()
	
