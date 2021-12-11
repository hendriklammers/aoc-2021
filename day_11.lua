local utils = require 'utils'

local input_data = utils.read_file_lines("day_11.txt")

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

local function simulate_day(grid)
  local flash_count = 0

  local function update_cell(x, y)
    if x < 1 or x > 10 or y < 1 or y > 10 then
      return
    end

    grid[y][x] = grid[y][x] + 1

    if grid[y][x] > 9 then
      flash_count = flash_count + 1
      grid[y][x] = -100

      for i = x - 1, x + 1 do
        for j = y - 1, y + 1 do
          update_cell(i, j)
        end
      end
    end
  end

  for y = 1, #grid do
    for x = 1, #grid[1] do
      update_cell(x, y)
    end
  end

  for y = 1, #grid do
    for x = 1, #grid[1] do
      if grid[y][x] < 0 then
        grid[y][x] = 0
      end
    end
  end

  return flash_count
end

local function solve_part_1(input)
  local grid = create_grid(input)
  local flash_count = 0
  for _ = 1, 100 do
    flash_count = flash_count + simulate_day(grid)
  end
  return flash_count
end

print("Part 1: " .. solve_part_1(input_data))

local function solve_part_2(input)
  local grid = create_grid(input)
  local flash_count = 0
  local count = 0
  while flash_count ~= 100 do
    count = count + 1
    flash_count = simulate_day(grid)
  end
  return count
end

print("Part 2: " .. solve_part_2(input_data))
