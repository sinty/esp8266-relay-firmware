# esp8266-relay-firmware
Firmware for esp8266 ralays modules

Tested with Electrodragon NWI1072 Wifi IoT Relay Board Based on ESP8266.

http://www.electrodragon.com/product/wifi-iot-relay-board-based-esp8266/

Receive command from MQTT server and periodical send state to MQTT server.

Based on

https://www.foobarflies.io/a-simple-connected-object-with-nodemcu-and-mqtt/

Home assistant integration example:

```
light:
  - platform: mqtt
    name: "Bedroom ligh 2"
    state_topic: "electrodragon/1710755/state/light2"
    command_topic: "electrodragon/1710755/switch/light2"
    payload_on: "on"
    payload_off: "off"
    optimistic: false
  - platform: mqtt
    name: "Bedroom light 1"
    state_topic: "electrodragon/1710755/state/light1"
    command_topic: "electrodragon/1710755/switch/light1"
    payload_on: "on"
    payload_off: "off"
    optimistic: false
```
