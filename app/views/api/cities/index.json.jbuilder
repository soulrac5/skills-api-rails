json.array! @cities do |city|
  json.id city.id
  json.country_id city.country_id
  json.name city.name
end
