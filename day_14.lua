local function read_input(file_name)
  local rules = {}
  local line_number = 1
  local pair_count = {}
  local last_char = ""
  for line in io.lines(file_name) do
    if line_number == 1 then
      last_char = line:sub(-1)
      for i = 2, #line do
        local pair = line:sub(i - 1, i)
        pair_count[pair] = (pair_count[pair] or 0) + 1
      end
    end
    line_number = line_number + 1

    local key, value = line:match("(%a%a) %-> (%a)")
    if key and value then
      rules[key] = value
    end
  end
  return pair_count, last_char, rules
end

local start_count, last_char, rules = read_input("day_14.txt")

local function step(pair_count, n)
  if n == 0 then return pair_count end

  local new_count = {}
  for pair, count in pairs(pair_count) do
    local char = rules[pair]
    if char then
      local first, second = pair:match("(%a)(%a)")
      new_count[first .. char] = (new_count[first .. char] or 0) + count
      new_count[char .. second] = (new_count[char .. second] or 0) + count
    end
  end
  return step(new_count, n - 1)
end

local function count_chars(pair_count)
  local count = {}
  count[last_char] = 1
  for key, amount in pairs(pair_count) do
    local char = key:sub(2, 2)
    count[char] = (count[char] or 0) + amount
  end

  local least = nil
  local most = nil
  for _, c in pairs(count) do
    if least == nil or c < least then
      least = c
    end
    if most == nil or c > most then
      most = c
    end
  end

  return most - least
end

print("Part 1:", count_chars(step(start_count, 10)))
print("Part 2:", count_chars(step(start_count, 40)))
