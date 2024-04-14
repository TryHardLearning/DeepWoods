extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/Label

func update(slot: InvSlot):
	if !slot.Item:
		item_visual.visible = false
		amount_text.visible = false
	else:
		item_visual.visible = true
		amount_text.visible = true
		amount_text.text = str(slot.amount)
		item_visual.texture = slot.Item.texture

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
