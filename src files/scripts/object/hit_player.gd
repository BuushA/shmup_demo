extends Node

var enemy_area : Area2D
var has_been_hit
var player : CharacterBody2D

##gone
func _ready():
	enemy_area = get_parent()
	if is_inside_tree():
		player = get_tree().get_first_node_in_group("player")
	#has_been_hit = Callable(self, "on_area_entered_by_player")
	#enemy_area.body_entered.connect(on_area_entered_by_player)
