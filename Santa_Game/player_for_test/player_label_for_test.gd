extends Label

var player = null # 플레이어 객체를 참조하는 변수

func _ready():
	player = get_node("../player_for_test") # 플레이어 노드의 경로

func _process(_delta):
	if player != null:
		var hp_text = "HP: " + str(player.HP) # 체력 표시
		var speed_text = "Speed: " + str(player.speed) # 속도 표시
		self.text = hp_text + "\n" + speed_text # 두 변수를 줄바꿈으로 구분하여 표시
