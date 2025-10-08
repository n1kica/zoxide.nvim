local M = {}

local config = {}

local uv = vim.uv or vim.loop

local function zoxide_jump(query)
	local stdout = uv.new_pipe(false)

	local handle
	handle = uv.spawn("zoxide", { hide = true, args = { "query", query }, stdio = { nil, stdout, nil } }, function()
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

	vim.api.nvim_create_user_command("Z", function(cmd)
		zoxide_jump(cmd.args)
	end, { nargs = 1 })
end

return M
