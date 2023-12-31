extends Node 

var player : CharacterBody2D
var HUD_scores
var enemy_area
#from enemy
func on_area_entered_by_player(area):
	if area == player:
		player.queue_free()
	#has_been_hit = Callable(self, "on_area_entered_by_player")
	#enemy_area.body_entered.connect(on_area_entered_by_player)

##how enemies are killed
func _on_area_entered(area):
	area.queue_free()
	queue_free()
	GlobalVariables.update_score(0)
	HUD_scores.update_score()


##from bullet script
func _ready():
	enemy_area = get_parent()
	if is_inside_tree():
		player = get_tree().get_first_node_in_group("player")
