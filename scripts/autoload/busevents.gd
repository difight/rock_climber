extends Node

func get_rocks():
	return get_tree().get_nodes_in_group('rocks_take_free')

func _unhandled_key_input(event):
	for rock in get_rocks():
		if rock.get_key_code() == event.keycode:
			print_debug(rock, ' ', rock.get_key_code(), ' ', event.keycode)
			if event.is_pressed():
				rock.pressed_current_key(true)
			else:
				rock.pressed_current_key(false)
			break
