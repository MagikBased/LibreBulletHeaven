extends CharacterBody2D

var move_speed = 40.0
var hp = 80
var maxhp = 80
var experience = 0
var experience_level = 1
var collected_experience = 0
var time = 0

var basicAttack = preload("res://Scenes/basic_attack.tscn")

@onready var basicTimer = get_node("%BasicTimer")
@onready var basicAttackTimer = get_node("%BasicAttackTimer")
@onready var exp_bar = get_node("%Experience_Bar")
@onready var label_level = get_node("%Label_Level")
@onready var levelPanel = get_node("%Layout_LevelUp")
@onready var upgradeOptions = get_node("%Vbox_Upgrades")
@onready var itemOptions = preload("res://Scenes/item_option.tscn")
@onready var healthBar = get_node("%HealthBar")
@onready var lblTimer = get_node("%lblTimer")
@onready var deathPanel = get_node("%DeathPanel")

var collected_upgrades = []
var upgrade_options = []
var armor = 0
var speed = 0
var spell_cooldown = 0
var spell_size = 0
var additional_attacks = 0


var basicAttack_ammo = 0
var basicAttack_baseAmmo = 1
var basicAttack_attackSpeed = 1.5
var basicAttack_level = 1

var enemy_close = []

func _ready():
	attack()
	_on_hurt_box_hurt(0,0,0)
	set_exp_bar(experience,calculate_experience_cap())


func _physics_process(_delta):
	movement()

func attack():
	if basicAttack_level > 0:
		basicTimer.wait_time = basicAttack_attackSpeed* (1-spell_cooldown)
		if basicTimer.is_stopped():
			basicTimer.start()
		

func movement():
	var mov = Input.get_vector("left","right","up","down")
	velocity = mov.normalized()*move_speed
	move_and_slide()


func _on_hurt_box_hurt(damage,_angle, _knockback):
	hp -= clamp(damage-armor,1.0,999.0)
	healthBar.max_value = maxhp
	healthBar.value = hp
	if hp <= 0:
		death()

func _on_basic_timer_timeout():
	basicAttack_ammo += basicAttack_baseAmmo + additional_attacks
	basicAttackTimer.start()


func _on_basic_attack_timer_timeout():
	if basicAttack_ammo > 0:
		var basicAttack_attack = basicAttack.instantiate()
		basicAttack_attack.target = get_node("Reticle").global_position
		basicAttack_attack.level = basicAttack_level
		add_child(basicAttack_attack)
		basicAttack_ammo -= 1
		if basicAttack_ammo > 0:
			basicAttackTimer.start()
		else:
			basicAttackTimer.stop()

func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self

func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		var gem_experience = area.collect()
		calculate_experience(gem_experience)

func calculate_experience(gem_experience):
	var exp_required = calculate_experience_cap()
	collected_experience += gem_experience
	if experience + collected_experience >= exp_required:
		collected_experience -= exp_required - experience
		experience_level += 1
		experience = 0
		exp_required = calculate_experience_cap()
		levelup()
	else:
		experience += collected_experience
		collected_experience = 0
	set_exp_bar(experience,exp_required)

func calculate_experience_cap():
	var exp_cap = experience_level
	if experience_level < 20:
		exp_cap = experience_level * 5
	elif experience_level < 40:
		exp_cap = 95 * (experience_level-19) * 8
	else:
		exp_cap = 255 + (experience_level-39) * 12
	return exp_cap

func set_exp_bar(set_value = 1, set_max_value = 100):
	exp_bar.value = set_value
	exp_bar.max_value = set_max_value

func levelup():
	label_level.text = str("Level: ",experience_level)
	levelPanel.visible = true
	var options = 0
	var optionsmax = 3
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	while options < optionsmax:
		var option_choice = itemOptions.instantiate()
		option_choice.item = get_random_item()
		upgradeOptions.add_child(option_choice)
		options += 1
	get_tree().paused = true

func upgrade_character(upgrade):
	match upgrade:
		"basicattack1":
			basicAttack_level = 1
			additional_attacks += 1
			basicAttack_baseAmmo += 1
		"basicattack2":
			basicAttack_level = 2
			additional_attacks += 1
			basicAttack_baseAmmo += 1
		"basicattack3":
			basicAttack_level = 3
			additional_attacks += 1
		"basicattack4":
			basicAttack_level = 4
			basicAttack_baseAmmo += 2
		
		"armor1","armor2","armor3","armor4":
			armor += 1
		"speed1","speed2","speed3","speed4":
			move_speed += 20.0
		"tome1","tome2","tome3","tome4":
			spell_size += 0.10
		"scroll1","scroll2","scroll3","scroll4":
			spell_cooldown += 0.05

		"food":
			hp += 20
			hp = clamp(hp,0,maxhp)
	var option_children = upgradeOptions.get_children()
	for i in option_children:
		i.queue_free()
	upgrade_options.clear()
	collected_upgrades.append(upgrade)
	levelPanel.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_tree().paused = false
	calculate_experience(0)

func get_random_item():
	var dblist = []
	for i in UpgradeDb.UPGRADES:
		if i in collected_upgrades: #Find already collected upgrades
			pass
		elif i in upgrade_options: #If the upgrade is already an option
			pass
		elif UpgradeDb.UPGRADES[i]["type"] == "item": #Don't pick food
			pass
		elif UpgradeDb.UPGRADES[i]["prerequisite"].size() > 0: #Check for PreRequisites
			var to_add = true
			for n in UpgradeDb.UPGRADES[i]["prerequisite"]:
				if not n in collected_upgrades:
					to_add = false
			if to_add:
				dblist.append(i)
		else:
			dblist.append(i)
	if dblist.size() > 0:
		var randomitem = dblist.pick_random()
		upgrade_options.append(randomitem)
		return randomitem
	else:
		return null
	
func change_time(argtime = 0):
	time = argtime
	var get_m = int(time/60.0)
	var get_s = time % 60
	if get_m < 10:
		get_m = str(0,get_m)
	if get_s < 10:
		get_s = str(0,get_s)
	lblTimer.text = str(get_m,":",get_s)

func death():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	deathPanel.visible = true
	get_tree().paused = true
