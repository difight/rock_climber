class_name TakeRock extends Node2D

signal unpressedTake(body:Node2D)

var keyCode:Key
var label:Label
var target:bool = false
var takeHand:RigidBody2D = null
const DEFAULT_COLOR_LABEL:Color = Color("White")
const PRESSED_COLOR_LABEL:Color = Color("Red")
const TAKED_GROUP = 'rocks_taked'
const FREE_GROUP = 'rocks_take_free'

func init_key(key:Key):
	print_debug(key)
	self.keyCode = key
	self.label = get_node("Label")
	self.change_text()

func change_text():
	label.text = str(OS.get_keycode_string(self.keyCode))

func pressed_current_key(pressed:bool = true):
	if pressed:
		label.modulate = PRESSED_COLOR_LABEL
	else:
		label.modulate = DEFAULT_COLOR_LABEL
		Signals.unpressedTake.emit(self.takeHand)
	target = pressed
	
func take_rock():
	self.add_to_group(TAKED_GROUP)
	self.remove_from_group(FREE_GROUP)

func free_rock():
	self.add_to_group(FREE_GROUP)
	self.remove_from_group(TAKED_GROUP)

func get_key_code():
	return self.keyCode

func take_hand(hand:RigidBody2D = null):
	self.takeHand = hand

func get_rock_size():
	return get_node("Rock/RockImg").get_rect().size
