class_name civ_focus_card
tool
extends Node2D

var player_color = gl.PLAYER_COLOR_NONE setget set_player_color
var focus_type = gl.FOCUS_TYPE_CULTURE setget set_focus_type
var tech_level = gl.TECH_LEVEL_I setget set_tech_level

var slot = 0

var selected_funcref:FuncRef

var is_mouse_hovering setget set_is_mouse_hovering
var is_selected setget set_is_selected

func set_player_color(new_player_color):
	player_color = new_player_color
	update_skin()

func set_focus_type(new_focus_type):
	focus_type = new_focus_type
	update_skin()

func set_tech_level(new_tech_level):
	tech_level = new_tech_level
	update_skin()

func set_is_mouse_hovering(new_is_mouse_hovering):
	is_mouse_hovering = new_is_mouse_hovering
	$sprite.material.set_shader_param("is_mouse_hovering",is_mouse_hovering)

func set_is_selected(new_is_selected):
	is_selected = new_is_selected
	$sprite.material.set_shader_param("is_selected",is_selected)
	z_index = int(is_selected)

func toggle_selected():
	selected_funcref.call_func(self,not is_selected)

func update_skin():
	var player_name = gl.get_type_name_as_path(gl.PLAYER_COLOR_NAMES,player_color)
	var focus_name = gl.get_type_name_as_path(gl.FOCUS_TYPE_NAMES,focus_type)
	var tech_name = gl.get_type_name_as_path(gl.TECH_LEVEL_NAMES,tech_level)
	$sprite.texture = load("res://assets/focus cards/"+player_name+"/"+focus_name+tech_name+".png")

func _ready():
	update_skin()

func _on_area_input_event(_viewport, event, _shape_idx):
	
	# if we've clicked the card
	if event is InputEventMouseButton:
		
		# ignore release
		if not event.pressed:
			return
		
		# if left click
		if event.button_index == BUTTON_LEFT:
			
			toggle_selected()
