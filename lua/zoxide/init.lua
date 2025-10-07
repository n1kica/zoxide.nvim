local M = {}

local config = {}
local uv = vim.loop

local function zoxide(query)
	local stdout = uv.new_pipe(false)
	local path = ""

	local handle
	handle = uv.spawn("zoxide", { args = { "query", query or "" }, stdio = { nil, stdout, nil } }, function(code)
		stdout:close()
		handle:close()
		if code == 0 and path ~= "" then
			-- Remove trailing newline and change directory
			print("Changed to: " .. path)
		else
			print("zoxide query failed or no result")
		end
	end)

	stdout:read_start(function(err, data)
		if data then
			path = path .. data
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
