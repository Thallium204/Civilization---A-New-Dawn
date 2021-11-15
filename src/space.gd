class_name civ_space, "res://icons/Space.svg"
tool
extends Node2D

var space_neighbours = []

var space_in_tile_id = gl.SPACE_0

var terrain_type:int = gl.TERRAIN_TYPE_GRASSLAND setget set_terrain_type
var terrain_id:int = 0 setget set_terrain_id
var spawn_type:int = gl.SPAWN_TYPE_NONE setget set_spawn_type
var spawn_id:int = 0 setget set_spawn_id
var structure = null
var figures = []

onready var sprite_terrain = $sprite_terrain
onready var sprite_spawn = $sprite_spawn

onready var cmp_gui = $area_drag

func add_structure(struct):
	if structure:
		structure.queue_free()
	structure = struct
	add_child(struct)

func position_space(side):
	var pos = gl.SPACE_POSITIONS[space_in_tile_id]
	pos.x *= -(side*2-1)
	position = pos

func set_terrain_type(new_terrain_type):
	terrain_type = new_terrain_type
	update_sprite()
	property_list_changed_notify()

func set_terrain_id(new_terrain_id):
	terrain_id = new_terrain_id
	update_sprite()

func set_spawn_type(new_spawn_type):
	spawn_type = new_spawn_type
	update_sprite()
	property_list_changed_notify()

func set_spawn_id(new_spawn_id):
	spawn_id = new_spawn_id
	update_sprite()



func _init():
	if Engine.editor_hint:
		return
	gl.connect("camera_rot_changed",self,"update_sprite")

func _ready():
	update_sprite()
	cmp_gui = $area_drag
	cmp_gui.space = self
	gl.connect("camera_rot_changed",cmp_gui,"update")


func update_space_neighbours():
	space_neighbours = []
	var space_state = get_world_2d().direct_space_state
	for dir in range(0,6):
		var from = global_position
		var to = from + gl.AXIS_X.rotated(dir*PI/3.0)
		var result = space_state.intersect_ray(from,to,[self])
		if result:
			space_neighbours.append(result.collider.get_parent())
		else:
			space_neighbours.append(null)


func _get_property_list() -> Array:
	
	var prop_list = [
		{
			name = "Space",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		{
			name = "space_in_tile_id",
			type = TYPE_INT,
			hint = PROPERTY_HINT_ENUM,
			hint_string = gl.SPACE_NAMES,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		{
			name = "terrain_type",
			type = TYPE_INT,
			hint = PROPERTY_HINT_ENUM,
			hint_string = gl.TERRAIN_TYPE_NAMES,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
	]
	
	if terrain_type == gl.TERRAIN_TYPE_NATURAL_WONDER:
		prop_list.append(
			{
				name = "terrain_id",
				type = TYPE_INT,
				hint = PROPERTY_HINT_ENUM,
				hint_string = gl.NATURAL_WONDER_NAMES,
				usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
			})
	
	if not terrain_type in [gl.TERRAIN_TYPE_NATURAL_WONDER,gl.TERRAIN_TYPE_WATER]:
		prop_list.append(
			{
				name = "spawn_type",
				type = TYPE_INT,
				hint = PROPERTY_HINT_ENUM,
				hint_string = gl.SPAWN_TYPE_NAMES,
				usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
			}
		)
	
	if spawn_type == gl.SPAWN_TYPE_RESOURCE:
		prop_list.append(
			{
				name = "spawn_id",
				type = TYPE_INT,
				hint = PROPERTY_HINT_ENUM,
				hint_string = gl.RESOURCE_NAMES,
				usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
			})
	elif spawn_type == gl.SPAWN_TYPE_BARBARIAN:
		prop_list.append(
			{
				name = "spawn_id",
				type = TYPE_INT,
				hint = PROPERTY_HINT_ENUM,
				hint_string = gl.BARBARIAN_NAMES,
				usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
			})
	elif spawn_type == gl.SPAWN_TYPE_CITY_STATE:
		prop_list.append(
			{
				name = "spawn_id",
				type = TYPE_INT,
				hint = PROPERTY_HINT_ENUM,
				hint_string = gl.CITY_STATE_NAMES,
				usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
			})
	
	return prop_list


func update_sprite():
	if not sprite_terrain:
		return
	rotation_degrees = gl.camera_rot
	#$sprite_terrain.modulate = gl.terrain_color[terrain_type]
	var path_terrain = "res://assets/terrain/isolated/"+gl.get_type_name_as_path(gl.TERRAIN_TYPE_NAMES,terrain_type)+".png"
	match terrain_type:
		gl.TERRAIN_TYPE_NATURAL_WONDER:
			path_terrain = "res://assets/natural wonders/isolated/"+gl.get_type_name_as_path(gl.NATURAL_WONDER_NAMES,terrain_id)+".png"
	sprite_terrain.texture = load(path_terrain)
	
	sprite_spawn.visible = true
	match spawn_type:
		gl.SPAWN_TYPE_NONE:
			sprite_spawn.visible = false
		gl.SPAWN_TYPE_RESOURCE:
			var path_resource = "res://assets/resources/spawn/"+gl.get_type_name_as_path(gl.RESOURCE_NAMES,spawn_id)+".png"
			sprite_spawn.texture = load(path_resource)
		gl.SPAWN_TYPE_BARBARIAN:
			var path_resource = "res://assets/barbarians/isolated/"+gl.get_type_name_as_path(gl.BARBARIAN_NAMES,spawn_id)+".png"
			sprite_spawn.texture = load(path_resource)
		gl.SPAWN_TYPE_CITY_STATE:
			var path_resource = "res://assets/city states/"+gl.get_type_name_as_path(gl.CITY_STATE_NAMES,spawn_id)+".png"
			sprite_spawn.texture = load(path_resource)
		gl.SPAWN_TYPE_CAPITAL:
			var path_resource = "res://assets/capital_icon.png"
			sprite_spawn.texture = load(path_resource)

var has_pulsed = false
var distance_from = INF
var optimal_path = [] setget set_optimal_path
func set_optimal_path(new_optimal_path):
	optimal_path = new_optimal_path
	cmp_gui.update()






