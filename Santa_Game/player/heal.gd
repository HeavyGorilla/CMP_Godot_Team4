extends Area2D

func  _process(delta):
	print($"../Timer".time_left)


func _on_timer_timeout():
	$"../main2/Player".speed -= 200


func _on_body_entered(body):
	if body.is_in_group("player"):
		$"../Timer".start()
		$"../healsound".play()
		$"../main2/Player".health = 100
		$"../main2/Player".speed += 200
		queue_free()
