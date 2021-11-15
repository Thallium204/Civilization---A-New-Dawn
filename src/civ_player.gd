class_name civ_player
extends Resource

const MAX_CITIES = 8
var CITY_LOAD = preload("res://src/civ_city.tscn")
var cities = 0

const MAX_CONTROL_TOKENS = 34
var CONTROL_TOKEN_LOAD
var control_tokens = 34

var MAX_ARMIES = 1
var ARMY_LOAD
var armies = 0

var MAX_CARAVANS = 1
var CARAVAN_LOAD
var caravans = 0

var player_id:int = 0
var player_color:Color
var capital_city = null
var city_array = []

func add_city(city):
	city_array.append(city)
	cities += 1

func remove_city(city):
	city_array.erase(city)
	cities -= 1

func _init(color:Color):
	player_color = color

func get_city():
	if cities >= MAX_CITIES:
		return null
	var city = CITY_LOAD.instance()
	city.is_capital = city_array.empty()
	city.player_owner = self
	add_city(city)
	return city
