local utils = require "utils"

local function simulate_day(input)
  local updated = {}
  for _, age in ipairs(input) do
    if age == 0 then
      table.insert(updated, 6)
      table.insert(updated, 8)
    else
      table.insert(updated, age - 1)
    end
  end
  return updated
end

local fish = utils.split_string(utils.read_file("day_6.txt"), ",")

for _ = 1, 80 do
  fish = simulate_day(fish)
end

print("Part 1: " .. #fish)

local function get_numbers_grouped(str)
  local numbers = {}
  for n in string.gmatch(str, "([^,]+)") do
    numbers[tonumber(n + 1)] = (numbers[tonumber(n + 1)] or 0) + 1
  end
  return numbers
end

local function simulate_day_grouped(input)
  local updated = {}
  for i = 9, 1, -1 do
    local count = input[i] or 0
    if i == 1 then
      updated[7] = (input[8] or 0) + count
      updated[9] = count
    else
      updated[i - 1] = count
    end
  end
  return updated
end

local fish_grouped = get_numbers_grouped(utils.read_file("day_6.txt"))

for _ = 1, 256 do
  fish_grouped = simulate_day_grouped(fish_grouped)
end

local total_fish = 0
for _, v in pairs(fish_grouped) do
  total_fish = total_fish + v
end

print("Part 2: " .. total_fish)
