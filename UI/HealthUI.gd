extends Control

var hearts = 4 setget set_hearts
var max_hearts = 4 setget set_max_hearts

onready var heartUI_full = $HeartUI_Full
onready var heartUI_empty = $HeartUI_Empty

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts) # value cant be less than 0 and more that max_hearts
	if heartUI_full != null:
		heartUI_full.rect_size.x = hearts * 15 # 15 pixel wide for each heart

func set_max_hearts(value):
	max_hearts = max(value, 1) # max_hearts cant be less than 1
	self.hearts = min(hearts, max_hearts) # health cannot be larger than max_health 
	if heartUI_empty != null:
		heartUI_empty.rect_size.x = max_hearts * 15

func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	# warning-ignore:return_value_discarded
	PlayerStats.connect("health_changed", self, "set_hearts")
	# warning-ignore:return_value_discarded
	PlayerStats.connect("max_health_changed", self, "set_max_hearts")
