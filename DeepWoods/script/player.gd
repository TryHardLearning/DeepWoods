extends CharacterBody2D

@export var inventory: Inventory

@export var max_hp = 180
@export var hp = max_hp
@export var strength = 5
@export var speed = 80
@export var magic = 8
@export var level = 1

var experence = 0
var experince_total = 0;
var experince_required = get_requered_experince(level + 1)

func get_requered_experince(level):
	return round(pow(level, 1.8) + level * 4)

func gain_experience(amount):
	experince_total += amount
	experence +=amount
	while experence >= experince_required:
		experence -= experince_required
		level_up()

func playerTakeDamage(amount):
	hp -=amount
	if(hp <= 0):
		queue_free()

func level_up():
	level +=1
	experince_required = get_requered_experince(level +1)
	
	var stats =["max_hp", "strength", "magic"]
	var random_stat = stats[randi() % stats.size()]
	set(random_stat, get(random_stat) + randi() % 5 + 2)
	magic += 5
	max_hp += 10
	strength += 5
	hp = max_hp

func expose_stats():
	$Camera2D/Level.text = "Level: " + str(level)
	$Camera2D/Magic.text = "Magic: " + str(magic)
	$Camera2D/Strenght.text = "Strength: " + str(strength)
	$Camera2D/Life.text = "Life: "+ str(hp)+ " / "+ str(max_hp)

var playerState

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
	expose_stats()

func playerDamage():
	return int((25 + strength) * ((strength / 100.0) + 1))

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
