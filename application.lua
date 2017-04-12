-- file : application.lua
local module = {}  
m = nil

-- Sends a simple ping to the broker
local function send_ping()
    state1 = gpio.read(config.relay1) == 1 and "on" or "off"
    topic1 = config.ENDPOINT .. config.ID .. "/state/light1"
--    print("Send status " .. topic1 .. " " .. state1)
    m:publish(topic1, state1 ,0,0)
    state2 = gpio.read(config.relay2) == 1 and "on" or "off" 
    topic2 = config.ENDPOINT .. config.ID .. "/state/light2"
--    print("Send status " .. topic2 .. " " .. state2)
    m:publish(topic2, state2 ,0,0)
end

-- Sends my id to the broker for registration
local function register_myself()
    endpoint = config.ENDPOINT .. config.ID .. "/#"  
    m:subscribe(endpoint,0,function(conn)
        print("Successfully subscribed to data endpoint "  .. endpoint)
    end)
end

local function mqtt_start()  
    m = mqtt.Client(config.ID, 120)
    -- register message callback beforehand
    m:on("message", function(conn, topic, data) 
      light_1_topic = config.ENDPOINT .. config.ID .. "/switch/light1"
      light_2_topic = config.ENDPOINT .. config.ID .. "/switch/light2"
      pinstate = gpio.LOW
      if data == "on" then 
        pinstate = gpio.HIGH
      end 
      if topic == light_1_topic then
        print(topic .. ": " .. data)
        gpio.write(config.relay1, pinstate)
      elseif topic == light_2_topic then
        print(topic .. ": " .. data)
        gpio.write(config.relay2, pinstate)
      end
    end)
    -- Connect to broker
    m:connect(config.HOST, config.PORT, 0, 1, function(con) 
        register_myself()
        -- And then pings each 1000 milliseconds
        tmr.stop(6)
        tmr.alarm(6, 1000, 1, send_ping)
    end) 

end

function module.start()  
  print("Configure pins...")
  gpio.mode(config.relay1, gpio.OUTPUT)
  gpio.write(config.relay1, gpio.LOW)
  
  gpio.mode(config.relay2, gpio.OUTPUT)
  gpio.write(config.relay2, gpio.LOW)

  gpio.write(config.led_main, gpio.LOW)

  gpio.mode(config.gpio4, gpio.INPUT, gpio.PULLUP)
  gpio.mode(config.gpio5, gpio.INPUT, gpio.PULLUP)
  
  mqtt_start()
end

return module  
