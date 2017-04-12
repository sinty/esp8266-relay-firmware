-- file : config.lua
local module = {}

module.SSID = {}  
module.SSID["SSID"] = "wifi_network_key"

module.HOST = "MQTT_address_or_ip"  
module.PORT = 1883  
module.ID = node.chipid()

-- rele pins
module.relay1 = 6
module.relay2 = 7

-- GPIO pins
module.gpio4 = 2
module.gpio5 = 1

-- LEDS
module.led_main = 0

module.ENDPOINT = "mqtt_end_point/" 
--.. node.chipid() .. "/"
return module  
