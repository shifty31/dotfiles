local TOTAL_PADDING = 16

local logos = {
  [[
      |\   \\\\__     o
      | \_/    o \    o 
      > _   (( <_  oo  
      | / \__+___/      
      |/     |/
  ]],
  [[😂]],
  [[
               ▄▄                      
  ▄▄█▀▀▀█▄█  ██                      
▄██▀     ▀█                          
██▀       ▀▀███ ▀████████▄   ▄██▀██▄ 
██           ██   ██    ██  ██▀   ▀██
██▄    ▀████ ██   ██    ██  ██     ██
▀██▄     ██  ██   ██    ██  ██▄   ▄██
  ▀▀███████▄████▄████  ████▄ ▀█████▀ 
                                     
                                     
    ]],
}

local function get_logo()
  math.randomseed(os.time())
  return math.random(#logos)
end

local function generate_header()
  local logo = logos[get_logo()]

  local num_lines = select(2, logo:gsub("\n", "\n"))
  local padding = TOTAL_PADDING - num_lines

  if padding > 0 then
    logo = string.rep("\n", padding) .. logo
  end

  logo = logo .. "\n\n"

  return vim.split(logo, "\n")
end

return {
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      opts.config.header = generate_header()
      opts.config.center = {
        {
          action = "Telescope find_files",
          desc = " Find file",
          icon = " ",
          key = "f",
        },
        {
          action = "ene | startinsert",
          desc = " New file",
          icon = " ",
          key = "n",
        },
        {
          action = "Telescope oldfiles",
          desc = " Recent files",
          icon = " ",
          key = "r",
        },
        {
          action = 'lua require("persistence").load()',
          desc = " Restore Session",
          icon = " ",
          key = "s",
        },
        {
          action = "Telescope file_browser",
          desc = " File Explorer",
          icon = " ",
          key = "x",
        },
        {
          action = "Lazy",
          desc = " Lazy",
          icon = "󰒲 ",
          key = "l",
        },
        {
          action = "qa",
          desc = " Quit",
          icon = " ",
          key = "q",
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end
    end,
  },
}
