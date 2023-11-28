extends Area2D

# 플레이어가 시야 범위 내에 들어왔을 때 호출
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		print("플레이어 감지됨!")
		# 여기에 추가적인 로직을 구현 (게임 오버 처리)
