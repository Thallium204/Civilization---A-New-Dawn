extends Node2D

onready var camera:Camera2D = get_node("../camera")

var prepared_tile:civ_tile
var rng = RandomNumberGenerator.new()

func _process(delta):
	
	var mouse_pos = camera.position + (get_tree().get_root().get_mouse_position() - get_tree().get_root().size + Vector2(425,240)) * camera.zoom
	position = mouse_pos
	position = gl.snap_to_hex_grid(position)


func _ready():
	prepare_tile()


func _input(event):
	
	if event is InputEventKey:
		
		if event.scancode == KEY_Q and event.pressed:
			$sprite.rotation_degrees -= 60
		elif event.scancode == KEY_E and event.pressed:
			$sprite.rotation_degrees += 60
	
	elif event is InputEventMouseButton:
		
		if event.button_index == BUTTON_LEFT and event.pressed:
			spawn_tile()

func prepare_tile():
	var tile_load = gl.tile_scenes[rng.randi_range(0,0)]
	prepared_tile = tile_load.instance()
	$sprite.add_child(prepared_tile)

func spawn_tile():
	var copy = prepared_tile.duplicate(true)
	copy.position = position
	copy.rotation_degrees = $sprite.rotation_degrees
	prepared_tile.queue_free()
	get_parent().add_child(copy)
	#prepare_tile()






