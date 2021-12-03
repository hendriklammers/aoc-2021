local function load_file(file_name)
  local lines = {}
  for line in io.lines(file_name) do
    lines[#lines + 1] = line
  end
  return lines
end

local lines = load_file('day_3.txt')

local function count_bits(nums)
  local bit_count = {}
  for _, line in ipairs(nums) do
    local i = 1
    for bit in line:gmatch(".") do
      if bit == "1" then
        if bit_count[i] == nil then
          bit_count[i] = 1
        else
          bit_count[i] = bit_count[i] + 1
        end
      end
      i = i + 1
    end
  end
  return bit_count
end

local function power_consumption(bit_count)
  local gamma = ""
  local epsilon = ""
  for _, count in ipairs(bit_count) do
    if (count > 500) then
      gamma = gamma .. "1"
      epsilon = epsilon .. "0"
    else
      gamma = gamma .. "0"
      epsilon = epsilon .. "1"
    end
  end

  return tonumber(gamma, 2) * tonumber(epsilon, 2)
end

print("Part 1: " .. power_consumption(count_bits(lines)))

local function filter_one(nums, index, compare)
  if #nums <= 1 then
    return nums
  end

  local grouped = {
    ["0"] = {},
    ["1"] = {}
  }
  for _, n in ipairs(nums) do
    if n:sub(index, index) == "1" then
      table.insert(grouped["1"], n)
    else
      table.insert(grouped["0"], n)
    end
  end

  if compare(#grouped["1"], #grouped["0"]) then
    return filter_one(grouped["1"], index + 1, compare)
  else
    return filter_one(grouped["0"], index + 1, compare)
  end
end

local oxygen = filter_one(lines, 1, function(a, b) return a >= b end)[1]
local co2 = filter_one(lines, 1, function(a, b) return a < b end)[1]

print("Part 2: " .. tonumber(oxygen, 2) * tonumber(co2, 2))
