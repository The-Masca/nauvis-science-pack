
data.raw["technology"]["space-science-pack"].hidden= true
data.raw["recipe"]["space-science-pack"].hidden= true
data.raw["tool"]["space-science-pack"].hidden= true
data.raw["technology"]["space-platform"].prerequisites= {"nauvis-science-pack"}
data.raw["technology"]["space-platform-thruster"].prerequisites= {"space-platform"}

--Definisco i pacchi di altri pianeti
local special_packs =
{
  ["nauvis-science-pack"] = true,
  ["metallurgic-science-pack"] = true,
  ["electromagnetic-science-pack"] = true,
  ["agricultural-science-pack"] = true,
  ["cryogenic-science-pack"] = true,
  ["promethium-science-pack"] = true,
}


--Rimpiazzo SPACE con NAUVIS nelle tecnologie
for _, tech in pairs(data.raw.technology) do
  if tech.unit and tech.unit.ingredients then
    for i, ingredient in pairs(tech.unit.ingredients) do
      local name = ingredient[1]
      if name == "space-science-pack" then
        tech.unit.ingredients[i] = {"nauvis-science-pack", 1}
      end
    end
  end
end

--Logica per eliminazione pacchi rimpiazzati da NAUVIS
for _, tech in pairs(data.raw.technology) do
  local ingredients = tech.unit and tech.unit.ingredients or nil
  if not ingredients then goto continue end
  
  local filtered_ingredients, filtered_count = {}, 0
  for _, ingredient in pairs(ingredients) do
    if special_packs[ingredient[1]] then
      filtered_count = filtered_count + 1
      filtered_ingredients[filtered_count] = ingredient
    end
  end

  if filtered_count > 0 then
    tech.unit.ingredients = filtered_ingredients
  end

  ::continue::
end

--Passaggio dei prerequisiti da SPACE a NAUVIS
for i, prerequisites in pairs(data.raw.technology) do
  if prerequisites == "space-science-pack" then
    tech.prerequisites[i] = "space-platform"
  end
end

--Aggiunta nuovo pack nei LAB
for _, lab in pairs(data.raw["lab"]) do
  table.insert(lab.inputs, 8, "nauvis-science-pack")
  table.remove(lab.inputs, 7)
end
