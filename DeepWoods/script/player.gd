extends CharacterBody2D

var speed = 100

var playerState

@export var inventory: Inventory

var bow_equiped = true
var bow_cooldown = true

var arrow = preload("res://scene/arrow.tscn")

var mause_loc_from_player = null

func _physics_process(delta):
	
	mause_loc_from_player = get_global_mouse_position() - self.position
	
	var direction = Input.get_vector("left","right","up","down");
	
	if direction.x == 0 and direction.y == 0 :
		playerState = "idle"
	
	elif  direction.x != 0 or direction.y != 0 :
		playerState = "walking"
	
	velocity = direction * speed
	move_and_slide()
	
	var mause_pos = get_global_mouse_position()
	$Marker2D.look_at(mause_pos)
	
	if Input.is_action_just_pressed("left_mause") and bow_equiped and bow_cooldown:
		bow_cooldown = false
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = $Marker2D.rotation
		arrow_instance.global_position = $Marker2D.global_position
		add_child(arrow_instance)
		
		await get_tree().create_timer(0.4).timeout
		bow_cooldown = true
	
	play_anim(direction)
	
func play_anim(dir):
	if playerState == "idle":
		$AnimatedSprite2D.play("idle");
	
	if playerState == "walking":
		if dir.y == -1:
			$AnimatedSprite2D.play("n-walk")
		if dir.x == 1:
			$AnimatedSprite2D.play("e-walk")
		if dir.y == 1:
			$AnimatedSprite2D.play("s-walk")
		if dir.x == -1:
			$AnimatedSprite2D.play("w-walk")
		
		if dir.x > 0.5 and dir.y < -0.5:
			$AnimatedSprite2D.play("ne-walk")
		if dir.x > 0.5 and dir.y > 0.5:
			$AnimatedSprite2D.play("se-walk")
		if dir.x < -0.5 and dir.y > 0.5:
			$AnimatedSprite2D.play("sw-walk")
		if dir.x < -0.5 and dir.y < -0.5:
			$AnimatedSprite2D.play("nw-walk")

func  player():
	pass
	
func collect(item):
	inventory.insert(item)
