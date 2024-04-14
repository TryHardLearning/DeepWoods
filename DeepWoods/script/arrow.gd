extends Area2D

var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta


func OnVisibleOnScreenEnabler2dScreenExited():
	queue_free()

func arrow_deal_damage():
	pass
