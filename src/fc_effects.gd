extends Node

const TERRAIN_DIFFICULTY_LEVEL  = -1

enum {
	OPTION_BY_NONE, # NO CHOICE
	OPTION_BY_PULSE_SPACES, # VARGS = [start_spaces,distance,path_details,target_details]
	OPTION_BY_ALL_SPACES,
}

enum {
	#CULTURE
	EFFECT_PLACE_CONTROL_TOKENS,
	EFFECT_STORE_CONTROL_TOKEN, # Remove the token and store a ref to it's space
	EFFECT_CONVERT_CONTROL_TOKENS,
	#ECONOMY
	EFFECT_MOVE_CARAVANS,
	EFFECT_EXCHANGE_RESOURCE,
	EFFECT_CAPITALISM,
	#GROWTH
	EFFECT_GROWTH_CHOICE,
	EFFECT_SELECT_DISTRICT_TO_BUILD,
	EFFECT_PLACE_DISTRICT,
	EFFECT_REINFORCE_CONTROL_TOKENS,
	#INDUSTRY
	EFFECT_INDUSTRY_CHOICE,
	EFFECT_SELECT_WONDER_TO_BUILD,
	EFFECT_SELECT_CITY_TO_BUILD_WONDER,
	EFFECT_PLACE_CITY,
	#MILITARY
	
	#SCIENCE
	
	#EVENT DIAL
	EFFECT_RESPAWN_BARBARIANS,
	EFFECT_MAKE_WONDERS_CHEAPER,
	EFFECT_BARBARIAN_MOVEMENT,
	EFFECT_RESOLVE_DISTRICTS,
	EFFECT_CHANGE_GOVERNMENTS,
	
}

enum {
	TYPE_CITY,
	TYPE_CITY_MATURE,
	TYPE_CITY_CAPITAL,
	TYPE_FRIENDLY_SPACE,
	TYPE_FRIENDLY_CONTROL_TOKEN,
	TYPE_FRIENDLY_UNREINFORCED_CONTROL_TOKEN
	TYPE_STORED_CONTROL_TOKEN,
}

enum {
	SPACE_DETAIL_CITY,
}

enum {
	PULSE_FROM_PLAYER_SELECTION,
	PULSE_FROM_CITIES,
	PULSE_FROM_FRIENDLY_SPACES,
	PULSE_FROM_ARMIES,
	PULSE_FROM_CARAVANS,
	PULSE_FROM_STORED_SPACE,
}

enum {
	NOT_HIGHER_TERRAIN,
	NOT_WATER,
	NOT_BARBARIAN,
	NOT_RIVAL_ARMY,
	NOT_RIVAL_CITY,
	NOT_RIVAL_CONTROL_TOKEN,
	NOT_RIVAL_REINFORCED_CONTROL_TOKEN,
}

enum {
	UNION,
	INTERSECTION,
}

enum {
	TAG_FRIENDLY,
	TAG_RIVAL,
	
	TAG_RESOURCE,
	TAG_CITY,
	TAG_MATURE,
	TAG_STATE,
	TAG_CONTROL_TOKEN,
	TAG_REINFORCED,
	TAG_DISTRICT,
	
	TAG_ARMY,
	TAG_CARAVAN,
	TAG_BARBARIAN,
	
	TAG_EMPTY,
}



const BASE_PATH = [NOT_HIGHER_TERRAIN,NOT_WATER,NOT_BARBARIAN]
const BASE_TARGET = [NOT_HIGHER_TERRAIN,NOT_WATER]
const EMPTY = []
const LEGAL_SPACE = []

const INVALID_FILTER_PLACE_CONTROL_TOKEN = [TAG_BARBARIAN,TAG_CITY,TAG_CONTROL_TOKEN]

func CULTURE_1():
	
	get_tree().get_nodes_in_group(gl.GROUP_CITY_SPACES)

const CULTURE_1 = [ # EARLY EMPIRE
	{	
		"effect" : EFFECT_PLACE_CONTROL_TOKENS,
		"choices" : 2,
		"option_fetch" : OPTION_BY_PULSE_SPACES,
		"option_vargs" : [ [PULSE_FROM_CITIES], 1, [], BASE_TARGET ],
		"filter" : {"logic":UNION, "valid":[], "invalid":INVALID_FILTER_PLACE_CONTROL_TOKEN},
	},
]

const CULTURE_2 = [ # DRAMA AND POETRY
	{	
		"effect" : EFFECT_PLACE_CONTROL_TOKENS,
		"choices" : 2,
		"option_fetch" : OPTION_BY_PULSE_SPACES,
		"option_vargs" : [ [PULSE_FROM_CITIES], 1, [], BASE_TARGET ],
		"filter" : {"logic":UNION, "valid":[], "invalid":INVALID_FILTER_PLACE_CONTROL_TOKEN},
	},
	{	
		"effect" : EFFECT_STORE_CONTROL_TOKEN,
		"choices" : 1,
		"option_fetch" : OPTION_BY_ALL_SPACES,
		"filter" : {"logic":INTERSECTION, "valid":[TAG_CONTROL_TOKEN,TAG_FRIENDLY], "invalid":[]},
	},
	{	
		"effect" : EFFECT_PLACE_CONTROL_TOKENS,
		"choices" : 1,
		"option_fetch" : OPTION_BY_PULSE_SPACES,
		"option_vargs" : [ [PULSE_FROM_STORED_SPACE], 1, [], BASE_TARGET ],
		"filter" : {"logic":UNION, "valid":[TAG_EMPTY], "invalid":[]},
	},
]

const CULTURE_3 = [ # CIVIL SERVICE
	{	
		"effect" : EFFECT_PLACE_CONTROL_TOKENS,
		"choices" : 2,
		"option_fetch" : OPTION_BY_PULSE,
		"option_vargs" : [ [PULSE_FROM_CITIES], 1, [], BASE_TARGET ],
		"filter" : {"valid":[], "invalid":INVALID_FILTER_PLACE_CONTROL_TOKEN},
	},
	{	
		"effect" : EFFECT_PLACE_CONTROL_TOKENS,
		"choices" : 1,
		"option_fetch" : OPTION_BY_PULSE,
		"option_vargs" : [ [PULSE_FROM_FRIENDLY_SPACES], 1, [], BASE_TARGET ],
		"filter" : {"valid":[], "invalid":INVALID_FILTER_PLACE_CONTROL_TOKEN},
	},
]

const CULTURE_4 = [ # MASS MEDIA
	{	
		"effect" : EFFECT_PLACE_CONTROL_TOKENS,
		"choices" : 3,
		"option_fetch" : OPTION_BY_PULSE,
		"option_vargs" : [ [PULSE_FROM_CITIES], 1, [], BASE_TARGET ],
		"filter" : {"valid":[], "invalid":INVALID_FILTER_PLACE_CONTROL_TOKEN},
	},
	{	
		"effect" : EFFECT_CONVERT_CONTROL_TOKENS,
		"choices" : 1,
		"option_fetch" : OPTION_BY_PULSE,
		"option_vargs" : [ [PULSE_FROM_FRIENDLY_SPACES], 2, [], BASE_TARGET ],
		"filter" : {"valid":[FILTER_RIVAL_CONTROL_TOKEN], "invalid":[]},
	},
]

#####################
###### ECONOMY ######
#####################


const ECONOMY_1 = [ # FOREIGN TRADE
	{	
		"effect" : EFFECT_MOVE_CARAVANS,
		"choices" : 1,
		"option_fetch" : OPTION_BY_PULSE,
		"option_vargs" : [ [PULSE_FROM_CARAVANS], 3, BASE_PATH, BASE_TARGET + [NOT_BARBARIAN] ],
		"filter" : {"valid":[], "invalid":[]},
	},
]

const ECONOMY_2 = [ # CURRENCY
	{	
		"effect" : EFFECT_MOVE_CARAVANS,
		"choices" : 2,
		"option_fetch" : OPTION_BY_PULSE,
		"option_vargs" : [ [PULSE_FROM_CARAVANS], 4, BASE_PATH, BASE_TARGET ],
		"filter" : {"valid":[], "invalid":[]},
	},
]

const ECONOMY_3 = [ # STEAM POWER
	{	
		"effect" : EFFECT_MOVE_CARAVANS,
		"choices" : 2,
		"option_fetch" : OPTION_BY_PULSE,
		"option_vargs" : [ [PULSE_FROM_CARAVANS], 6, [NOT_HIGHER_TERRAIN,NOT_BARBARIAN], BASE_TARGET + [NOT_BARBARIAN] ],
		"filter" : {"valid":[], "invalid":[]},
	},
	{	
		"effect" : EFFECT_EXCHANGE_RESOURCE,
		"choices" : 1,
		"option_fetch" : OPTION_BY_NONE,
		"option_vargs" : [],
		"filter" : {"valid":[], "invalid":[]},
	},
]

const ECONOMY_4 = [ # STEAM POWER
	{	
		"effect" : EFFECT_MOVE_CARAVANS,
		"choices" : 3,
		"option_fetch" : OPTION_BY_PULSE,
		"option_vargs" : [ [PULSE_FROM_CARAVANS], 6, [NOT_HIGHER_TERRAIN,NOT_BARBARIAN], BASE_TARGET + [NOT_BARBARIAN] ],
		"filter" : {"valid":[], "invalid":[]},
	},
	{	
		"effect" : EFFECT_CAPITALISM,
	},
]

#####################
####### GROWTH ######
#####################

const INVALID_FILTER_PLACE_DISTRICT = [FILTER_WATER,FILTER_BARBARIAN,FILTER_ANY_CITY,FILTER_RIVAL_CONTROL_TOKEN]

const GROWTH_1 = [
	{	"effect" : EFFECT_GROWTH_CHOICE},
	{	"effect" : EFFECT_SELECT_DISTRICT_TO_BUILD},
	{	
		"effect" : EFFECT_PLACE_DISTRICT,
		"choices" : 1,
		"option_fetch" : OPTION_BY_PULSE,
		"option_vargs" : [ [PULSE_FROM_CITIES], 1, [], BASE_TARGET ],
		"filter" : {"valid":[], "invalid":INVALID_FILTER_PLACE_DISTRICT},
	},
	{	
		"effect" : EFFECT_REINFORCE_CONTROL_TOKENS,
		"choices" : TERRAIN_DIFFICULTY_LEVEL,
		"option_fetch" : OPTION_BY_TYPE,
		"option_vargs" : [ TYPE_FRIENDLY_UNREINFORCED_CONTROL_TOKEN ],
		"filter" : {"valid":[], "invalid":[]},
	},
]

#####################
###### INDUSTRY #####
#####################

const INDUSTRY_1 = [
	{	"effect" : EFFECT_INDUSTRY_CHOICE},
	{	
		"effect" : EFFECT_SELECT_WONDER_TO_BUILD,
		"production" : TERRAIN_DIFFICULTY_LEVEL,
		"bonus" : +0,
	},
	{	
		"effect" : EFFECT_SELECT_CITY_TO_BUILD_WONDER,
		"choices" : 1,
		"option_fetch" : OPTION_BY_TYPE,
		"option_vargs" : [  ],
		"filter" : {"valid":[], "invalid":[]},
	},
]






















