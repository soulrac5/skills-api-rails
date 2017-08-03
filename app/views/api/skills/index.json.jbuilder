json.array! @skills do |skill|
	json.idSkill skill.id
	json.name skill.name
	json.idpeople do 
		json.name skill.user.name
		json.lastname skill.user.lastname
	end
	json.createdate skill.created_at
end