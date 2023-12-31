extends "res://scripts/object/basic_enemy.gd"

@export var gravity_force : int = 100
#@export var rotated_direction : int = 25

func floating():
	enemy.position.y += gravity_force * 0.1
	#enemy.position.x += rotated_direction * (-0.1)
	
	
func _physics_process(delta):
	if enemy != null && not stop_following_path:
		calculating_path(delta)
	else:
		floating()
		#print("currently_floating")

#add new functionality near the end
#starts floating then it finishes shooting
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
	stop_following_path = true
