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
	if CONTEXT_CLICK_PULSE in [context_select,new_context_select]:
		RESET_OPTIMAL_PATHS()
	context_select = new_context_select
	SET_ALL_SPACE_SELECTABILITY(true)
	make_selected(null)

func clicked(click,space,space_selectable=true):
	match context_select:
		CONTEXT_CLICK_SELECT:
			if not space_selectable:
				return
			make_selected(space)
		CONTEXT_CLICK_PLACE_CITY:
			var city = player.get_city()
			if city:
				space.add_structure(city)
		CONTEXT_CLICK_PULSE:
			begin_pulse([space])



func SET_ALL_SPACE_SELECTABILITY(is_selectable):
	for space in get_tree().get_nodes_in_group(gl.GROUP_SPACES):
		space.cmp_gui.is_selectable = is_selectable


func RESET_OPTIMAL_PATHS():
	for space in get_tree().get_nodes_in_group(gl.GROUP_SPACES):
		if space is civ_space:
			space.optimal_path = []

func UPDATE_SPACE_NEIGHBOURS():
	var spaces = get_tree().get_nodes_in_group(gl.GROUP_SPACES)
	for space in spaces:
		if space is civ_space:
			space.update_space_neighbours()


var to_be_pulsed = []
var being_pulsed = []
var has_been_pulsed = []
var path_leaves = []

func begin_pulse(start_spaces):
	RESET_OPTIMAL_PATHS()
	SET_ALL_SPACE_SELECTABILITY(false)
	to_be_pulsed = []
	being_pulsed = []
	has_been_pulsed = start_spaces
	for start_space in has_been_pulsed:
		start_space.optimal_path = [start_space]
		start_space.cmp_gui.is_selectable = true
		get_neighbours_to_be_pulsed(start_space)
	
	var options = []
	for distance in pulse_distance:
		
		being_pulsed = to_be_pulsed.duplicate()
		to_be_pulsed = []
		
		for space in being_pulsed:
			if not space:
				continue
			
			#yield(get_tree().create_timer(0.5), "timeout")
			var is_valid_target = is_space_valid_target(space)
			var is_valid_path = is_space_valid_path(space)
			if is_valid_target:
				options.append(space)
				space.cmp_gui.is_selectable = true
			if is_valid_path:
				var branches = get_neighbours_to_be_pulsed(space,distance%2==0)
				if branches == 0 and not is_valid_target:
					path_leaves.append(space)
			if not is_valid_target and not is_valid_path:
				space.optimal_path = []
		
		has_been_pulsed += being_pulsed
	
	# cut new branches we don't have distance for
	for space in to_be_pulsed:
		space.optimal_path = []
	
	# cut path-ending branches (leaves)
	for space in path_leaves + being_pulsed:
		remove_end_paths(space.optimal_path)
	
	for start_space in start_spaces:
		start_space.cmp_gui.is_selected = true

func remove_end_paths(path):
	if path.empty():
		return
	var self_space = path[-1]
	if not is_space_valid_target(self_space):
		var previous_index = max(0,path.size()-1)
		var previous_space = path[previous_index]
		self_space.optimal_path = []
		remove_end_paths(previous_space.optimal_path)


func get_neighbours_to_be_pulsed(space:civ_space,anti_clock_wise=false):
	var accounted_for = has_been_pulsed + being_pulsed + to_be_pulsed
	var ordered_neighbours = space.space_neighbours
	if anti_clock_wise:
		ordered_neighbours.invert()
	var branches = 0
	for n_space in space.space_neighbours:
		if n_space and not n_space in accounted_for:
			n_space.optimal_path = space.optimal_path + [n_space]
			to_be_pulsed.append(n_space)
			branches += 1
	return branches

enum {
	CLICK_LEFT,
	CLICK_RIGHT,
}


func _unhandled_key_input(event):
	
	match event.scancode:
		KEY_1:
			
			player.cities
	


