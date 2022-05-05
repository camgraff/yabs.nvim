local utils = require("yabs.utils")
local core = require("yabs.core")

---@class Task
---@field active boolean | function
---@field command string
---@field args table
---@field runner_name string
---@field runner_opts table
---@field output_name string
---@field output_opts table
local Task = {
  active = true
}

--- Init task
---@param args table
---@return Task
function Task:new(args)
  local runner_name, runner_opts = utils.extract_name_and_opts(args.runner)
  local output_name, output_opts = utils.extract_name_and_opts(args.output)
  local command, l_args = utils.extract_command_and_args(args.command)
  return setmetatable({
    type = args.type,
    active = args.active,
    command = command,
    args = l_args,
    runner_name = runner_name,
    runner_opts = runner_opts,
    output_name = output_name,
    output_opts = output_opts
  }, { __index = self })
end

--- Get whether task is active
---@return boolean
function Task:get_active()
  if type(self.active) == "function" then return self.active() end
  return self.active
end

--- Run task
function Task:run()
  core.run_command(
    self.command,
    self.args,
    self.runner_name,
    self.runner_opts,
    self.output_name,
    self.output_opts
  )
end

return Task
