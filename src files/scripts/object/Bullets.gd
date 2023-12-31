extends Node2D


signal upgrade

var first_upgrade_call : Callable
@export var shoot_position : int #might add more positions which vary
var bullet
var shoot_period = 0
var toggle_shoot = false #checks if you want to shoot or not
var main_node
@export var first_bullet : PackedScene
var player
var HUD
#Weapon upgrade variables
@export var shoot_speed : float
@export var starting_upgrade_points : int
var upgrade_points : int
var swap_bullet : PackedScene
var bullet_count : int


#starting position variables
func _ready():
	#triggers when reaching x amount of points
	first_upgrade_call = Callable(self, "on_first_upgrade_weapon")
	upgrade.connect(first_upgrade_call)
	
	if is_inside_tree():
		main_node = get_tree().get_root().get_node("First_level")
		player = get_tree().get_first_node_in_group("player")
		HUD = get_tree().get_first_node_in_group("Scores")

#handles shooting functions
func _process(delta):
	toggle_shooting()
	if(toggle_shoot):
		shoot(delta)
	first_upgrade_calling()

func shoot(delta):
	bullet = first_bullet.instantiate() #makes it usable
	shoot_period += delta
	if shoot_period > shoot_speed: #adds a delay between each shot
		if bullet != null:
			main_node.add_child(bullet)
			bullet.position = player.position - Vector2(0, shoot_position)
			shoot_period = 0
			
			
func toggle_shooting():
	#Toggle shooting on and off
	var shoot_hotkey = Input.is_action_just_pressed("shoot")
	if shoot_hotkey:
		#print("ok")
		if(!toggle_shoot):
			toggle_shoot = true
		elif(toggle_shoot):
			toggle_shoot = false

func first_upgrade_calling():
	if GlobalVariables.Score >= starting_upgrade_points:
		upgrade.emit()
		if is_connected("upgrade", first_upgrade_call):
			upgrade.disconnect(first_upgrade_call)

func on_first_upgrade_weapon():
		var stat_upgraded #for passing this value
		var a_previous
		var change : int
		a_previous = shoot_speed
		shoot_speed -= 0.15
		change = ((a_previous - shoot_speed) / a_previous) * 100
		stat_upgraded = "shoot speed: " + str(change) + "% faster"
		HUD.show_upgrade(stat_upgraded)
		#place for sound
		
		await get_tree().create_timer(2.0).timeout
		HUD.upgrade_label.hide()
		
		
		




