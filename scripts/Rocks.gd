class_name Rocks extends Node2D

func _ready():
	var rocksClass = TakeRocksGenerator.new()
	add_child(rocksClass.get_rock())
	pass
