local sys = require "luci.sys"
local ifaces = sys.net:devices()

m = Map("dhcp", translate("Tag your device"),
        translatef("Tag a device and set another gateway for it."))

s = m:section(NamedSection, "ext","tag", translate("Set another gateway and dns server for devices."))
-- s.template = "cbi/tblsection"
s.anonymous = false
s.addremove = true

tag = s:option(DynamicList, "dhcp_option", translate("Add dhcp_option here.3,means gateway;6,means dns"))
tag.optional = true
tag.datatype = "string"

m2 = Map("dhcp", translate("Devices with tags"),
        translatef("Select your devices"))

devices = m2:section(TypedSection, "host", translate("Bind to tag"))
devices.template = "cbi/tblsection"
devices.anonymous = true
devices.addremove = true

a = devices:option(Value, "name", translate("Device Name"))
a.datatype = "string"
a.optional = false

function a.validate(self, value)
        if value == "" then
                return nil, translate("Device name cannot be empty")
        end
        return value
end

a = devices:option(Value, "mac", translate("MAC Address"))
a.datatype = "macaddr"
a.optional = false
luci.ip.neighbors({family = 4}, function(neighbor)
        if neighbor.reachable then
                a:value(neighbor.mac, "%s (%s)" %{neighbor.mac, neighbor.dest:string()})
        end
end)

a = devices:option(Value, "tag", translate("Device Tag"))
a.datatype = "string"
a.optional = false
a:value('ext')

return m, m2

