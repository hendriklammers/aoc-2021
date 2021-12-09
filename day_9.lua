local utils = require 'utils'

local function create_grid(lines)
  local grid = {}
  for y, line in ipairs(lines) do
    grid[y] = {}
    line:gsub(".", function(num)
      table.insert(grid[y], tonumber(num))
    end)
  end
  return grid
end

local function low_points(grid)
  local risk_level = 0
  local coords = {}
  for y, row in ipairs(grid) do
    for x, n in ipairs(row) do
      if (grid[y - 1] == nil or n < grid[y - 1][x])
        and (grid[y + 1] == nil or n < grid[y + 1][x])
        and (grid[y][x - 1] == nil or n < grid[y][x - 1])
        and (grid[y][x + 1] == nil or n < grid[y][x + 1]) then
        risk_level = risk_level + 1 + n
        table.insert(coords, {x = x, y = y})
      end
    end
  end
  return risk_level, coords
end

local grid = create_grid(utils.read_file_lines("day_9.txt"))
local risk_level, coords = low_points(grid)

print("Part 1: " .. risk_level)

local function check_adjacent(y, x, checked)
	if checked[y] and checked[y][x] then
    return 0
  end
	checked[y] = checked[y] or {}
	checked[y][x] = true

	local val = grid[y][x]
	local count = 1
	if grid[y - 1] and grid[y - 1][x] > val and grid[y - 1][x] ~= 9 then
    count = count + check_adjacent(y - 1, x, checked)
  end
	if grid[y + 1] and grid[y + 1][x] > val and grid[y + 1][x] ~= 9 then
    count = count + check_adjacent(y + 1, x, checked)
  end
	if grid[y][x - 1] and grid[y][x - 1] > val and grid[y][x - 1] ~= 9  then
    count = count + check_adjacent(y, x - 1, checked)
  end
	if grid[y][x + 1] and grid[y][x + 1] > val and grid[y][x + 1] ~= 9 then
    count = count + check_adjacent(y, x + 1, checked)
  end
  return count
end

local counts = {}
for _, coord in ipairs(coords) do
  table.insert(counts, check_adjacent(coord.y, coord.x, {}))
end
table.sort(counts)

print("Part 2: " .. counts[#counts] * counts[#counts - 1] * counts[#counts - 2])
