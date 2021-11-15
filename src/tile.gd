class_name civ_tile, "res://icons/Tile.svg"
tool
extends Node2D

var snap = false setget snap_to_grid

var active_side_id = gl.TILE_SIDE_A setget set_active_side_id


func snap_to_grid(_ignore=false):
	position = gl.snap_to_hex_grid(position)

func set_active_side_id(new_active_side_id):
	active_side_id = new_active_side_id
	invisible_inactive_tile_side()

func _ready():
	PLANT_TILE()

func PLANT_TILE():
	snap_to_grid()
	delete_inactive_tile_side()
	PROMOTE_SPACES()

func invisible_inactive_tile_side():
	for child in get_children():
		if child is civ_tile_side:
			child.visible = (child.side_id == active_side_id)

func delete_inactive_tile_side():
	if Engine.editor_hint:
		return
	for child in get_children():
		if child is civ_tile_side:
			child.visible = (child.side_id == active_side_id)
			if not child.visible:
				child.free()

func PROMOTE_SPACES():
	if Engine.editor_hint:
		return
	var active_side = get_children()[0]
	var spaces = active_side.space_array
	for space in spaces:
		active_side.remove_child(space)
		space.position = to_global(space.position)
		get_parent().call_deferred("add_child",space)
	# KILL SELF
	queue_free()

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
