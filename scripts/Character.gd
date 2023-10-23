class_name Character extends Node2D

signal unpressedTake(key:Key)

@onready var LeftHand:RigidBody2D = $LeftHand
@onready var RightHand:RigidBody2D = $RightHand
@onready var Tors:RigidBody2D = $Tors
@onready var Head:RigidBody2D = $Head
@onready var PinsNode:Node2D = get_tree().get_root().get_node('Root/Pins')
@onready var Rock:Node2D = get_tree().get_root().get_node('Root/Rock')


var currentTargetRock:Node2D
var goJump:bool = false
const PowerToTarget:float = 200.0

func _ready():
	Signals.unpressedTake.connect(unpressTakeRock)

func unpressTakeRock(hand):
	if hand and hand.rockTake:
		remove_pin(hand)

func _on_left_hand_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if find_target_rock() and find_target_rock() == body and LeftHand.get_free_hand():
		add_pin(LeftHand, currentTargetRock)

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_jump"):
		goJump = true

func _physics_process(delta):
	if find_target_rock() and (LeftHand.get_free_hand() or RightHand.get_free_hand()):
		currentTargetRock = find_target_rock()
		var nerestHand:RigidBody2D = find_nerest_hand(currentTargetRock)
		if nerestHand:
			nerestHand.apply_central_impulse(nerestHand.global_position.direction_to(currentTargetRock.global_position)*PowerToTarget)
	if goJump:
		Tors.apply_central_impulse(Vector2.UP * PowerToTarget * 20)
		goJump = false

func find_target_rock():
	for rock in Busevents.get_rocks():
		if rock.target and rock.takeHand == null:
			return rock.get_node('Rock')

func find_nerest_hand(rock:Node2D):
	var nerestHand:Node2D
	if rock:
		var nodeRock:Node2D = rock
		var positionRock = nodeRock.global_position
		var minDistance = 1000000000
		if LeftHand.get_free_hand():
			var positionHand = LeftHand.global_position
			minDistance = positionHand.distance_to(positionRock)
			nerestHand = LeftHand
		if RightHand.get_free_hand():
			var positionHand = RightHand.global_position
			if positionHand.distance_to(positionRock) < minDistance:
				nerestHand = RightHand
	return nerestHand

func add_pin(hand:RigidBody2D, rock:Node2D):
	var pin = PinJoint2D.new()
	pin.node_a = hand.get_path()
	pin.node_b = rock.get_path()
	pin.global_position = hand.connectedPosition
	PinsNode.add_child(pin)
	hand.add_connect_to_pin(pin)
	hand.take_rock(rock)
	rock.get_parent().take_rock()
	rock.get_parent().take_hand(hand)
	Rock.queue_free()

func remove_pin(hand:RigidBody2D):
	if hand.rockTake:
		var rock = hand.rockTake
		rock.get_parent().free_rock()
		rock.get_parent().take_hand(null)
		hand.free_hand()
		hand.connectPin.queue_free()
		hand.del_connect_to_pin()
		hand.free_hand()

func _on_right_hand_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if find_target_rock() and find_target_rock() == body and RightHand.get_free_hand():
		add_pin(RightHand, currentTargetRock)

