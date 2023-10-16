class_name Character extends Node2D

@onready var LeftHand:RigidBody2D = $LeftHand
@onready var RightHand:RigidBody2D = $RightHand
@onready var Tors:RigidBody2D = $Tors
@onready var Head:RigidBody2D = $Head
@onready var PinsNode:Node2D = get_tree().get_root().get_node('Root/Pins')
@onready var Rock:Node2D = get_tree().get_root().get_node('Root/Rock')

var LeftHandTake = false
var RightHandTake = false
var LeftHandIsRock = false
var RightHandIsRock = false
var currentTargetRock:Node2D
var goToTarget:bool = false
var goJump:bool = false
const PowerToTarget:float = 300.0

func _init():
	print_debug('init character')


func _on_left_hand_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if goToTarget and body.is_in_group('rocks') and LeftHand.get_free_hand():
		add_pin(LeftHand, currentTargetRock)

func _unhandled_key_input(event):
#	if event.is_action_pressed("ui_take"):
#		if LeftHand.get_free_hand() or RightHand.get_free_hand():
#			goToTarget = true
#	if event.is_action_released("ui_take"):
#		goToTarget = false
#		if LeftHandTake:
#			remove_pin(LeftHand)
#		if RightHandTake:
#			remove_pin(RightHand)
	if event.is_action_pressed("ui_jump"):
		goJump = true
		

func _physics_process(delta):
	if goToTarget and (LeftHand.get_free_hand() or RightHand.get_free_hand()):
		currentTargetRock = get_target_rock()
		var nerestHand:RigidBody2D = find_nerest_hand(currentTargetRock)
		if nerestHand:
			nerestHand.apply_central_impulse(nerestHand.global_position.direction_to(currentTargetRock.global_position)*PowerToTarget)
	if goJump:
		Tors.apply_central_impulse(Vector2.UP * PowerToTarget * 20)
		goJump = false

func _on_left_hand_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group('rocks') and not goToTarget and LeftHand.get_free_hand():
		remove_pin(LeftHand)

func get_target_rock(key:String = 'rocks_take_free')-> Node2D:
	for n in get_tree().get_nodes_in_group(key):
		print_debug(n)
	return get_tree().get_first_node_in_group(key)

func find_nerest_rock(rock:Node2D):
	pass

func find_nerest_hand(rock:Node2D):
	var nerestHand:Node2D
	if rock:
		var nodeRock:Node2D = rock
		var positionRock = nodeRock.global_position
		var minDistance = 0
		if not LeftHandTake:
			var positionHand = LeftHand.global_position
			minDistance = positionHand.distance_to(positionRock)
			nerestHand = LeftHand
		if not RightHandTake:
			var positionHand = RightHand.global_position
			if positionHand.distance_to(positionRock) < minDistance:
				nerestHand = RightHand
	return nerestHand

func add_pin(hand:RigidBody2D, rock:Node2D):
	print_debug('add pin')
	var pin = PinJoint2D.new()
	pin.node_a = hand.get_path()
	pin.node_b = rock.get_node('Rock').get_path()
	pin.global_position = hand.connectedPosition
	rock.take_rock()
	PinsNode.add_child(pin)
	hand.add_connect_to_pin(pin)
	hand.take_rock(rock)
	if Rock:
		Rock.queue_free()

func remove_pin(hand:RigidBody2D):
	LeftHandTake = false
	if hand.rockTake:
		print_debug(hand.rockTake)
		hand.rockTake.free_rock()
		hand.connectPin.queue_free()
		hand.del_connect_to_pin()
		hand.free_hand()

func _on_right_hand_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group('rocks') && not RightHandIsRock:
		RightHandIsRock = body_rid
#	if RightHandIsRock and goToTarget:
#		add_pin(RightHand, currentTargetRock)
#		RightHandTake = true


func _on_right_hand_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group('rocks') and RightHandIsRock:
		RightHandIsRock = false
