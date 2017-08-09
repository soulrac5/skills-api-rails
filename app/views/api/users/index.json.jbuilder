json.array! @users do |user|
	json.idpeople user.id
	json.name user.name
	json.lastname user.lastname
	json.email user.email
	json.phone user.phone
	json.indate user.indate
	json.jobtitle user.jobtitle
	json.fotolink user.fotolink.url
	json.city_id user.city_id
	json.country_id  user.city.try(:country_id)
	json.ischangepassword user.ischangepassword
	json.idrol do
		json.idrol user.rol.id
		json.name user.rol.name
	end
end
