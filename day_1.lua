local function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

local function load_file(file_name)
  if not file_exists(file_name) then
    print("File " .. file_name .. " does not exist")
    return {}
  end

  local lines = {}
  for line in io.lines(file_name) do
    lines[#lines + 1] = line
  end
  return lines
end

local lines = load_file("day_1.txt")

local count = 0
for i, depth in ipairs(lines) do
  if (i > 1 and tonumber(depth) > tonumber(lines[i - 1])) then
    count = count + 1
  end
end

print("Part 1: " .. count)

local count_2 = 0
for i = 4, #lines do
  local sum_prev = lines[i - 1] + lines[i - 2] + lines[i - 3]
  local sum_current = lines[i] + lines[i - 1] + lines[i - 2]
  if sum_current > sum_prev then
    count_2 = count_2 + 1
  end
end

print("Part 2: " .. count_2)
