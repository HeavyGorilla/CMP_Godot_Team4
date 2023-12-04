extends Label

var player = null # 플레이어 객체를 참조하는 변수
var boss = null

func _ready():
	player = get_node("../player_for_test")
	boss = get_node ("../boss")
	
func _process(_delta):
	if player != null:
		var boss_hp_text = "Boss HP: " + str(boss.HP)
		self.text = boss_hp_text
