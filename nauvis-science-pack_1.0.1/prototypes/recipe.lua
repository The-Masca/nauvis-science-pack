
local ingredients = {}
local used_science_packs = {}


--Trova i science packs prodotti su Nauvis
for _, recipe in pairs(data.raw.recipe) do
  if string.find(recipe.name, "science-pack", 1, true) then         --Controlla che sia la ricetta di un science pack
    if not recipe.surface_conditions then         --Controlla presenza non c'è surface_conditions
      if recipe.ingredients then          --Se la tech ha degli ingredienti (se non può essere craftata è inutile, giusto per sicurezza)
        for _, result in pairs(recipe.results or {}) do
          local name = result.name or result[1]
          if name
            and name ~= "space-science-pack"
            and name ~= "nauvis-science-pack"
          then
            used_science_packs[name] = true
          end
        end
      end
    end
  end
end


for name, _ in pairs(used_science_packs) do
  if data.raw.tool[name] then
    ingredients[#ingredients + 1]=
      {
        type = "item",
        name = name,
        amount = 1
      }
  end
end


data:extend({
  {
    type = "recipe",
    name = "nauvis-science-pack",
    enabled = false,
    energy_required = 10,
    ingredients = ingredients,
    results = {
      {
        type = "item",
        name = "nauvis-science-pack",
        amount = 1
      }
    },
    allow_productivity = true
  }
})
