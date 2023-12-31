extends Node

var player : CharacterBody2D
var player_collision : CollisionShape2D
@export var wait_time = 1
@export var bomb_count = 3
var HUD_score

func _ready():
	#get the player + it's hitbox
	if is_inside_tree():
		player = get_tree().get_first_node_in_group("player")
		player_collision = player.get_node("Hurtbox")
		HUD_score = get_tree().get_first_node_in_group("Scores")
		#bomb_count at the start
		HUD_score.update_bomb_count()
	
func _process(delta):
	#make the player immortal and destroy bullets
	if Input.is_action_just_pressed("bomb") && bomb_count > 0: #press b to activate
		player_collision.disabled = true
		get_tree().call_group("bullet", "queue_free")
		get_tree().call_group("Enemy", "queue_free")
		bomb_count -= 1
		#can't go bellow zero
			
		#Updates the UI about the bomb count
		GlobalVariables.update_bomb_count(bomb_count)
		HUD_score.update_bomb_count()
		
		
		#Add explosion animation
		
		
		#Make it so that bullets gradually disapear and have exploding animation
		await get_tree().create_timer(wait_time).timeout #Time players immortality
		player_collision.disabled = false
		

