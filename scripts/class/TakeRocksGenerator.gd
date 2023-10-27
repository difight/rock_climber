class_name TakeRocksGenerator extends Node

var test = preload("res://scenes/rocks/Rock.tscn")

var rocks = [
	preload("res://scenes/rocks/Rock.tscn"),
	preload("res://scenes/rocks/Rock2.tscn"),
	preload("res://scenes/rocks/Rock3.tscn"),
	preload("res://scenes/rocks/Rock4.tscn")
]

func get_rock():
	var randRockId = randi_range(0, len(rocks)-1)
	var rockScene = self.rocks[randRockId].instantiate()
	rockScene.init_key(self.get_free_key())
	return rockScene

func get_free_key():
	var randKey = randi_range(0, len(Variables.keyTakeFree)-1)
	return Variables.keyTakeFree[randKey]
