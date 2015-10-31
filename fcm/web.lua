local web_lua = {}

function web_lua:head( sitename )
	io.write("Content-type: text/html\n\n")
	io.write("<!DOCTYPE html>")
	io.write("<html>")
	io.write("<head>")
	io.write("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">")
	io.write("	<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/default.css\" media=\"all\">")
	io.write("<title>" .. sitename .. "</title>")
	io.write("</head>")
end

function web_lua:start_of_body(subpage, fcm_activ)
	
	-- HTML Body
	io.write("<body>")

	-- Header
	io.write("<header class=\"pageHeader\">")
	io.write("	<div class=\"headerWrap\">")
	io.write("	")
	io.write("		<div class=\"logo\">")
	io.write("			<a href=\"/\" title=\"Freifunk Pinneberg\"><img src=\"/logo.svg\" alt=\"Freifunk Pinneberg Logo\"></a>")
	io.write("		</div>")
	io.write("		<div class=\"title\">")
	io.write("			<h1>Freifunk Pinneberg</h1>")
	io.write("			<h2>Freies WLAN im Kreis Pinneberg</h2>")
	io.write("		</div>")
	io.write("	</div>")

	-- Seitenavigation
	io.write("	<nav class=\"menu\" id=\"main-nav\" itemscope itemtype=\"http://schema.org/SiteNavigationElement\" role=\"navigation\">")
	io.write("		<ul>")

    -- Hauptseite	
	if subpage == "" then
		io.write("			<li id=\"link1\" class=\"first active first_active\">")
	else
		io.write("			<li id=\"link2\">")
    end	
	io.write("				<a href=\"/cgi-bin/config\">Status</a>")
	io.write("			</li>")
	
	if fcm_activ == true then
	
		-- Location	
		if subpage == "/location" then
			io.write("			<li id=\"link1\" class=\"first active first_active\">")
		else
			io.write("			<li id=\"link2\">")
		end	
		io.write("				<a href=\"/cgi-bin/config/location\">Standort</a>")
		io.write("			</li>")
	
		-- Abmelden	
		io.write("			<li id=\"link2\">")
		io.write("				<a href=\"/cgi-bin/config/logout\">Abmelden</a>")
		io.write("			</li>")

	end
	
    -- Freifunk

	io.write("			<li id=\"link2\">")
	io.write("				<a href=\"https://pinneberg.freifunk.net/\">Freifunk Pinneberg</a>")
	io.write("			</li>")
	io.write("		</ul>")
	io.write("	</nav>")
	io.write("</header>")

end

function web_lua:end_of_body()
	io.write("</body>")
	io.write("</html>")
end

function web_lua:table_start(description)
	io.write("<table class=\"contenttable\">")
	io.write("	<thead>")
	io.write("		<tr>")
	io.write("			<th scope=\"col\" colspan=\"2\">" .. description .. "</th>")
	io.write("		</tr>")
	io.write("	</thead>	")
	io.write("	<tbody>")
end

function web_lua:table_item(topic, content)
	io.write("		<tr>")
	io.write("			<td>" .. topic .. "</td>")
	io.write("			<td>" .. content .. "</td>")
	io.write("		</tr>")
end

function web_lua:table_end()
	io.write("	</tbody>")
	io.write("</table>")
end

function web_lua:redirect(url)
	io.write("Content-type: text/html\n\n")
	io.write("<!DOCTYPE html>")
	io.write("<html>")
	io.write("  <head>")
	io.write("    <meta http-equiv=\"refresh\" content=\"0; URL=" .. url .. "\">")
	io.write("    <meta http-equiv=\"cache-control\" content=\"no-cache\">")
	io.write("    <meta http-equiv=\"expires\" content=\"0\">")
	io.write("    <meta http-equiv=\"expires\" content=\"Tue, 01 Jan 1980 1:00:00 GMT\">")
	io.write("    <meta http-equiv=\"pragma\" content=\"no-cache\">")
	io.write("  </head>")
	io.write("  <body>")
	io.write("    <a href=\"" .. url .. "\">Redirecting...</a>")
	io.write("  </body>")
	io.write("</html>")
end

return web_lua
