extends Node

var boss

func activate(enemy):
	boss = enemy
	setting_up()
	
	
func setting_up():
	#all the properties are set here for the boss to have
	#starts the boss script
	boss.first_section()
