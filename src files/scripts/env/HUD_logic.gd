extends CanvasLayer

var score_count : int
@onready var score = $"Score"

var bomb_count : int
@onready var bomb = $"Bomb_count"

@onready var upgrade_label = $"Upgrade"

@onready var Boss_healthBar = $Boss_hp_bar

@onready var life_count = $Life


func update_score():
	score = $"Score"
	if score != null:
		score_count = GlobalVariables.Score
		score.text = "Score: \n" + str(score_count)
	
	
func update_bomb_count():
	bomb = $"Bomb_count"
	if bomb != null:
		bomb_count = GlobalVariables.bomb_count
		bomb.text = "Bombs: \n" + str(bomb_count)
		
		
func show_upgrade(stat : String):
	upgrade_label.text = stat + " upgraded"
	
	
func boss_healthbar():
	Boss_healthBar.value = GlobalVariables.procentile_hp
	Boss_healthBar.show()
	
func hide_boss_healthbar():
	Boss_healthBar.hide()
	
#standardize to the rest of the update functions
func player_lives():
	var lifes_left = GlobalVariables.player_life
	life_count = $Life
	life_count.text = "Lifes remaining: \n"  + str(lifes_left)
	
	
func hud_victory():
	$Scene_switch.game_victory()
	
	
func hud_game_over():
	$Scene_switch.game_over()
	
func hud_new_game():
	$Scene_switch.hide_buttons()
