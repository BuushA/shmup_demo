extends Node
var start_time = Timer.new()
#var end_time = Timer.new()

var enemy_spawn
var enemy_spawn1
@export var follow_path : PathFollow2D
@export var follow_path1 : PathFollow2D

@export var enemy : PackedScene
var end_time = Timer.new()
#enemy variables
@export var en_float_speed : float #multiplied speed of enemy
@export var en_speed_modifier : float #speed by * 0.1^x
@export var en_bullet_count : int #total count of bullets
@export var en_cooldown : float #between shoting rings
@export var en_bullet_speed : float #speed of bullets; best to do < 2
enum bullet_type {FOUR_WAY = 0, INFRONT = 1, STRAIGHT = 2, EIGHT_WAY = 3}
@export var en_bullet_type : bullet_type #a digit represent (0-3): four_way, infront, straight, eight_way
@export var en_kill_score : int #score given for a kill of the enemy
@export var en_first_shot = true #enemy shoots right when he spawns


@export var wait_1 : float
#@export var wait_2 : float
@export var mob_spawn_rate : float
@export var enemy_count : int

#@export var next_event : Node

var set_path_value = 0  #set the value which will be given to enemies to follow #should automate this process
var set_path_value1 = 0

@export var next_event : Node #the following event


func activate(previous_path):
	set_path_value = previous_path + 1
	set_path_value1 = set_path_value + 1
	summon_two()
	
	
#transition
func _on_timer_timeout():
	#moves on to a different script
	if next_event != null:
		next_event.activate(set_path_value1)
	

func summon_two():
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
		enemy_spawn1 = enemy.instantiate()
		#print(str(entity) + " " + str(enemy_spawn))
		if enemy_spawn != null && enemy_spawn1 != null:
			enemy_spawn.position = follow_path.position
			enemy_spawn.path_value(set_path_value)
			enemy_spawn.enemy_variables(en_float_speed, en_speed_modifier, en_bullet_speed, en_bullet_count,
			 en_cooldown, en_bullet_type, en_kill_score, en_first_shot)
			add_child(enemy_spawn)
			enemy_spawn1.position = follow_path1.position
			enemy_spawn1.path_value(set_path_value1)
			enemy_spawn1.enemy_variables(en_float_speed, en_speed_modifier, en_bullet_speed, en_bullet_count,
			 en_cooldown, en_bullet_type, en_kill_score, en_first_shot)
			add_child(enemy_spawn1)
			await get_tree().create_timer(mob_spawn_rate).timeout
		if entity == enemy_count - 1:
			#create a timer for ending the script
			get_tree().create_timer(0.1).timeout.connect(_on_timer_timeout)
			
