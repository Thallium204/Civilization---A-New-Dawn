class_name civ_tile, "res://icons/Tile.svg"
tool
extends Node2D

var snap = false setget snap_to_grid

var active_side_id = gl.TILE_SIDE_A setget set_active_side_id
onready var active_side:civ_tile_side = $side_A

func snap_to_grid(_ignore):
	position = gl.snap_to_hex_grid(position)

func set_active_side_id(new_active_side_id):
	active_side_id = new_active_side_id
	for child in get_children():
		if child is civ_tile_side:
			child.visible = (child.side_id == active_side_id)
			if child.visible:
				active_side = child

func _get_property_list() -> Array:
	var prop_list = [
		{
			name = "Tile",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		{
			name = "active_side_id",
			type = TYPE_INT,
			hint = PROPERTY_HINT_ENUM,
			hint_string = gl.TILE_SIDE_NAMES,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		{
			name = "snap",
			type = TYPE_BOOL,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		
	]
	
	return prop_list
