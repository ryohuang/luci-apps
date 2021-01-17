-- Copyright 2008 Steven Barth <steven@midlink.org>
-- Copyright 2008-2011 Jo-Philipp Wich <jow@openwrt.org>
-- Licensed to the public under the Apache License 2.0.

m = Map("upnpd", luci.util.pcdata(translate("Universal Plug & Play")),
	translate("UPnP allows clients in the local network to automatically configure the router."))

-- m:section(SimpleSection).template  = "upnp_status"

s = m:section(NamedSection, "config", "upnpd", translate("MiniUPnP extra settings"))
s.addremove = false
s:tab("general",  translate("Settings for DMZ router"))


-- e = s:taboption("general", Flag, "enabled", translate("Start UPnP and NAT-PMP service"))
-- e.rmempty  = false

--function e.cfgvalue(self, section)
--	return luci.sys.init.enabled("miniupnpd") and self.enabled or self.disabled
--end

-- function e.write(self, section, value)
-- 	if value == "1" then
-- 		luci.sys.call("/etc/init.d/miniupnpd start >/dev/null")
-- 	else
-- 		luci.sys.call("/etc/init.d/miniupnpd stop >/dev/null")
-- 	end

-- 	return Flag.write(self, section, value)
-- end

s:taboption("general", Value, "download", translate("Downlink"),
	translate("Value in KByte/s, informational only")).rmempty = true

s:taboption("general", Value, "upload", translate("Uplink"),
	translate("Value in KByte/s, informational only")).rmempty = true


return m
