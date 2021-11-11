extends Control

const MOVE_SPEED = 0.5
const TAB_SPEED = 0.2

onready var active_y = 726
onready var deactive_y = 726 + (714)*0.8

var focus_card_load = preload("res://CardUI/FocusCard.tscn")

var card_positions = PoolVector2Array()
var focus_row = [null,null,null,null,null,null]
var selected_card:civ_focus_card = null

func change_selected_card(new_selected_card,to_be_selected):
	if to_be_selected:
		if selected_card:
			selected_card.is_selected = false
		selected_card = new_selected_card
		selected_card.is_selected = true
	else:
		if selected_card:
			selected_card.is_selected = false
		selected_card = null
	
	update_UI()

func update_UI():
	$BtnSelect.disabled = false if selected_card else true
	$BtnSelect.visible = true if selected_card else false

func _ready():
	add_cards()
	update_UI()
	transition_tab(false)

func add_cards():
	
	# Remove any preexisting focus cards
	for child in get_children():
		if child is civ_focus_card:
			child.queue_free()
	
	# Add new focus cards
	for slot in 6:
		var focus_card:civ_focus_card = focus_card_load.instance()
		
		focus_card.slot = slot
		focus_card.focus_type = slot
		focus_card.selected_funcref = funcref(self,"change_selected_card")
		
		focus_row[slot] = focus_card
		add_child(focus_card)

func position_cards():
	for card_slot in focus_row.size():
		var focus_card = focus_row[card_slot]
		focus_card.position = slot_to_pos(card_slot)

func transition_cards():
	for card_slot in focus_row.size():
		var focus_card = focus_row[card_slot]
		$TweenCard.interpolate_property(
			focus_card, "position",
			null, slot_to_pos(card_slot),
			MOVE_SPEED, Tween.TRANS_LINEAR, Tween.EASE_IN
		)
	$TweenCard.start()


func position_tab(is_active):
	if is_active:
		rect_position.y = active_y
	else:
		rect_position.y = deactive_y

func transition_tab(is_active):
	if is_active:
		$TweenTab.interpolate_property(self,"rect_position:y",null,active_y,TAB_SPEED,Tween.TRANS_LINEAR,Tween.EASE_IN)
		$TweenTab.start()
	elif not selected_card:
		$TweenTab.interpolate_property(self,"rect_position:y",null,deactive_y,TAB_SPEED,Tween.TRANS_LINEAR,Tween.EASE_IN)
		$TweenTab.start()


func slot_to_pos(slot:int) -> Vector2:
	return card_positions[slot]

func _on_CardOrder_item_rect_changed():
	set_card_positions()
	rescale_area()

func set_card_positions():
	card_positions = PoolVector2Array()
	var step_x = rect_size.x / 6.0
	var step_y = rect_size.y/2.0
	for slot in 6:
		card_positions.append(Vector2( (slot+0.5)*step_x , step_y ))
	position_cards()

func rescale_area():
	$area/shape.position = rect_size/2.0
	$area/shape.shape.extents = rect_size/2.0



func _on_BtnSelect_pressed():
	reset_card(selected_card)

func reset_card(focus_card):
	move_card(focus_card,0)

func move_card(focus_card_to_move,slot_to_move_to):
	change_selected_card(selected_card,false)
	var new_focus_row = []
	var shift = 0
	for slot in focus_row.size():
		var focus_card = focus_row[slot+shift]
		if slot == slot_to_move_to:
			new_focus_row.append(focus_card_to_move)
			shift -= 1
			continue
		if focus_card == focus_card_to_move:
			shift += 1
			focus_card = focus_row[slot+shift]
		new_focus_row.append(focus_card)
	focus_row = new_focus_row
	transition_cards()
	


func _on_area_mouse_entered():
	transition_tab(true)


func _on_area_mouse_exited():
	transition_tab(false)
