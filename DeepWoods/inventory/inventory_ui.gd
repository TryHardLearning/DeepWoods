extends Control

var isOpen = false

@onready var inv = preload("res://inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

# Called when the node enters the scene tree for the first time.
func _ready():
	inv.update.connect(update_slots)
	update_slots()
	close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if isOpen:
			close()
		else:
			open()

func close():
	visible = false
	isOpen = false

func open():
	visible = true
	isOpen = true
