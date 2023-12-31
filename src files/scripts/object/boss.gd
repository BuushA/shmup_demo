extends Area2D


var enemy = self
var Boss_health : float
var player : CharacterBody2D
var main_node 
var procentile_hp : float = GlobalVariables.procentile_hp
@export var bullet : PackedScene
var for_healthBar

var event_boss_node : Node
enum sections {FIRST = 1, SECOND = 2, THIRD = 3}

var shot_small = load("res://scenes/bullets/enem_a_small.tscn")

var main_node_sound : Node2D
@export var death_music : AudioStreamMP3
var d_bus = "Deaths"
@export var hit_sound : AudioStreamMP3
var h_bus = "BossHit"
var start_pos : Vector2

func _ready():
	if is_inside_tree():
		player = get_tree().get_first_node_in_group("player")
		main_node = get_tree().get_root().get_node("First_level")
		for_healthBar = get_tree().get_first_node_in_group("Scores")
		for_healthBar.boss_healthbar()
		main_node_sound = get_tree().get_first_node_in_group("sound_source")
	if enemy != null:
		start_pos = enemy.position
		

func _process(delta):
	is_alive()
	#print(str(GlobalVariables.boss_hp) + " currently")



func spawned(health, boss_node): #music and animation properties
	Boss_health = health
	event_boss_node = boss_node #refrence to the event node
	GlobalVariables.boss_health(Boss_health)
	procentile_hp = GlobalVariables.procentile_hp #first update
	#I can add music and start animations here




func first_section():
	var shot
	var direction = 0
	var bullet_speed : float = 2
	var n : int = 7
	var bul : int = 20
	#creating hp from 100% to 0%
		#for repeat in n: #repeat n times
	while(procentile_hp >= 84):
		for repeat in n: #repeat n times
			if(direction >= PI / 2.5 || direction == 0):
				direction = -PI / 2
			direction -= PI / 30 * 6.5
			if(procentile_hp <= 84): #cancel any time
				break
			for ring_bullet in bul: #number of bullets in this cycle
				shot = bullet.instantiate()
				direction += PI / 25 #rotation of each bullet #the more you divide the less space is between each shot PI = 180 degrees
				shot.rotation = direction
				shot.bullet_variables(shot.rotation, bullet_speed) #need to tell the bullet it's direction + it's speed
				shot.add_to_group("bullet")
				main_node.add_child(shot)
				shot.position = enemy.position #only adds distance; it's already at it's center
				if(procentile_hp <= 84): #cancel any time
					break
				if player == null:
					break
				await get_tree().create_timer(0.01).timeout #time between each bullet summon
			await get_tree().create_timer(0.25).timeout #time between each cycle
			if player == null:
				break
		await get_tree().create_timer(1.75).timeout #time between every loop
		
#SECOND PART ----------------------------------------------------------------
	direction = 0
	n = 6
	bul = 18
	while(procentile_hp >= 60):
		bul = 16
		for repeat in n: #repeat n times
			if repeat >= 2:
				direction -= PI / 8
			if direction >= -0:
				direction = -PI / 1.75
			if(procentile_hp <= 60): #cancel any time
				break
			
			for ring_bullet in bul: #number of bullets in this cycle
				shot = bullet.instantiate()
				direction += PI / 40 #rotation of each bullet #the more you divide the less space is between each shot PI = 180 degrees
				shot.rotation = direction
				#print(rad_to_deg(direction))
				shot.bullet_variables(shot.rotation, bullet_speed) #need to tell the bullet it's direction + it's speed
				shot.add_to_group("bullet")
				main_node.add_child(shot)
				shot.position = enemy.position #only adds distance; it's already at it's center
				await get_tree().create_timer(0.05).timeout #time between each bullet summon
				if(procentile_hp <= 60): #cancel any time
					break
				if player == null:
					break
			await get_tree().create_timer(0.6).timeout #time between each cycle
			bul += 3
		#last loop
		bul = 36
		direction = 0
		if(procentile_hp <= 60): #cancel any time
			break
		for ring_bullet in bul: #number of bullets in this cycle
			shot = bullet.instantiate()
			direction += PI / 18 #rotation of each bullet #the more you divide the less space is between each shot PI = 180 degrees
			shot.rotation = direction
			shot.bullet_variables(shot.rotation, bullet_speed) #need to tell the bullet it's direction + it's speed
			shot.add_to_group("bullet")
			main_node.add_child(shot)
			shot.position = enemy.position #only adds distance; it's already at it's center
			if player == null:
				break
		await get_tree().create_timer(2).timeout #time between every loop
		
	#calls to the next section
	await get_tree().create_timer(1).timeout
	event_boss_node.next_event(sections.SECOND)


func second_section(
	bullet_speed, bullet_cycles, bullet_count,
	cd_bull, cd_cycl, cd_loop,
	rotations, bullet_rotations):
	var shot
	var direction = 0
	var rotate_bul = 0
	while(procentile_hp >= 35):
		for repeat in bullet_cycles: #repeat n times
			direction -= PI / 30 * 6.5
			for ring_bullet in bullet_count: #number of bullets in this cycle
				shot = bullet.instantiate()
				direction += PI / rotations #rotation of each bullet #the more you divide the less space is between each shot PI = 180 degrees
				rotate_bul += PI / bullet_rotations
				shot.rotation = direction
				shot.bullet_variables(shot.rotation, bullet_speed) #need to tell the bullet it's direction + it's speed
				shot.add_to_group("bullet")
				main_node.add_child(shot)
				shot.position = enemy.position #only adds distance; it's already at it's center
				await get_tree().create_timer(cd_bull).timeout #time between each bullet summon
			await get_tree().create_timer(cd_cycl).timeout #time between each cycle
		await get_tree().create_timer(cd_loop).timeout #time between every loop
		if player == null:
			break
			
#SECOND PART MOVE -----------------------------------------------------------------------------------------------------
		#moves away and start another loop
		var move_in_dir : float = -1
		var random_dir = randi() % 100 + 1
		if(random_dir <= 50):
			move_in_dir = -1
		var new_position = enemy.position * 1.25 + Vector2(0, 250)
		var old_position = enemy.position
		if move_in_dir < 0:
			new_position.x = enemy.position.x - (abs(enemy.position.x * 1.25 * (-1)) - enemy.position.x)
		if(procentile_hp <= 35):
			break
		while(enemy.position != new_position):
			var enemy_dir = new_position - enemy.position
			enemy.position.x += enemy_dir.x / 2
			enemy.position.y += enemy_dir.y / 2
			if(round(new_position.x) == round(enemy.position.x) && round(new_position.y) == round(enemy.position.y)):
				break
			if player == null:
				break
			if enemy_dir.x >= 2 && enemy_dir.y >= 2:
				await get_tree().create_timer(0.2).timeout
				
#SHOOT ---------------------------------------------------------------------------------------------------------------------
		for repeat in bullet_cycles: #repeat n times
			direction -= PI / 30 * 6.5
			for ring_bullet in bullet_count: #number of bullets in this cycle
				shot = shot_small.instantiate()
				direction += PI / rotations #rotation of each bullet #the more you divide the less space is between each shot PI = 180 degrees
				rotate_bul += PI / bullet_rotations
				shot.rotation = direction
				shot.bullet_variables(shot.rotation, bullet_speed) #need to tell the bullet it's direction + it's speed
				shot.add_to_group("bullet")
				main_node.add_child(shot)
				shot.position = enemy.position #only adds distance; it's already at it's center
				if(procentile_hp <= 35):
					break
				if player == null:
					break
				await get_tree().create_timer(cd_bull).timeout #time between each bullet summon
			await get_tree().create_timer(cd_cycl).timeout #time between each cycle
		await get_tree().create_timer(cd_loop).timeout #time between every loop
		if player == null:
			break
			
#RETURN --------------------------------------------------------------------------------------------------------------
		#return back to the original position
		var distance_to = old_position - enemy.position
		if(procentile_hp <= 35):
			break
		while(enemy.position != old_position):
			var enemy_dir = old_position - enemy.position
			enemy.position.x += enemy_dir.x / 2
			enemy.position.y += enemy_dir.y / 2
			if(round(old_position.x) == round(enemy.position.x) && round(old_position.y) == round(enemy.position.y)):
				break
			if player == null:
				break
			if(procentile_hp <= 35):
				break
			if enemy_dir.x > 2 && enemy_dir.y > 2:
				await get_tree().create_timer(0.2).timeou
	event_boss_node.next_event(sections.THIRD)

func third_section(	
	bullet_speed, bullet_cycles, bullet_count,
	cd_bull, cd_cycl, cd_loop,
	rotations, bullet_rotations):
	
	if(round(start_pos.x) != round(enemy.position.x) && round(start_pos.y) != round(enemy.position.y)):
		enemy.position = start_pos
	
	var shot
	var direction = -PI / 2
	var rotate_bul = 0
	while(procentile_hp >= 0):
		direction = -PI / 2
		for repeat in bullet_cycles: #repeat n times
			#resets at 0 degrees each time
			if direction != -PI / 2:
				direction -= -PI
			for ring_bullet in bullet_count: #number of bullets in this cycle
				shot = bullet.instantiate()
				direction += PI / rotations #rotation of each bullet #the more you divide the less space is between each shot PI = 180 degrees
				rotate_bul += PI / bullet_rotations
				shot.rotation = direction
				shot.bullet_variables(shot.rotation, bullet_speed) #need to tell the bullet it's direction + it's speed
				shot.add_to_group("bullet")
				main_node.add_child(shot)
				shot.position = enemy.position #only adds distance; it's already at it's center
				await get_tree().create_timer(cd_bull).timeout #time between each bullet summon
			await get_tree().create_timer(cd_cycl).timeout #time between each cycle
			if player == null:
				break

#SECOND PART ---------------------------------------------------------------------------------------------------------
		var s_bullet_cycles = 2
		var s_bullet_count = 45
		var s_cd_bull = 0
		var s_cd_cycl = 0.75
		var s_rotations = 22.5
		var s_bullet_speed = 0.5
		direction = 10
		for repeat in s_bullet_cycles: #repeat n times
			for ring_bullet in s_bullet_count: #number of bullets in this cycle
				shot = shot_small.instantiate()
				direction += PI / s_rotations #rotation of each bullet #the more you divide the less space is between each shot PI = 180 degrees
				rotate_bul += PI / bullet_rotations
				shot.rotation = direction
				shot.bullet_variables(shot.rotation, s_bullet_speed) #need to tell the bullet it's direction + it's speed
				shot.add_to_group("bullet")
				main_node.add_child(shot)
				shot.position = enemy.position #only adds distance; it's already at it's center
				await get_tree().create_timer(s_cd_bull).timeout #time between each bullet summon
			await get_tree().create_timer(s_cd_cycl).timeout #time between each cycle
			if player == null:
				break
			direction = 0
		await get_tree().create_timer(cd_loop).timeout #time between every loop
		if player == null:
			break


func _on_area_entered(area):
	#Boss_health -= 10 
	#print(str(Boss_health) + "- right now") 
	#know that type of bullet is hitting. #print(area.is_in_group("type_a")) DONE
	#Calcualte damage of said bullet. #recognize every bullet 1/3
	if area != player:
		main_node.play_sound(hit_sound, h_bus)
		if(area.is_in_group("type_a")):
			Boss_health -= 20
		#update globally
		GlobalVariables.boss_health(Boss_health)
		procentile_hp = GlobalVariables.procentile_hp

func is_alive():
	if Boss_health <= 0:
		#change it to something else like an animation or a cutscene later on
		#It's not a SIMPLE enemy - it should have a good send off
		if enemy != null:
			for_healthBar.hide_boss_healthbar()
			main_node_sound.play_sound(death_music)
			queue_free()
			get_tree().call_group("bullet", "queue_free")
			
		#not in the main node so I could later add an ending
		main_node.victory()




