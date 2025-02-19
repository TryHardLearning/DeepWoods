extends CharacterBody2D

var speed = 55

var health = 100

var dead = false

var playerInArea = false

var player

var player_damage = 25

@onready var slime = $slime_collctable
@export var itemRes: InvItem 

func _physics_process(delta):
	if !dead:
		$detection_area/CollisionShape2D.disabled = false
		if playerInArea:
			position += (player.position - position) / speed
			$AnimatedSprite2D.play("move")
		else:
			$AnimatedSprite2D.play("idle")
	if dead:
		$detection_area/CollisionShape2D.disabled = true




func OnDetectionAreaBodyEntered(body):
	if body.has_method("player"):
		playerInArea = true
		player = body
		player_damage = player.playerDamage()
		player.playerTakeDamage(30)


func OnDetectionAreaBodyExited(body):
	if body.has_method("playerTakeDamage"):
		playerInArea = false
		player = body
		player.playerTakeDamage(10)
		if(health <= 0):
			player.gain_experience(50)


func OnHitboxAreaEntered(area):
	var damage = 0
	
	if area.has_method("arrow_deal_damage"):
		damage = 25
		take_damage(player_damage)
		
func take_damage(damage):
	health -= damage
	
	if health <= 0 and !dead:
		death()

func death():
	dead = true
	$AnimatedSprite2D.play("death")
	await get_tree().create_timer(1).timeout
	drop_slime()
	
	$AnimatedSprite2D.visible = false
	$hitbox/CollisionShape2D.disabled = true
	$detection_area/CollisionShape2D.disabled = true


func drop_slime():
	slime.visible = true
	slime_collect()
	

func slime_collect():
	await get_tree().create_timer(1.5).timeout
	slime.visible = false
	player.collect(itemRes)
	queue_free()
