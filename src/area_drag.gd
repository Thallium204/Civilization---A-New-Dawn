tool
extends StaticBody2D

var space:civ_space

var is_active = true setget set_is_active
func set_is_active(new_is_active):
	is_active = new_is_active
	$shape.disabled = not is_active

var is_mouse_hovering:bool = false setget set_is_mouse_hovering
func set_is_mouse_hovering(new_is_mouse_hovering):
	is_mouse_hovering = new_is_mouse_hovering
	if not is_mouse_hovering:
		is_mouse_dragging = false
	update_gui()

# selectability

var is_selectable:bool = true setget set_is_selectable
func set_is_selectable(new_is_selectable):
	is_selectable = new_is_selectable
	update_gui()

var is_selected:bool = false setget set_is_selected
func set_is_selected(new_is_selected):
	is_selected = new_is_selected
	update_gui()

var is_mouse_dragging:bool = false

onready var sprite_unselectable = $sprite_unselectable
onready var sprite_hover = $sprite_hover
onready var sprite_outline = $sprite_outline


func _ready():
	randomize()
	#is_selectable = bool(round(rand_range(0,1)))
	sprite_unselectable.visible = false
	sprite_hover.visible = false
	sprite_outline.visible = false
	update_gui()

func update_gui():
	sprite_hover.visible = is_mouse_hovering
	z_index = int(is_selectable) + int(is_selected)
	get_parent().modulate = $sprite_unselectable.modulate if not is_selectable else Color.white
	sprite_outline.visible = is_selected

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
	game.clicked(game.CLICK_LEFT,space,is_selectable)


