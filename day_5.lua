local function load_file(file_name)
  local lines = {}
  for line in io.lines(file_name) do
    lines[#lines + 1] = line
  end
  return lines
end

local function parse_line(line)
  local x1, y1, x2, y2 = string.match(line, "(%d+),(%d+) %-> (%d+),(%d+)")
  return {
    x1 = tonumber(x1),
    y1 = tonumber(y1),
    x2 = tonumber(x2),
    y2 = tonumber(y2)
  }
end

local function get_lines()
  local lines = load_file('day_5.txt')
  for i, line in ipairs(lines) do
    lines[i] = parse_line(line)
  end
  return lines
end

local function line_coords(lines, include_diagonal)
  local coords = {}
  for _, line in ipairs(lines) do
    -- Horizontal
    if line.y1 == line.y2 then
      for x = math.min(line.x1, line.x2), math.max(line.x1, line.x2) do
        local key = x .. "," .. line.y1
        coords[key] = (coords[key] or 0) + 1
      end
    -- Vertical
    elseif line.x1 == line.x2 then
      for y = math.min(line.y1, line.y2), math.max(line.y1, line.y2) do
        local key = line.x1 .. "," .. y
        coords[key] = (coords[key] or 0) + 1
      end
    -- Diagonal
    elseif include_diagonal then
      if math.abs(line.x1 - line.x2) == math.abs(line.y1 - line.y2) then
        local line_length = math.abs(line.x1 - line.x2)
        for i = 0, line_length do
          local x = line.x1 < line.x2 and line.x1 + i or line.x1 - i
          local y = line.y1 < line.y2 and line.y1 + i or line.y1 - i
          local key = x .. "," .. y
          coords[key] = (coords[key] or 0) + 1
        end
      end
    end
  end
  return coords
end

local count_part_1 = 0
for _, v in pairs(line_coords(get_lines())) do
  if v > 1 then
    count_part_1 = count_part_1 + 1
  end
end

print("Part 1: " .. count_part_1)

local count_part_2 = 0
for _, v in pairs(line_coords(get_lines(), true)) do
  if v > 1 then
    count_part_2 = count_part_2 + 1
  end
end

print("Part 2: " .. count_part_2)
