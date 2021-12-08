local utils = require 'utils'

local lines = utils.read_file_lines('day_8.txt')

local function get_digit_count(line)
  local output = string.match(line, "| (.*)")
  local count = 0
  for d in output:gmatch("([^ ]+)") do
    if #d == 2 or #d == 3 or #d == 4 or #d == 7 then
      count = count + 1
    end
  end
  return count
end

local digit_count = 0
for _, line in ipairs(lines) do
  digit_count = digit_count + get_digit_count(line)
end
print("Part 1: " .. digit_count)

local function diff_str(a, b)
  local result = ""
  for char in a:gmatch(".") do
    if not b:find(char) then
      result = result .. char
    end
  end
  return result
end

local function sort_str(str)
  local chars = {}
  for char in str:gmatch(".") do
    table.insert(chars, char)
  end
  table.sort(chars)
  return table.concat(chars)
end

local function get_digits(line)
  local digits = {}
  for str in string.match(line, "(.*) | "):gmatch("([^ ]+)") do
    if #str == 2 then digits['1'] = str
    elseif #str == 3 then digits['7'] = str
    elseif #str == 4 then digits['4'] = str
    elseif #str == 7 then digits['8'] = str
    end
  end

  for str in string.match(line, "(.*) | "):gmatch("([^ ]+)") do
    if #str == 6 and #diff_str(str, digits['7']) == 4 then
      digits['6'] = str
    elseif #str == 6 and #diff_str(str, digits['4']) == 2 then
      digits['9'] = str
    elseif #str == 6 and #diff_str(str, digits['4']) == 3 then
      digits['0'] = str
    elseif #str == 5 and #diff_str(str, digits['1']) == 3 then
      digits['3'] = str
    elseif #str == 5 and #diff_str(str, digits['4']) == 3 then
      digits['2'] = str
    elseif #str == 5 and #diff_str(str, digits['4']) == 2 then
      digits['5'] = str
    end
  end
  return digits
end

local function parse_line(line)
  local digits = get_digits(line)
  local output = string.match(line, "| (.*)")
  local amount = ""
  for d in output:gmatch("([^ ]+)") do
    for key, value in pairs(digits) do
      if sort_str(d) == sort_str(value) then
        amount = amount .. key
      end
    end
  end
  return tonumber(amount)
end

local total = 0
for _, line in ipairs(lines) do
  total = total + parse_line(line)
end

print("Part 2: " .. total)
