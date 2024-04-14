extends Resource

class_name Inventory

signal update

@export var slots: Array[InvSlot]

func insert(item: InvItem):
	print("Insert", item)
	var itemSlots = slots.filter(func (slot): return slot.Item == item)
	if !itemSlots.is_empty():
		itemSlots[0].amount += 1
		print("More", itemSlots[0].amount);
	else:
		print("Entrouu")
		var emptySlots = slots.filter(func (slot): return slot.Item == null)
		if !emptySlots.is_empty():
			print("IS Empty");
			emptySlots[0].Item = item
			emptySlots[0].amount += 1
			print("More", emptySlots[0].Item);
	print("Signal");
	update.emit()
