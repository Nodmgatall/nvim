local M = {}

-- Cache the list once per session; refresh with M.refresh() if you install new themes
local colorscheme_list = nil
local current_index = 1

local function get_colorschemes()
  if not colorscheme_list then
    colorscheme_list = vim.fn.getcompletion("", "color")
    table.sort(colorscheme_list)
  end
  return colorscheme_list
end

function M.next_colorscheme()
  local schemes = get_colorschemes()
  if #schemes == 0 then
    vim.notify("No colorschemes found", vim.log.levels.WARN)
    return
  end

  -- If current background doesn't match list index (e.g. first run), find current position
  local current = vim.g.colors_name
  if current then
    for i, name in ipairs(schemes) do
      if name == current then
        current_index = i
        break
      end
    end
  end

  current_index = (current_index % #schemes) + 1
  local next_scheme = schemes[current_index]

  local ok, err = pcall(vim.cmd.colorscheme, next_scheme)
  if ok then
    vim.notify("Colorscheme: " .. next_scheme)
  else
    vim.notify("Failed to load " .. next_scheme .. ": " .. err, vim.log.levels.ERROR)
  end
end

function M.prev_colorscheme()
  local schemes = get_colorschemes()
  if #schemes == 0 then
    vim.notify("No colorschemes found", vim.log.levels.WARN)
    return
  end

  local current = vim.g.colors_name
  if current then
    for i, name in ipairs(schemes) do
      if name == current then
        current_index = i
        break
      end
    end
  end

  current_index = current_index - 1
  if current_index < 1 then
    current_index = #schemes
  end
  local prev_scheme = schemes[current_index]

  local ok, err = pcall(vim.cmd.colorscheme, prev_scheme)
  if ok then
    vim.notify("Colorscheme: " .. prev_scheme)
  else
    vim.notify("Failed to load " .. prev_scheme .. ": " .. err, vim.log.levels.ERROR)
  end
end

-- Call this if you install/remove colorscheme plugins mid-session
function M.refresh()
  colorscheme_list = nil
  get_colorschemes()
end

return M
