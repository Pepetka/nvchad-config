local merge_tables = require "utils.merge_tables"

local BASE = {
  " ██████╗    ██████╗    ██████╗    ███████╗",
  "██╔════╝   ██╔═══██╗   ██╔══██╗   ██╔════╝",
  "██║        ██║   ██║   ██████╔╝   █████╗  ",
  "██║        ██║   ██║   ██╔══██╗   ██╔══╝  ",
  "╚██████╗██╗╚██████╔╝██╗██║  ██║██╗███████╗",
  " ╚═════╝╚═╝ ╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝╚══════╝",
  "╭┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈╮",
  "     Code. Organize. Refine. Execute.     ",
  "╰┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈╯",
}

local pad_string = function(str, length)
  if #str >= length then
    return str
  end
  local pad_length = length - #str
  local left_pad = math.floor(pad_length / 2)
  local right_pad = pad_length - left_pad
  return string.rep(" ", left_pad) .. str .. string.rep(" ", right_pad)
end

local get_time_header = function(length)
  local hour = tonumber(os.date "%H")
  local greeting = "Good Night!"

  if hour >= 6 and hour < 12 then
    greeting = "Good Morning!"
  elseif hour >= 12 and hour < 18 then
    greeting = "Good Afternoon!"
  end

  return pad_string(greeting, length)
end

local get_seasonal_header = function()
  local month = tonumber(os.date "%m")
  local day = tonumber(os.date "%d")

  if month == 3 and day >= 7 and day <= 9 then
    return {
      "🌸 🌷 🌸 🌷 🌸 🌷 🌸 🌷 🌸 🌷 🌸 🌷 🌸 🌷 ",
      "             HAPPY WOMEN'S DAY            ",
      "🌸 🌷 🌸 🌷 🌸 🌷 🌸 🌷 🌸 🌷 🌸 🌷 🌸 🌷 ",
      "                                          ",
    }
  end

  if month == 5 and day >= 1 and day <= 3 then
    return {
      "🌿 🌼 🌿 🌼 🌿 🌼 🌿 🌼 🌿 🌼 🌿 🌼 🌿 🌼 ",
      "              HAPPY MAY DAY               ",
      "🌿 🌼 🌿 🌼 🌿 🌼 🌿 🌼 🌿 🌼 🌿 🌼 🌿 🌼 ",
      "                                          ",
    }
  end

  if month == 5 and day >= 8 and day <= 10 then
    return {
      "🕊️ 🔥 🕊️ 🔥 🕊️ 🔥 🕊️ 🔥 🕊️ 🔥 🕊️ 🔥 🕊️ 🔥 ",
      "             REMEMBER & HONOR             ",
      "🕊️ 🔥 🕊️ 🔥 🕊️ 🔥 🕊️ 🔥 🕊️ 🔥 🕊️ 🔥 🕊️ 🔥 ",
      "                                          ",
    }
  end

  local yday = tonumber(os.date "%j")
  if yday == 256 then
    return {
      "01000011   01001111   01010010   01000101 ",
      "         PROGRAMMER'S DAY EDITION         ",
      "01000011   01001111   01010010   01000101 ",
      "                                          ",
    }
  end

  if month == 10 and day >= 28 and day <= 31 then
    return {
      "🦇 🎃 🦇 🎃 🦇 🎃 🦇 🎃 🦇 🎃 🦇 🎃 🦇 🎃 ",
      "              HALLOWEEN MODE              ",
      "🦇 🎃 🦇 🎃 🦇 🎃 🦇 🎃 🦇 🎃 🦇 🎃 🦇 🎃 ",
      "                                          ",
    }
  end

  if (month == 12 and day >= 21) or (month == 1 and day <= 10) then
    return {
      "❄ ☆ ❄ ☆ ❄ ☆ ❄ ☆ ❄ ☆ ❄ ☆ ❄ ☆ ❄ ☆ ❄ ☆ ❄ ☆ ❄ ",
      "              HAPPY NEW YEAR              ",
      "❄ ☆ ❄ ☆ ❄ ☆ ❄ ☆ ❄ ☆ ❄ ☆ ❄ ☆ ❄ ☆ ❄ ☆ ❄ ☆ ❄ ",
      "                                          ",
    }
  end

  return {}
end

local get_header = function()
  local seasonal_header = get_seasonal_header()
  local time_line = get_time_header(#seasonal_header)

  return merge_tables(merge_tables(seasonal_header, BASE, true), time_line, true)
end

return get_header
