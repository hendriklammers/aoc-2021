local utils = require "utils"

local function find_corrupted(str)
  local stack = {}
  for i = 1, #str do
    local char = str:sub(i, i)
    if char == "(" or char == "[" or char == "{" or char == "<" then
      table.insert(stack, char)
    elseif char == ")" and stack[#stack] ~= "(" then return 3
    elseif char == "]" and stack[#stack] ~= "[" then return 57
    elseif char == "}" and stack[#stack] ~= "{" then return 1197
    elseif char == ">" and stack[#stack] ~= "<" then return 25137
    else
      table.remove(stack)
    end
  end
  return 0
end

local function solve_part_1(lines)
  local score = 0
  for _, line in ipairs(lines) do
    score = score + find_corrupted(line)
  end
  return score
end

local function discard_corrupted(lines)
  local filtered = {}
  for _, line in ipairs(lines) do
    if find_corrupted(line) == 0 then
      table.insert(filtered, line)
    end
  end
  return filtered
end

local function discard_pairs(line)
  local stack = {}
  for i = 1, #line do
    local char = line:sub(i, i)
    if char == "(" or char == "[" or char == "{" or char == "<" then
      table.insert(stack, char)
    else
      table.remove(stack)
    end
  end
  return stack
end

local function score_completion(line)
  local score = 0
  for i = #line, 1, -1 do
    local char = line[i]
    if char == "(" then
      score = score * 5 + 1
    elseif char == "[" then
      score = score * 5 + 2
    elseif char == "{" then
      score = score * 5 + 3
    elseif char == "<" then
      score = score * 5 + 4
    else
      error("Invalid open character")
    end
  end
  return score
end

local function solve_part_2(lines)
  local incomplete = discard_corrupted(lines)
  local scores = {}
  for _, line in ipairs(incomplete) do
    local opening = discard_pairs(line)
    table.insert(scores, score_completion(opening))
  end
  table.sort(scores)
  return scores[math.ceil(#scores / 2)]
end

local input_lines = utils.read_file_lines("day_10.txt")

print("Part 1: " .. solve_part_1(input_lines))
print("Part 2: " .. solve_part_2(input_lines))
