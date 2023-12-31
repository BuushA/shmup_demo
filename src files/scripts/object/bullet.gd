extends Area2D

@export var b_speed : float
var accelaration : float
var bullet = self
@export var hit_layer : int
@export var hit_mask : int


func _ready():
	accelaration = 0

func _physics_process(delta):
	b_shot(delta)
	
func b_shot(delta):
	#accelaration += delta
	bullet.position += Vector2(0, -(b_speed))


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
