local functions = {}

-- split a string with delimiters into a table (reverse of table.concat)

function functions:split (s, delim)

  assert (type (delim) == "string" and string.len (delim) > 0,
          "bad delimiter")

  local start = 1
  local t = {}  -- results table

  -- find each instance of a string followed by the delimiter

  while true do
    local pos = string.find (s, delim, start, true) -- plain find

    if not pos then
      break
    end

    table.insert (t, string.sub (s, start, pos - 1))
    start = pos + string.len (delim)
  end -- while

  -- insert final one (after last delimiter)

  table.insert (t, string.sub (s, start))

  return t
 
end -- function split

-- trim leading and trailing spaces from a string
function functions:trim (s)
  return (string.gsub (s, "^%s*(.-)%s*$", "%1"))
end -- trim

html_replacements = { 
   ["<"] = "&lt;",
   [">"] = "&gt;",
   ["&"] = "&amp;",
   }

-- fix text so that < > and & are escaped
function functions:fixhtml (s)

return (string.gsub (tostring (s), "[<>&]", function (str)
  return html_replacements [str] or str
  end ))

end -- fixhtml

-- convert + to space
-- convert %xx where xx is hex characters, to the equivalent byte
function functions:urldecode (s)
  return (string.gsub (string.gsub (s, "+", " "), 
          "%%(%x%x)", 
         function (str)
          return string.char (tonumber (str, 16))
         end ))
end -- function urldecode

-- process a single key=value pair from a GET line (or cookie, etc.)
function functions:assemble_value (s, t)
  assert (type (t) == "table")
  local _, _, key, value = string.find (s, "(.-)=(.+)")

  if key then
    t [functions:trim (functions:urldecode (key))] = functions:trim (functions:urldecode (value))
  end -- if we had key=value

end -- assemble_value

-- output a Lua table as an HTML table
function functions:show_table (t)
  local k, v
  assert (type (t) == "table")
  print "<table border=1 cellpadding=3>"
  for k, v in pairs (t) do
    print "<tr>"
    print ("<th>" .. functions:fixhtml (k) .. "</th>" .. 
           "<td>" .. functions:fixhtml (v) .. "</td>")
    print "</tr>"
  end -- for
  print "</table>"
end -- show_table

function functions:get_post_data ()
	
	local HTTP_POST_DATA = io.read ("*a")  -- read all of stdin

	local post_data = {}

	if HTTP_POST_DATA then
		post = functions:split(HTTP_POST_DATA, "&")
		for _, v in ipairs (post) do
			functions:assemble_value (v, post_data)
		end -- for
	end -- if
	
	return (post_data)
end	

-- Funktion um ein Datum in einen Timestamp zu verwandeln (für Berechnungen)
function functions:get_timestamp(timeToConvert)

  pattern = "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)"
  year,month,day,hour,min,sec = timeToConvert:match(pattern)
  
  return(os.time({day=day,month=month,year=year,hour=hour,min=min,sec=sec}))
  
end

-- Prüft, ob der FCM aktiv ist
function functions:check_fcm_enabled(timeout)

	local fcm_activ = false
	local file_wps_pressed = io.open("/tmp/.wps_pressed", "r")
	local last_time_wps_pressed = ""

	if file_wps_pressed then

		for line in file_wps_pressed:lines() do 
			last_time_wps_pressed = line     
		end
		file_wps_pressed:close()
  
		local diff = functions:get_timestamp( os.date("%Y-%m-%d %T") ) - functions:get_timestamp( last_time_wps_pressed )

		if diff > timeout then

			-- FCM abgelaufen  
  
		else
  
			fcm_activ = true
  
		end
  
	end
	
	return (fcm_activ)

end

return functions