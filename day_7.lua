local utils = require 'utils'

local function solve_part_1(input)
  local fuel_usage = {}
  for i, x in ipairs(input) do
    local sum = 0
    for _, y in ipairs(input) do
      sum = sum + math.abs(x - y)
    end
    fuel_usage[i] = sum
  end
  return fuel_usage
end

local function solve_part_2(input)
  local result = {}
  for x = 1, input[#input] do
    local sum = 0
    for _, y in ipairs(input) do
      local dist = math.abs(x - y)
      sum = sum + math.floor(dist * (dist + 1) / 2)
    end
    table.insert(result, sum)
  end
  return result
end

local function get_cheapest(input)
  local cheapest = nil
  for _, usage in ipairs(input) do
    if cheapest == nil or usage < cheapest then
      cheapest = usage
    end
  end
  return cheapest
end

local numbers = utils.split_string(utils.read_file("day_7.txt"), ",")
table.sort(numbers)

print("Part 1: " .. get_cheapest(solve_part_1(numbers)))
print("Part 2: " .. get_cheapest(solve_part_2(numbers)))
