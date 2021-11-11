extends Control


func _ready():
	var spaces = get_tree().get_nodes_in_group("space")
	for space in spaces:
		if space is civ_space:
			space.update_space_neighbours()
