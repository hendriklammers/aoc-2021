local function read_file(file_name)
  local file = io.open(file_name, "rb")
  local content = file:read("*all")
  file:close()
  return content
end

local function get_numbers(lines)
  local nums = {}
  local num_index = 1
  for n in lines[1]:gmatch("[^,]+") do
    nums[num_index] = n
    num_index = num_index + 1
  end
  return nums
end

local function get_boards(lines)
  local boards = {}
  local board_index = 1

  for i = 2, #lines do
    local y = math.fmod(i - 2, 5) + 1
    local row = {}
    local x = 1
    for n in lines[i]:gmatch("[^ ]+") do
      row[x] = n
      x = x + 1
    end
    if boards[board_index] == nil then
      boards[board_index] = {}
    end
    boards[board_index][y] = row

    if y == 5 then
      board_index = board_index + 1
    end
  end

  return boards
end

local function get_data(data)
  local lines = {}
  local line_index = 1
  for line in data:gmatch("[^\r\n]+") do
    lines[line_index] = line
    line_index = line_index + 1
  end

  local nums = get_numbers(lines)
  local boards = get_boards(lines)
  return boards, nums
end

local function check_bingo(board)
  for i = 1, 5 do
    local row_bingo = 0
    local col_bingo = 0
    for j = 1, 5 do
      if board[i][j] == 'x' then
        row_bingo = row_bingo + 1
      end
      if board[j][i] == 'x' then
        col_bingo = col_bingo + 1
      end
    end
    if row_bingo == 5 or col_bingo == 5 then
      return true
    end
  end
  return false
end

local function check_unused(board)
  local unused = {}
  local sum = 0
  for x = 1, 5 do
    for y = 1, 5 do
      if board[y][x] ~= 'x' then
        table.insert(unused, board[y][x])
        sum = sum + board[y][x]
      end
    end
  end
  return sum, unused
end

local function play_bingo(boards, nums)
  local winners = {}
  local first_winner
  local last_winner

  for _, n in ipairs(nums) do
    for board_index, board in ipairs(boards) do
      -- Mark number on board
      for x = 1, 5 do
        for y = 1, 5 do
          if board[y][x] == n then
            board[y][x] = 'x'
          end
        end
      end

      if check_bingo(board) and winners[board_index] == nil then
        local sum = check_unused(board)
        winners[board_index] = sum * n

        if first_winner == nil then
          first_winner = board_index
        end
        last_winner = board_index
      end
    end
  end

  return winners[first_winner], winners[last_winner]
end

local boards, nums = get_data(read_file("day_4.txt"))
local first, last = play_bingo(boards, nums)

print("Part 1: " .. first)
print("Part 2: " .. last)
