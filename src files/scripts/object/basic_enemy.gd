extends Area2D

#shoots this type of bullet can add more
@export var bullet : PackedScene
#easy refrence
var enemy = self


#Needed starting variables for a movement
var order_of_path : int
var new_follow_path = PathFollow2D.new()
var set_path = []
var bullet_list = []
#4 type of bullet paterns for know


#passing variables for the bullet and enemy
var four_way = false
var infront = false
var straight = false
var eight_way = false
@export var float_speed : int #direct speed in a 1-10 scale
@export var speed_modifier : int #lowers or adds speed by * 10

var bullet_speed : float #shouldn't be more than 2
@export var bullet_count : int
@export var cooldown : float = 0 #time between shots
@export var radius_scale = 1
@export var shoot_distance = 1 #range or spread


var main_node #adds to the current scene tree

#loop variable
var numb = 0
var shot
var direction = 0
var first_shot : bool
#variables for shooting
@export var coordinate_x = 90 
@export var coordinate_y = 0

#variables for updating the score
var HUD_scores
var set_score : int
var player

#for floating enemies
var stop_following_path = false
@export var hit_sound : AudioStreamMP3
@export var death_sound : AudioStreamMP3
var h_bus = "EnHit"
var d_bus = "Deaths"

func _ready():
	if is_inside_tree():
		main_node = get_tree().get_root().get_node("First_level")
		HUD_scores = get_tree().get_first_node_in_group("Scores")
		set_path = get_tree().get_nodes_in_group("Path")
		player = get_tree().get_first_node_in_group("player")
	#sets a new path for each enemy on spawn
	new_follow_path.loop = false
	if set_path != []:
		set_path[order_of_path].add_child(new_follow_path)
	stop_following_path = false
	#shooting function
	shoot_out(1)

	
func _physics_process(delta):
	#enemies move along the line
	if enemy != null:
		calculating_path(delta)
		

#it follows a path at a set speed and it moves by progressing from (0, 1), updating the position based on progress
func calculating_path(delta):
	if new_follow_path != null:
		var add_progress = float_speed * pow(10, -speed_modifier)
		new_follow_path.progress_ratio += add_progress
		enemy.position = new_follow_path.position
	if new_follow_path.progress_ratio >= 1:
		stop_following_path = true

func path_value(value):
	order_of_path = value


#dies when it leaves the screen
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

#hit kills it and the bullet
func _on_area_entered(area):
	area.queue_free()
	main_node.play_sound(hit_sound, h_bus)
	queue_free()
	GlobalVariables.update_score(set_score)
	HUD_scores.update_score()
	
	
#Two signals of area entered overlap, so this is a fix for that
#works only then the player bumps into the enemy
func _on_body_entered(body):
	self.queue_free()
	main_node.play_sound(death_sound, d_bus)
	GlobalVariables.update_score(set_score)
	HUD_scores.update_score()
	GlobalVariables.update_lifes()
	HUD_scores.player_lives()
			
		
	
	
	#In development
func shoot_out(coordinates):
	var type = true
	var dalmuo : int
	var rings : int
	
	match type:
		four_way:
			dalmuo = 2
		infront:
			dalmuo = 0.5
		straight:
			dalmuo = 1
		eight_way:
			dalmuo = 4
	if bullet_count != 0:
		rings = bullet_count / ( dalmuo * 2)
	for ring_shots in rings:
		#make shots a bit more random
		cooldown = randf_range(cooldown * 0.5, 2 * cooldown)
		#shoot at the start
		if first_shot:
			await get_tree().create_timer(cooldown * 0.1).timeout #without the delay it's kinda bad
			first_shot = false
		else:
			await get_tree().create_timer(cooldown).timeout
		for ring_bullet in dalmuo * 2:
			shot = bullet.instantiate()
			direction += PI / dalmuo
			shot.rotation = direction
			shot.bullet_variables(shot.rotation, bullet_speed) #need to tell the bullet it's direction + it's speed
			shot.add_to_group("bullet")
			main_node.add_child(shot)
			shot.position = enemy.position #only adds distance; it's already at it's center
		#print(shot.rotation)
	#print("YOOO" + str(coordinates))


func enemy_variables(fl_speed, mod_speed, b_speed, b_count, cooldwn, spread_type, kill_score, shoot_f):
	float_speed = fl_speed
	speed_modifier = mod_speed
	bullet_speed = b_speed
	bullet_count = b_count
	cooldown = cooldwn
	set_score = kill_score
	match spread_type:
		0:
			four_way = true
		1:
			infront = true
		2:
			straight = true
		3:
			eight_way = true
	first_shot = shoot_f
