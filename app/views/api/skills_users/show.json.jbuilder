json.array! @skills do |skill|
	json.idskill skill.skill.id 
	json.name skill.skill.name
	json.level skill.skills_level.code
end