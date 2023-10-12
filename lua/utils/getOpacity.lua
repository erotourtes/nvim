local function read_file(file)
  local lines = {}
  for line in file:lines() do
    table.insert(lines, line)
  end
  return lines
end

local function to_absolute_path(path)
  local user_home = os.getenv("HOME") or "~"
  return string.gsub(path, "^~", user_home)
end

local function get_file(path)
  local alacritty_conf = to_absolute_path(path)
  return io.open(alacritty_conf, "r")
end

local function get_term_opacity()
  local file = get_file("~/.config/alacritty/alacritty.yml")
  if not file then return end

  local lines = read_file(file)
  local opacity = 1
  for _, line in pairs(lines) do
    if string.find(line, "opacity") then
      local res = string.match(line, "%d+")
      opacity = tonumber(res)
      break
    end
  end

  file:close()
  return opacity
end

return get_term_opacity
