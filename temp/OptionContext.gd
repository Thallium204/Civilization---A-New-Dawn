extends VBoxContainer

func _ready():
	$OptionClick.add_item("SELECT SPACE",game.CONTEXT_CLICK_SELECT)
	$OptionClick.add_item("PLACE CITY",game.CONTEXT_CLICK_PLACE_CITY)
	$OptionClick.add_item("PULSE",game.CONTEXT_CLICK_PULSE)
	_on_OptionClick_item_selected(game.CONTEXT_CLICK_SELECT)


func _on_OptionClick_item_selected(index):
	game.context_select = index
	update_gui()



func update_gui():
	var is_pulse = game.context_select == game.CONTEXT_CLICK_PULSE
	$hboxDistance.visible = is_pulse
	$LabelPath.visible = is_pulse
	$hboxPath.visible = is_pulse
	$LabelTarget.visible = is_pulse
	$hboxTarget.visible = is_pulse



func _on_PathCheckWater_toggled(button_pressed):
	game.path_on_water = button_pressed


func _on_PathSlider_value_changed(value):
	game.path_strength = value
	$hboxPath/Label.text = str(value)




func _on_TargetCheckWater_toggled(button_pressed):
	game.target_on_water = button_pressed


func _on_TargetSlider_value_changed(value):
	game.target_strength = value
	$hboxTarget/Label.text = str(value)


func _on_SpinBox_value_changed(value):
	game.pulse_distance = value
