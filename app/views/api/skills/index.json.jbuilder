json.array! @skills do |skill|
	json.idskill skill.id
	json.name skill.name
	json.idpeople do 
		json.name skill.try(:user).try(:name)
		json.lastname skill.try(:user).try(:lastname)
	end
	json.createdate skill.created_at
end