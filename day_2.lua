local function load_file(file_name)
  local lines = {}
  for line in io.lines(file_name) do
    lines[#lines + 1] = line
  end
  return lines
end

local lines = load_file("day_2.txt")

local function solve_part_1()
  local forward = 0
  local depth = 0

  for _, line in ipairs(lines) do
    local direction, amount = string.match(line, "(%a+)%s(%d+)")
    if (direction == "up") then
      depth = depth - amount
    elseif (direction == "down") then
      depth = depth + amount
    else
      forward = forward + amount
    end
  end

  return forward * depth
end

print("Part 1: " .. solve_part_1())

local function solve_part_2()
  local forward = 0
  local depth = 0
  local aim = 0

  for _, line in ipairs(lines) do
    local direction, amount = string.match(line, "(%a+)%s(%d+)")
    if (direction == "up") then
      aim = aim - amount
    elseif (direction == "down") then
      aim = aim + amount
    else
      forward = forward + amount
      depth = depth + aim * amount
    end
  end

  return forward * depth
end

print("Part 2: " .. solve_part_2())
