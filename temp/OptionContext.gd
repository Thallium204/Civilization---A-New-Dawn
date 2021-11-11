extends OptionButton

func _ready():
	add_item("NONE",game.CONTEXT_SELECT_NONE)
	add_item("CITY",game.CONTEXT_SELECT_CITY)
	add_item("CONTROL",game.CONTEXT_SELECT_CONTROL)
	add_item("Map Builder",game.CONTEXT_SELECT_MAP_BUILDER)
	_on_OptionContext_item_selected(game.CONTEXT_SELECT_NONE)



func _on_OptionContext_item_selected(index):
	game.context_select = index
