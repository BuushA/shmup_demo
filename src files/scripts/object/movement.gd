extends CharacterBody2D

var direction = Input.get_vector("move_back", "move_forward", "move_left", "move_right") #Inputs of 4 vectors

@export var move_speed = 300 #character speed
@export var shift_speed = 1.0 #slowing modifier; < 2 for best use

var screen_size : Vector2

@export var player_size : float #set the size which fits the screens edge


func _ready():
	screen_size = get_viewport().size
	#player functionality
func _physics_process(delta):
	move()
	move_and_slide()
	player_in_screen()
	is_alive()

func move():
	direction = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
	Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")).limit_length(1.0)
	
	var shifted_speed = move_speed / shift_speed
	
#space key makes you go slower + shows hitbox ##NEEDS TO BE ADDED##
	if Input.is_action_pressed("shifting"):
		velocity = direction.normalized() * shifted_speed
	else:
		velocity = direction.normalized() * move_speed

#Players can't go past the screen
func player_in_screen():
	position.x = clamp(position.x, player_size + 15, screen_size.x - player_size - 185)
	position.y = clamp(position.y, player_size - 50, screen_size.y - player_size - 50)
	
	
#checks if the player still has lives left
func is_alive():
	var lives = GlobalVariables.player_life
	var main_scene = self.get_parent()
	if lives <= 0:
		#add animation later here
		self.queue_free()
		main_scene.game_over()
