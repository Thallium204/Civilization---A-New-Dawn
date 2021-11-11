tool
extends Node

var player = civ_player.new(Color.cornflower)

var MAP_STACK = [
	load("res://src/tiles/tile1.tscn"),
	load("res://src/tiles/tile2.tscn"),
	load("res://src/tiles/tile3.tscn"),
	load("res://src/tiles/tile4.tscn"),
	load("res://src/tiles/tile5.tscn"),
	load("res://src/tiles/tile6.tscn"),
	load("res://src/tiles/tile8.tscn"),
	load("res://src/tiles/tile10.tscn"),
	load("res://src/tiles/tile12.tscn"),
	load("res://src/tiles/tile13.tscn"),
	load("res://src/tiles/tile14.tscn"),
	load("res://src/tiles/tile15.tscn"),
	load("res://src/tiles/tile18.tscn"),
	load("res://src/tiles/tile19.tscn"),
	load("res://src/tiles/tile20.tscn"),
	load("res://src/tiles/tile21.tscn"),
]

var MAP_CAPITAL_STACK = [
	load("res://src/tiles/tile7.tscn"),
	load("res://src/tiles/tile9.tscn"),
	load("res://src/tiles/tile11.tscn"),
	load("res://src/tiles/tile16.tscn"),
	load("res://src/tiles/tile17.tscn"),
]

var current_map_stack = []
var current_map_capital_stack = []

### SELECTED SPACE

var selected_space:civ_space = null

func _init():
	reset_map_stacks()

func reset_map_stacks():
	current_map_stack = MAP_STACK.duplicate()
	current_map_capital_stack = MAP_CAPITAL_STACK.duplicate()

func make_selected(space:civ_space):
	if selected_space:
		selected_space.cmp_gui.is_selected = false
	if selected_space == space:
		return
	selected_space = space
	if selected_space:
		selected_space.cmp_gui.is_selected = true

### CONTEXT SELECT

enum {
	CONTEXT_CLICK_SELECT,
	CONTEXT_CLICK_PLACE_CITY,
	CONTEXT_CLICK_PULSE,
}

var pulse_distance = 2

var path_strength = 1
var path_on_water = false

func is_space_valid_path(space):
	if gl.terrain_type_to_value(space.terrain_type) <= path_strength:
		if (space.terrain_type != gl.TERRAIN_TYPE_WATER or path_on_water):
			return true
	return false


var target_strength = 1
var target_on_water = false

func is_space_valid_target(space):
	if gl.terrain_type_to_value(space.terrain_type) <= target_strength:
		if (space.terrain_type != gl.TERRAIN_TYPE_WATER or target_on_water):
			return true
	return false

var context_select = CONTEXT_CLICK_SELECT setget set_context_select

func set_context_select(new_context_select):
	context_select = new_context_select
	SET_ALL_SPACE_SELECTABILITY(true)
	make_selected(null)

func clicked(click,space,space_selectable):
	match context_select:
		CONTEXT_CLICK_SELECT:
			if not space_selectable:
				return
			make_selected(space)
		CONTEXT_CLICK_PLACE_CITY:
			if not space_selectable:
				return
			var city = gl.CITY_LOAD.instance()
			city.player_owner = player
			if not player.capital:
				city.is_capital = true
				player.capital = city
			space.add_structure(city)
		CONTEXT_CLICK_PULSE:
			make_selected(space)
			begin_pulse(space)

func SET_ALL_SPACE_SELECTABILITY(is_selectable):
	for space in get_tree().get_nodes_in_group("space"):
		space.cmp_gui.is_selectable = is_selectable

var to_be_pulsed = []
var being_pulsed = []
var has_been_pulsed = []

func begin_pulse(start_space:civ_space):
	SET_ALL_SPACE_SELECTABILITY(false)
	to_be_pulsed = [start_space]
	being_pulsed = []
	has_been_pulsed = []
	
	var options = []
	for distance in pulse_distance+1:
		
		being_pulsed = to_be_pulsed.duplicate()
		to_be_pulsed = []
		
		for space in being_pulsed:
			space.cmp_gui.is_selected = true
			yield(get_tree().create_timer(0.03), "timeout")
			if is_space_valid_target(space):
				options.append(space)
				space.cmp_gui.is_selectable = true
				if distance != pulse_distance:
					get_neighbours_to_be_pulsed(space)
			elif is_space_valid_path(space):
				if distance != pulse_distance:
					get_neighbours_to_be_pulsed(space)
			space.cmp_gui.is_selected = false
		
		has_been_pulsed += being_pulsed
	
	print("options: ",options)


func get_neighbours_to_be_pulsed(space:civ_space):
	var accounted_for = has_been_pulsed + to_be_pulsed
	for n_space in space.space_neighbours:
		if n_space and not n_space in accounted_for:
			to_be_pulsed.append(n_space)

enum {
	CLICK_LEFT,
	CLICK_RIGHT,
}





