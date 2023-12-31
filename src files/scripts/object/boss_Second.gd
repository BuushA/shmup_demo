extends "res://scripts/env/EVENT-BOSS SECTION.gd"

@export var bullet_speed : float

@export var bullet_cycles : int
@export var bullet_count : int

@export var cd_bull : float
@export var cd_cycl : float
@export var cd_loop : float

@export var rotations : int = 1 
@export var bullet_rotations : int = 1

#space for movement variables 




func setting_up():
	boss.second_section(
	bullet_speed, bullet_cycles, bullet_count,
	cd_bull, cd_cycl, cd_loop,
	rotations, bullet_rotations)
	
