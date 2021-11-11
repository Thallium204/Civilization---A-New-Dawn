tool
extends Node

var player = civ_player.new(Color.cornflower)

var map_stack = []

### SELECTED SPACE

var selected_space:civ_space = null

func _init():
	generate_map_stack()

func generate_map_stack():
	map_stack = [
		load("res://src/tiles/tile1.tscn"),
		load("res://src/tiles/tile2.tscn"),
		load("res://src/tiles/tile3.tscn"),
		load("res://src/tiles/tile4.tscn"),
		load("res://src/tiles/tile5.tscn"),
		load("res://src/tiles/tile6.tscn"),
	]

func make_selected(space:civ_space):
	if selected_space:
		selected_space.cmp_gui.is_space_selected = false
	selected_space = space
	if selected_space:
		selected_space.cmp_gui.is_space_selected = true

### CONTEXT SELECT

enum {
	CONTEXT_SELECT_NONE,
	CONTEXT_SELECT_CITY,
	CONTEXT_SELECT_CONTROL,
	CONTEXT_SELECT_MAP_BUILDER
}

var context_select = CONTEXT_SELECT_NONE setget set_context_select

func set_context_select(new_context_select):
	context_select = new_context_select
	make_selected(null)

func clicked(click,space):
	match context_select:
		CONTEXT_SELECT_NONE:
			make_selected(space)
		CONTEXT_SELECT_CITY:
			var city = gl.CITY_LOAD.instance()
			city.player_owner = player
			if not player.capital:
				city.is_capital = true
				player.capital = city
			space.add_structure(city)

enum {
	CLICK_LEFT,
	CLICK_RIGHT,
}
