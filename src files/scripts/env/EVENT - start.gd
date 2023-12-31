extends Node

#timer for delaying start or end
var start_time = Timer.new()
var end_time = Timer.new()

var enemy_spawn 
@export var follow_path : PathFollow2D #path for starting position
@export var enemy : PackedScene #enemy which we spawn
#enemy variables
@export var en_float_speed : float #multiplied speed of enemy
@export var en_speed_modifier : float #speed by * 0.1^x
@export var en_bullet_count : int #total count of bullets
@export var en_cooldown : float #between shoting rings
@export var en_bullet_speed : float #speed of bullets; best to do < 2
enum bullet_type {FOUR_WAY = 0, INFRONT = 1, STRAIGHT = 2, EIGHT_WAY = 3}
@export var en_bullet_type : bullet_type #a digit represent (0-3): four_way, infront, straight, eight_way
@export var en_kill_score : int 
@export var en_hitpoint : int #total hits it takes to kill one
@export var en_first_shot = true #enemy shoots right when he spawns

@export var wait_1 : float #start time
@export var mob_spawn_rate : float #the rate at which it spawns
@export var enemy_count : int #amount of spawns a loop does
@export var next_event : Node #the following event

var set_path_value = 0  #set the value which will be given to enemies to follow #should automate this process

var previous_path : int
#improvised ready function; call it when starting the event
func activate(previous_path):
	summon_one()
	set_path_value = previous_path + 1
#transition
func _on_timer_timeout():
	#moves on to a different script
	if next_event != null:
		next_event.activate(set_path_value)
	
	
func summon_one():
		#print("this works")
	#start the timer to run script delayed
	if wait_1 != 0:
		start_time.wait_time = wait_1
		start_time.one_shot = true
		add_child(start_time)
		start_time.start()
		await start_time.timeout
	
	
	#ready all the properties
	
	
	#summon all the enemies
	for entity in range(enemy_count):
		enemy_spawn = enemy.instantiate()
		#print(str(entity) + " " + str(enemy_spawn))
		if enemy_spawn != null:
			enemy_spawn.position = follow_path.position
			enemy_spawn.path_value(set_path_value)
			#add a enemy function which gives enables the set variables:
			enemy_spawn.enemy_variables(en_float_speed, en_speed_modifier, en_bullet_speed, en_bullet_count, en_cooldown, en_bullet_type, en_kill_score, en_first_shot)
			add_child(enemy_spawn)
			await get_tree().create_timer(mob_spawn_rate).timeout
		if entity == enemy_count - 1:
			#create a timer for ending the script
			get_tree().create_timer(0.1).timeout.connect(_on_timer_timeout)
			
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
#Failed movement code
#func _process(delta):
#	#enemies move along the line
#	if enemy_spawn != null:
#		calculating_path(delta)
#		enemy_spawn.position = follow_path.position

#
#func calculating_path(delta):
#	follow_path.progress_ratio += delta * float_speed

