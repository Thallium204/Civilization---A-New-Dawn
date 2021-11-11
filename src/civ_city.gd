class_name civ_city
extends Node2D

var player_owner:civ_player
var is_capital:bool = false
var is_mature:bool = false
var defense_value:int = 0
var wonder_slot

func _ready():
	update_sprite()


func update_sprite():
	$sprite.modulate = player_owner.player_color
	if is_capital:
		$sprite.texture = load("res://assets/structures/capital.PNG")
	else:
		$sprite.texture = load("res://assets/structures/city.PNG")
