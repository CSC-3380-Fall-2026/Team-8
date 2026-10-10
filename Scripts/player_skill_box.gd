extends HBoxContainer

var PlayerEntity

func initiate(player):
	PlayerEntity = player
	for skill in PlayerStats.Skills:
		var newButton = Button.new()
		add_child(newButton)
		newButton.text = skill.Skill.SkillName
		newButton.pressed.connect(player.AttackNode.Attack.bind(skill))
