tool
extends StaticBody2D

var space:civ_space

var is_active = true setget set_is_active

var is_mouse_hovering:bool = false setget set_is_mouse_hovering
var is_space_selected:bool = false setget set_is_space_selected
var is_mouse_dragging:bool = false

func set_is_active(new_is_active):
	is_active = new_is_active
	$shape.disabled = not is_active

func set_is_mouse_hovering(new_is_mouse_hovering):
	is_mouse_hovering = new_is_mouse_hovering
	if not is_mouse_hovering:
		is_mouse_dragging = false
	space.update_sprite()


func set_is_space_selected(new_is_space_selected):
	is_space_selected = new_is_space_selected
	space.update_sprite()

func _on_area_drag_input_event(_viewport, event, _shape_idx):
	
	if is_mouse_hovering:
		if gl.edit_mode == gl.EDIT_MODE_SELECT:
			if event is InputEventMouseButton:
				if event.button_index == BUTTON_LEFT and event.pressed:
					left_clicked()
		elif gl.edit_mode == gl.EDIT_MODE_MOVE:
			if event is InputEventMouseButton:
				if event.button_index == BUTTON_LEFT:
					is_mouse_dragging = event.pressed
			elif event is InputEventMouseMotion:
				if is_mouse_dragging:
					position += event.relative * 0.3


func left_clicked():
	game.clicked(game.CLICK_LEFT,space)


