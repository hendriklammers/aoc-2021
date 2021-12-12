local utils = require "utils"

local create_graph = function()
  local lines = utils.read_file_lines("day_12.txt")
  local graph = {}
  for _, line in ipairs(lines) do
    local from, to = string.match(line, "(%a+)-(%a+)")
    graph[from] = graph[from] or {}
    table.insert(graph[from], to)
    graph[to] = graph[to] or {}
    table.insert(graph[to], from)
  end
  return graph
end

local graph = create_graph()

local function is_small(str)
  return str == str:lower()
end

local function copy_table(t)
  local new_t = {}
  for k, v in pairs(t) do
    new_t[k] = v
  end
  return new_t
end

local function dfs(pos, visited)
	if pos == "end" then
    return 1
  end
	if is_small(pos) and visited[pos] then
    return 0
  end

	local new_visited = copy_table(visited)
	new_visited[pos] = true

	local count = 0
	for _, to in ipairs(graph[pos]) do
		count = count + dfs(to, new_visited)
	end
	return count
end

print("Part 1: ", dfs("start", {}))

local function dfs_2(pos, visited, twice)
	if pos == "end" then
    return 1
  end
	if is_small(pos) and visited[pos] == 2 then
    return 0
  end
	if is_small(pos) and visited[pos] == 1 then
		if twice then
			return 0
		else
			twice = 1
		end
	end
	if pos == "start_p2" then
    pos = "start"
  end

	local new_visited = copy_table(visited)
	new_visited[pos] = (new_visited[pos] or 0) + 1

	local count = 0
	for _, to in ipairs(graph[pos]) do
		count = count + dfs_2(to, new_visited, twice)
	end
	return count
end

print("Part 2: ", dfs_2("start_p2", { start = 1 }, false))
