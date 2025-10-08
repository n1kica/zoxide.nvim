local M = {}

---@class ZoxideConfig
---@field cmd string
local config = {
	cmd = "Z",
}

local uv = vim.uv or vim.loop

local function zoxide_jump(query)
	local stdout = assert(uv.new_pipe())

	local handle ---@type uv.uv_process_t
	handle = uv.spawn("zoxide", {
		stdio = { nil, stdout, nil },
		hide = true,
		args = { "query", query },
	}, function()
		handle:close()
	end)

	local path
	stdout:read_start(function(err, data)
		assert(not err, err)
		if data then
			path = data:gsub("\n", "")
		else
			vim.schedule(function()
				if path then
					print(path)
				end
				vim.api.nvim_set_current_dir(path)
			end)
			stdout:close()
		end
	end)
end

function M.setup(opts)
	config = vim.tbl_extend("force", config, opts or {})

	vim.api.nvim_create_user_command(config.cmd, function(cmd)
		zoxide_jump(cmd.args)
	end, { nargs = 1 })
end

return M
