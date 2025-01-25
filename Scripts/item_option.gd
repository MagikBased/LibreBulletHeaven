extends ColorRect

var mouse_over = false
var item = null
@onready var player = get_tree().get_first_node_in_group("player")
@onready var LabelName = $Label_Name
@onready var LabelDescription = $Label_Description
@onready var LabelLevel = $Label_Level
@onready var itemIcon = $ColorRect/ItemIcon

signal selected_upgrade(upgrade)

func _ready():
	connect("selected_upgrade",Callable(player,"upgrade_character"))
	if item == null:
		item="food"
	LabelName.text = UpgradeDb.UPGRADES[item]["displayname"]
	LabelDescription.text = UpgradeDb.UPGRADES[item]["details"]
	LabelLevel.text = UpgradeDb.UPGRADES[item]["level"]
	itemIcon.texture = load(UpgradeDb.UPGRADES[item]["icon"])
	
func _input(event):
	if event.is_action("click"):
		if mouse_over:
			emit_signal("selected_upgrade",item)

func _on_mouse_entered():
	mouse_over = true


func _on_mouse_exited():
	mouse_over = false
