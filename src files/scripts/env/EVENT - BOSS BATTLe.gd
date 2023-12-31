extends Node

@export var time_start : int = 3
@export var time_end : int = 1

var boss_node = self
var enemy_spawn
@export var enemy : PackedScene
@export var boss_hitpoint : float #total hits it takes to kill one
@export var boss_position : Marker2D

@export var first_section : Node

@onready var second_section = $Second
@onready var third_section = $Third


func activate(_previous_path):
	boss_first_section_start()
	
	
func boss_first_section_start():
	await get_tree().create_timer(time_start).timeout
	enemy_spawn = enemy.instantiate()
	enemy_spawn.position = boss_position.position
	enemy_spawn.spawned(boss_hitpoint, boss_node)
	add_child(enemy_spawn)
	await get_tree().create_timer(time_end).timeout
	#print("trancision to section good")
	if first_section != null:
		first_section.activate(enemy_spawn)
	
func next_event(section : int):
	#boss calls this method to move to the next scene
	var next_section = section
	if(next_section == 2):
		second_section.activate(enemy_spawn)
	if(next_section == 3):
		third_section.activate(enemy_spawn)

