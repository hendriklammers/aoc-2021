local Utils = {}

local function dump_table(t)
  if type(t) == 'table' then
    local s = '{ '
    for k,v in pairs(t) do
      if type(k) ~= 'number' then k = '"'..k..'"' end
      s = s .. '['..k..'] = ' .. dump_table(v) .. ','
    end
    return s .. '} '
  else
    return tostring(t)
  end
end

function Utils.print_table(t)
  print(dump_table(t))
end

function Utils.read_file(file_name)
  local file = io.open(file_name, "rb")
  local content = file:read("*all")
  file:close()
  return content
end

function Utils.read_file_lines(file_name)
  local lines = {}
  for line in io.lines(file_name) do
    lines[#lines + 1] = line
  end
  return lines
end

function Utils.split_string(str, delimiter)
  local numbers = {}
  for n in string.gmatch(str, "([^" .. delimiter .. "]+)") do
    table.insert(numbers, tonumber(n))
  end
  return numbers
end

return Utils
