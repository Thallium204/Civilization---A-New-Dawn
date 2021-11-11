class_name civ_tile_side
tool
extends YSort

var side_id = gl.TILE_SIDE_A setget set_side_id

onready var space_array = [$space0,$space1,$space2,$space3,$space4,$space5,$space6,$space7,$space8,$space9]

func set_side_id(new_side_id):
	side_id = new_side_id
	position_spaces()
	orient_outline()

func _ready():
	for space in space_array:
		space.space_in_tile_id = int(space.name[-1])
	position_spaces()
	orient_outline()

func _get_property_list() -> Array:
	
	var prop_list = [
		{
			name = "Tile Side",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		{
			name = "side_id",
			type = TYPE_INT,
			hint = PROPERTY_HINT_ENUM,
			hint_string = gl.TILE_SIDE_NAMES,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
	]
	
	return prop_list

func position_spaces():
	for child in get_children():
		if child is civ_space:
			child.position_space(side_id)

func orient_outline():
	if get_node_or_null("outline"):
		$outline.flip_h = bool(side_id)


