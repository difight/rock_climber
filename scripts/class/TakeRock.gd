class_name TakeRock extends Node2D

@export var keyCode:Key
var target:bool = false
var label:Label
const DEFAULT_COLOR_LABEL:Color = Color("White")
const PRESSED_COLOR_LABEL:Color = Color("Red")
const TAKED_GROUP = 'rocks_taked'
const FREE_GROUP = 'rocks_take_free'

func _ready():
	label = get_node('Label')
	label.text = str(OS.get_keycode_string(self.keyCode))
	
func pressed_current_key(pressed:bool = true):
	if pressed:
		label.label_settings.font_color = PRESSED_COLOR_LABEL
	else:
		label.label_settings.font_color = DEFAULT_COLOR_LABEL
	
func take_rock():
	self.add_to_group(TAKED_GROUP)
	self.remove_from_group(FREE_GROUP)

func free_rock():
	self.add_to_group(FREE_GROUP)
	self.remove_from_group(TAKED_GROUP)
