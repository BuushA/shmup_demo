extends "res://scripts/object/bullet.gd"



var direction


func b_shot(delta):
	accelaration += delta
	#print(direction)
	bullet.position += Vector2(0, 1).rotated(direction) * (b_speed * accelaration)


func bullet_variables(dir, speed):
	direction = dir
	b_speed = speed
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
