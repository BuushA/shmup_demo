extends Node

var Score = 0
var boss_hp
var procentile_hp : float
var for_healthBar
var maximum_boss_hp : float
var player_life : int #change it that it take the value from a resource file
var bomb_count : int

func _ready():
	if is_inside_tree():
		for_healthBar = get_tree().get_first_node_in_group("Scores")
	player_life = 3


func boss_health(hp):
	if is_inside_tree():
		for_healthBar = get_tree().get_first_node_in_group("Scores")
	if(maximum_boss_hp == null || maximum_boss_hp == 0):
		maximum_boss_hp = hp
	boss_hp = hp
	if boss_hp <= 0:
		boss_hp = 0
	procentile_hp = boss_hp
	procentile_hp = procentile_hp * 100 / maximum_boss_hp
	for_healthBar.boss_healthbar() #update the healthbar
	
func update_bomb_count(count):
	bomb_count = count

func update_score(points):
	Score += points
	#print(Score)
	
func update_lifes():
	player_life -= 1
	if player_life <= 0:
		player_life = 0
	#print("updated LIVES")
