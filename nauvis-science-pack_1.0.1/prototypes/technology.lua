local used_science_packs = {}

--Recupera gli ingredienti della ricetta
local recipe = data.raw.recipe["nauvis-science-pack"]
if recipe and recipe.ingredients then
  for _, ing in pairs(recipe.ingredients) do
    local name = ing.name or ing[1]
    if name then
      used_science_packs[name] = true
    end
  end
end


data:extend
({
  {
    type = "technology",
    name = "nauvis-science-pack",
    localised_description = {"technology-description.nauvis-science-pack"},
    icon = "__base__/graphics/technology/space-science-pack.png",
    icon_size = 256,
    essential = true,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "nauvis-science-pack"
      }
    },
    research_trigger =
    {
      type = "send-item-to-orbit",
      item = "raw-fish"
    },
    prerequisites = {"rocket-silo"}
   }
})
