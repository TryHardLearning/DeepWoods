extends Node2D

var stateApple = false

var playerInArea = false

var apple = preload("res://scene/apple_colletable.tscn")

@export var item: InvItem

var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if !stateApple:
		$growth_timer.start(); 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !stateApple :
		$AnimatedSprite2D.play("no_apples")
	if stateApple:
		$AnimatedSprite2D.play("apples")
		if playerInArea:
			if Input.is_action_just_pressed("attack"):
				stateApple = false
				drop_apple()


func OnPickableAreaBodyEntered(body):
	if body.has_method("player"):
		playerInArea = true
		player = body


func OnPickableAreaBodyExited(body):
	if body.has_method("player"):
		playerInArea = false


func OnGrowthTimerTimeout():
	if !stateApple:
		stateApple = true

func drop_apple():
	var appleInstance = apple.instantiate()
	appleInstance.global_position = $Marker2D.global_position
	get_parent().add_child(appleInstance)
	
	##OK
	player.collect(item)
	await get_tree().create_timer(3).timeout
	$growth_timer.start();
