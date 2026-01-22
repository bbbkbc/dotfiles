local M = {}

function M.pick(method, opts)
  opts = opts or {}
  return function()
    -- zabezpieczenie jak plugin jeszcze nie załadowany
    local ok, Snacks = pcall(require, 'snacks')
    if not ok or not Snacks.picker or not Snacks.picker[method] then
      vim.notify('Snacks picker not available: ' .. tostring(method), vim.log.levels.WARN)
      return
    end
    Snacks.picker[method](opts)
  end
end

return M
