extends Control


func _ready():
	call_deferred("initial_neighbour_call")

func initial_neighbour_call():
	game.UPDATE_SPACE_NEIGHBOURS()
