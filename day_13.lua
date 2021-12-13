local function read_input(file_name)
  local dots = {}
  local instructions = {}
  for line in io.lines(file_name) do
    local x, y = line:match("(%d+),(%d+)")
    if x and y then
      dots[x .. "," .. y] = {x = tonumber(x), y = tonumber(y)}
    end

    local axis, fold = line:match("([xy])=(%d+)")
    if axis and fold then
      instructions[#instructions + 1] = {axis = axis, fold = tonumber(fold)}
    end
  end
  return dots, instructions
end

local function fold(dots, instruction)
  local result = {}
  for key, coords in pairs(dots) do
    if instruction.axis == "x" then
      if coords.x < instruction.fold then
        result[key] = coords
      elseif coords.x > instruction.fold then
        local x = instruction.fold - (coords.x - instruction.fold)
        if x >= 0 then
          result[x .. "," .. coords.y] = {x = x, y = coords.y}
        end
      end
    elseif instruction.axis == "y" then
      if coords.y < instruction.fold then
        result[key] = coords
      elseif coords.y > instruction.fold then
        local y = instruction.fold - (coords.y - instruction.fold)
        if y >= 0 then
          result[coords.x .. "," .. y] = {x = coords.x, y = y}
        end
      end
    end
  end
  return result
end

local function count_dots(dots)
  local count = 0
  for _ in pairs(dots) do
    count = count + 1
  end
  return count
end

local dots, instructions = read_input("day_13.txt")

print("Part 1: " .. count_dots(fold(dots, instructions[1])))

local function print_sheet(sheet)
  for y = 0, 10 do
    local output = ""
    for x = 0, 50 do
      if sheet[x .. "," .. y] then
        output = output .. "#"
      else
        output = output .. "."
      end
    end
    print(output)
  end
end

local function solve_part_2(sheet, i)
  if instructions[i] then
    sheet = fold(sheet, instructions[i])
    return solve_part_2(sheet, i + 1)
  else
    print_sheet(sheet)
  end
end

print("Part 2:")
solve_part_2(dots, 1)
