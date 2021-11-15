tool
extends Node

signal camera_rot_changed(camera_rot)

const GROUP_SPACES = "space"
const GROUP_CITY_SPACES = "city space"

enum {
	EDIT_MODE_SELECT,
	EDIT_MODE_MOVE,
}

const tile_scenes = [
	preload("res://src/tiles/tile1.tscn"),
]

var edit_mode = EDIT_MODE_SELECT
var edit_mode_metadata

var camera_rot = 0.0 setget set_camera_rot

func set_camera_rot(new_camera_rot):
	camera_rot = new_camera_rot
	emit_signal("camera_rot_changed")

func get_type_name_as_path(STRING:String,enum_id):
	return (STRING.split(",")[enum_id]).to_lower().replace(" ","_").replace(".","")

func get_type_name_as_string(STRING:String,enum_id):
	return (STRING.split(",")[enum_id])

### SPACES

const AXIS_X = Vector2(355,0)
var   AXIS_Y = AXIS_X.rotated(PI/3)

func snap_to_hex_grid(pos):
	
	var x_float = pos.x / AXIS_X.x
	var y_float = pos.y / AXIS_Y.y
	var y_int = int(round(y_float))
	var y_delta = abs(y_int % 2)
	var shifted_x_float = x_float + 0.5 * y_delta
	var shifted_x_int = int(round(shifted_x_float))
	var x_half = shifted_x_int - 0.5 * y_delta
	
	return Vector2( x_half*AXIS_X.x , y_int*AXIS_Y.y )


var SPACE_POSITIONS = [
	Vector2.ZERO,
	-AXIS_Y,
	-AXIS_X,
	-AXIS_X + AXIS_Y,
	AXIS_Y,
	AXIS_X,
	AXIS_X - AXIS_Y,
	AXIS_X - 2*AXIS_Y,
	-2*AXIS_Y,
	AXIS_X - 3*AXIS_Y,
]

const SPACE_NAMES = "0,1,2,3,4,5,6,7,8,9"

enum {
	SPACE_0,
	SPACE_1,
	SPACE_2,
	SPACE_3,
	SPACE_4,
	SPACE_5,
	SPACE_6,
	SPACE_7,
	SPACE_8,
	SPACE_9,
}

### TILES

const TILE_SIDE_NAMES = "A,B"

enum {
	TILE_SIDE_A,
	TILE_SIDE_B,
}

### PLAYER COLORS

const PLAYER_COLOR_NAMES = "None,Red,Blue,Green,Orange,Purple"

enum {
	PLAYER_COLOR_NONE
	PLAYER_COLOR_RED,
	PLAYER_COLOR_BLUE,
	PLAYER_COLOR_GREEN,
	PLAYER_COLOR_ORANGE,
	PLAYER_COLOR_PURPLE,
}

### FOCUS TYPES

const FOCUS_TYPE_NAMES = "Culture,Economy,Growth,Industry,Military,Science"

enum {
	FOCUS_TYPE_CULTURE,
	FOCUS_TYPE_ECONOMY,
	FOCUS_TYPE_GROWTH,
	FOCUS_TYPE_INDUSTRY,
	FOCUS_TYPE_MILITARY,
	FOCUS_TYPE_SCIENCE,
}

### TECH LEVELS

const TECH_LEVEL_NAMES = "none,1,2,3,4"

enum {
	TECH_LEVEL_NONE
	TECH_LEVEL_I,
	TECH_LEVEL_II,
	TECH_LEVEL_III,
	TECH_LEVEL_IV,
}

func upgrade_tech_level(tech_level):
	return min(tech_level+1,4)

### TERRAIN TYPES

const TERRAIN_TYPE_NAMES = "Grassland,Hills,Forest,Desert,Mountains,Water,Natural Wonder,None"

enum {
	TERRAIN_TYPE_GRASSLAND,
	TERRAIN_TYPE_HILLS,
	TERRAIN_TYPE_FOREST,
	TERRAIN_TYPE_DESERT,
	TERRAIN_TYPE_MOUNTAINS,
	TERRAIN_TYPE_WATER,
	TERRAIN_TYPE_NATURAL_WONDER,
	TERRAIN_TYPE_NONE,
}

const TERRAIN_TYPE_VALUES = [1,2,3,4,5,1,5,1,0]

func terrain_type_to_value(terrain_type):
	return TERRAIN_TYPE_VALUES[terrain_type]

const terrain_color = PoolColorArray([
	Color.darkseagreen,
	Color.olivedrab,
	Color.webgreen,
	Color.beige,
	Color.dimgray,
	Color.steelblue,
	Color.dimgray,
	Color.black,
])

### SPAWN TYPES

const SPAWN_TYPE_NAMES = "None,Resource,Barbarian,City State,Capital"

enum {
	SPAWN_TYPE_NONE,
	SPAWN_TYPE_RESOURCE,
	SPAWN_TYPE_BARBARIAN,
	SPAWN_TYPE_CITY_STATE,
	SPAWN_TYPE_CAPITAL,
}

const RESOURCE_NAMES = "Marble,Mercury,Oil,Diamond"

enum {
	SPAWN_RESOURCE_MARBLE,
	SPAWN_RESOURCE_MERCURY,
	SPAWN_RESOURCE_OIL,
	SPAWN_RESOURCE_DIAMOND,
}

const BARBARIAN_NAMES = "A,B,C,D,E,F,G,H,I,J,K"

enum {
	SPAWN_BARBARIAN_A,
	SPAWN_BARBARIAN_B,
	SPAWN_BARBARIAN_C,
	SPAWN_BARBARIAN_D,
	SPAWN_BARBARIAN_E,
	SPAWN_BARBARIAN_F,
	SPAWN_BARBARIAN_G,
	SPAWN_BARBARIAN_H,
	SPAWN_BARBARIAN_I,
	SPAWN_BARBARIAN_J,
	SPAWN_BARBARIAN_K,
}

const NATURAL_WONDER_NAMES = "Ha Long Bay,Crater Lake,Galapagos Islands,Pantanal,The Dead Sea,Cliffs of Dover,Gobustan,Mt. Everest,Grand Mesa,Mt. Kilimanjaro,Mato Tipila,Torres del Paine"

enum {
	NATURAL_WONDER_HA_LONG_BAY,
	NATURAL_WONDER_CRATER_LAKE,
	NATURAL_WONDER_GALAPAGOS_ISLANDS,
	NATURAL_WONDER_PANTANAL,
	NATURAL_WONDER_THE_DEAD_SEA,
	NATURAL_WONDER_CLIFFS_OF_DOVER,
	NATURAL_WONDER_GOBUSTAN,
	NATURAL_WONDER_MT_EVEREST,
	NATURAL_WONDER_GRAND_MESA,
	NATURAL_WONDER_MT_KILIMANJARO,
	NATURAL_WONDER_MATO_TIPILA,
	NATURAL_WONDER_TORRES_DEL_PAINE,
}

const CITY_STATE_NAMES = "Kumasi,Antananarivo,Mohenjo Daro,Kabul,Auckland,Seoul,Carthage,Palenque,Geneva,Buenos Aires,Akkad,Brussels"

enum {
	CITY_STATE_KUMASI,
	CITY_STATE_ANTANANARIVO,
	CITY_STATE_MOHENJO_DARO,
	CITY_STATE_KABUL,
	CITY_STATE_AUCKLAND,
	CITY_STATE_SEOUL,
	CITY_STATE_CARTHAGE,
	CITY_STATE_PALENQUE,
	CITY_STATE_GENEVA,
	CITY_STATE_BUENOS_AIRES,
	CITY_STATE_AKKAD,
	CITY_STATE_BRUSSELS,
}








