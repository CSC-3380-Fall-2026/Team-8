extends Node

var Skills:Array = []
var Cooldowns:Array = []



func Attack(skill):
	var Target =get_parent().CurrentTargets
	var Damage = CalculateDamage(skill)
	for target in Target:
		target.RecivedDamage(Damage,skill.SkillType)
	RefreshCooldowns()

func CalculateDamage(skill):
	var Damage: float = get_parent().get(skill.SkillType)
	Damage *= skill.SkillPower
	return Damage
	
func LoadSkills(skills):
	for skill in skills:
		Skills.append(skill)
		Cooldowns.append(skill.skillCooldown)

func RefreshCooldowns():
	for cooldown in Cooldowns:
		cooldown = max(cooldown-1,0)
