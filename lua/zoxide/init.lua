local M = {}

local config = {}
local uv = vim.uv

local function zoxide(query)
	local stdout = uv.new_pipe(false)
	local path = ""

	local handle
	handle = uv.spawn("zoxide", { args = { "query", query or "" }, stdio = { nil, stdout, nil } }, function(_)
		stdout:close()
		handle:close()
		vim.schedule(function()
			print(path)
			vim.api.nvim_set_current_dir(path)
		end)
	end)

	-- TODO: log errors
	stdout:read_start(function(_, data)
		if data then
			path = data:gsub("\n", "")
		end
	end)
end

function M.setup(opts)
	config = vim.tbl_extend("force", config, opts or {})

	vim.api.nvim_create_user_command("Z", function(cmd)
		zoxide(cmd.args)
	end, { nargs = 1 })
end

return M
