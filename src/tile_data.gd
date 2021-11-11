extends Node


var tile_data = {
	1:{
		gl.TILE_SIDE_A:{
			gl.SPACE_0:
				{
					"terrain_type" : gl.TERRAIN_TYPE_NATURAL_WONDER,
					"terrain_id"   : gl.NATURAL_WONDER_TORRES_DEL_PAINE,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_1:
				{
					"terrain_type" : gl.TERRAIN_TYPE_HILLS,
				},
			gl.SPACE_2:
				{
					"terrain_type" : gl.TERRAIN_TYPE_GRASSLAND,
				},
			gl.SPACE_3:
				{
					"terrain_type" : gl.TERRAIN_TYPE_DESERT,
				},
			gl.SPACE_4:
				{
					"terrain_type" : gl.TERRAIN_TYPE_HILLS,
				},
			gl.SPACE_5:
				{
					"terrain_type" : gl.TERRAIN_TYPE_MOUNTAINS,
				},
			gl.SPACE_6:
				{
					"terrain_type" : gl.TERRAIN_TYPE_MOUNTAINS,
					"spawn_type"   : gl.SPAWN_TYPE_BARBARIAN,
					"spawn_id"     : gl.SPAWN_BARBARIAN_A
				},
			gl.SPACE_7:
				{
					"terrain_type" : gl.TERRAIN_TYPE_MOUNTAINS,
				},
			gl.SPACE_8:
				{
					"terrain_type" : gl.TERRAIN_TYPE_MOUNTAINS,
					"spawn_type"   : gl.SPAWN_TYPE_RESOURCE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_9:
				{
					"terrain_type" : gl.TERRAIN_TYPE_WATER,
				},
		},
		gl.TILE_SIDE_B:{
			gl.SPACE_0:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_1:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_2:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_3:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_4:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_5:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_6:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_7:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_8:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_9:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
		},
	}
	
	2:{
		gl.TILE_SIDE_A:{
			gl.SPACE_0:
				{
					"terrain_type" : gl.TERRAIN_TYPE_NATURAL_WONDER,
					"terrain_id"   : gl.NATURAL_WONDER_TORRES_DEL_PAINE,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_1:
				{
					"terrain_type" : gl.TERRAIN_TYPE_MOUNTAINS,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_2:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_3:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_4:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_5:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_6:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_7:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_8:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_9:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
		},
		gl.TILE_SIDE_B:{
			gl.SPACE_0:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_1:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_2:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_3:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_4:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_5:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_6:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_7:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_8:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
			gl.SPACE_9:
				{
					"terrain_type" : gl.TERRAIN_TYPE_,
					"terrain_id"   : gl.NATURAL_WONDER_HA_LONG_BAY,
					"spawn_type"   : gl.SPAWN_TYPE_NONE,
					"spawn_id"     : gl.SPAWN_RESOURCE_MARBLE
				},
		},
	}
}
