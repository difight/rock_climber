extends Node


func get_rocks():
	return get_tree().get_nodes_in_group('rock_take')

func _unhandled_key_input(event):
	for rock in get_rocks():
		if rock.get_key_code() == event.keycode:
			if event.is_pressed():
				rock.pressed_current_key()
			else:
				rock.pressed_current_key(false)
			break
