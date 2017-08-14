json.array! @users do |user|
	json.idpeople user.id
	json.name user.name
	json.lastname user.lastname
	json.email user.email
	json.phone user.phone
	json.indate user.indate
	json.jobtitle user.jobtitle
	json.fotolink user.fotolink.url
	json.country user.city.country.name
	json.city user.city.name
	json.city_id user.city_id
	json.country_id  user.city.try(:country_id)
	json.ischangepassword user.ischangepassword
	json.idrol do
		json.idrol user.rol.id
		json.name user.rol.name
	end
	if @skills.present?
		json.skills @skills.map(&:name)
	elsif @skills.blank? and @levels.present?
		json.skills Skill.where(id: SkillsUser.joins(:skills_level).where(user_id: user.id, skills_levels: {code: @levels.last.code}).pluck(:skill_id)).pluck(:name)
	else
		json.skills Skill.where(id: user.skills_users.pluck(:skill_id)).pluck(:name)
	end

end
