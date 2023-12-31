extends "res://scripts/env/EVENT - start.gd"


var enemy_spawn1
var enemy_spawn2


#extra variables for second enemies
@export var wait_second : int
@export var follow_path1 : PathFollow2D
var set_path_value1 = 0
@export var wait_third : int
@export var follow_path2 : PathFollow2D
var set_path_value2 = 0


func activate(previous_path):
	set_path_value = previous_path + 1
	summon_one()
	#start the timer to run script delayed
	if wait_second != 0:
		await get_tree().create_timer(wait_second + wait_1).timeout
		set_path_value1 = set_path_value + 1
		summon_second()
	if wait_third != 0:
		await get_tree().create_timer(wait_third).timeout
		set_path_value2 = set_path_value1 + 1
		summon_third()


func summon_second():
	#ready all the properties
	
	
	#summon all the enemies
	for entity in range(enemy_count):
		enemy_spawn1 = enemy.instantiate()
		#print(str(entity) + " " + str(enemy_spawn))
		if enemy_spawn1 != null:
			enemy_spawn1.position = follow_path1.position #unneccessery
			enemy_spawn1.path_value(set_path_value1)
			#add a enemy function which gives enables the set variables:
			enemy_spawn1.enemy_variables(en_float_speed, en_speed_modifier, en_bullet_speed, en_bullet_count, en_cooldown, en_bullet_type, en_kill_score, en_first_shot)
			add_child(enemy_spawn1)
			await get_tree().create_timer(mob_spawn_rate).timeout
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
			
func summon_third():
	#summon all the enemies
	for entity in range(enemy_count):
		enemy_spawn2 = enemy.instantiate()
		#print(str(entity) + " " + str(enemy_spawn))
		if enemy_spawn2 != null:
			enemy_spawn2.position = follow_path2.position #unneccessery
			enemy_spawn2.path_value(set_path_value2)
			#add a enemy function which gives enables the set variables:
			enemy_spawn2.enemy_variables(en_float_speed, en_speed_modifier, en_bullet_speed, en_bullet_count, en_cooldown, en_bullet_type, en_kill_score, en_first_shot)
			add_child(enemy_spawn2)
			await get_tree().create_timer(mob_spawn_rate).timeout
		if entity == enemy_count - 1:
			#create a timer for ending the script
			get_tree().create_timer(0.1).timeout.connect(_on_timer_timeout)
