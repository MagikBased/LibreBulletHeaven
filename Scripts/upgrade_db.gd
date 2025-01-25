extends Node

const ICON_PATH= "res://Sprites/Weapons/"
const WEAPON_PATH = "res://Sprites/Upgrades/"
const UPGRADES = {
	"basicattack1": {
		"icon": WEAPON_PATH + "gear.png",
		"displayname": "Basic Attack",
		"details": "Sends out a basic attack",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"basicattack2": {
		"icon": WEAPON_PATH + "gear.png",
		"displayname": "Basic Attack",
		"details": "Upgrade your basic attack",
		"level": "Level: 2",
		"prerequisite": ["basicattack1"],
		"type": "weapon"
	},
	"basicattack3": {
		"icon": WEAPON_PATH + "gear.png",
		"displayname": "Basic Attack",
		"details": "Upgrade your basic attack",
		"level": "Level: 3",
		"prerequisite": ["basicattack2"],
		"type": "weapon"
	},
	"basicattack4": {
		"icon": WEAPON_PATH + "gear.png",
		"displayname": "Basic Attack",
		"details": "Upgrade your basic attack",
		"level": "Level: 4",
		"prerequisite": ["basicattack3"],
		"type": "weapon"
	},
	"armor1": {
		"icon": ICON_PATH + "helmet.png",
		"displayname": "Armor",
		"details": "Reduces Damage By 1",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"armor2": {
		"icon": ICON_PATH + "helmet.png",
		"displayname": "Armor",
		"details": "Reduces Damage By 1",
		"level": "Level: 2",
		"prerequisite": ["armor1"],
		"type": "upgrade"
	},
	"armor3": {
		"icon": ICON_PATH + "helmet.png",
		"displayname": "Armor",
		"details": "Reduces Damage By 1",
		"level": "Level: 3",
		"prerequisite": ["armor2"],
		"type": "upgrade"
	},
	"armor4": {
		"icon": ICON_PATH + "helmet.png",
		"displayname": "Armor",
		"details": "Reduces Damage By 1",
		"level": "Level: 4",
		"prerequisite": ["armor3"],
		"type": "upgrade"
	},
	"speed1": {
		"icon": ICON_PATH + "boot.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased by 50% of base speed",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"speed2": {
		"icon": ICON_PATH + "boot.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased by an additional 50% of base speed",
		"level": "Level: 2",
		"prerequisite": ["speed1"],
		"type": "upgrade"
	},
	"speed3": {
		"icon": ICON_PATH + "boot.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased by an additional 50% of base speed",
		"level": "Level: 3",
		"prerequisite": ["speed2"],
		"type": "upgrade"
	},
	"speed4": {
		"icon": ICON_PATH + "boot.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased an additional 50% of base speed",
		"level": "Level: 4",
		"prerequisite": ["speed3"],
		"type": "upgrade"
	},
	"food": {
		"icon": WEAPON_PATH + "food.png",
		"displayname": "Food",
		"details": "Heals you",
		"level": "N/A",
		"prerequisite": [],
		"type": "item"
	}
}
