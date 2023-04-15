#include <Arduino.h>
#include <ArduinoJson.h>
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>

#define SERVICE_UUID "713D0000-503E-4C75-BA94-3148F18D941E"

// cho client nhận tin nhắn và đang ký thông báo khi có tin nhẵn mới, service gửi tin nhắn
#define CHARACTERISTIC_UUID_TX "713D0003-503E-4C75-BA94-3148F18D941E"

// để client dùng gửi tin nhắn tới server và server nhận tin nhắn
#define CHARACTERISTIC_UUID_RX "713D0002-503E-4C75-BA94-3148F18D941E"

BLEServer *pServer;
BLEService *pService;
BLECharacteristic *pCharacteristicTX;
BLECharacteristic *pCharacteristicRX;

void sendMessage(std::string value)
{

  pCharacteristicTX->setValue(value);
  pCharacteristicTX->notify();
}

class MyServerCallbacks : public BLEServerCallbacks
{
  void onConnect(BLEServer *pServer)
  {
    Serial.println("onConnect");
  };

  void onDisconnect(BLEServer *pServer)
  {
    Serial.println("onDisconnect");
    pServer->startAdvertising();
  }
};

void sendJsonData(JsonDocument &jsonDoc, BLECharacteristic *characteristic)
{
  String json;
  serializeJson(jsonDoc, json);

  characteristic->setValue(json.c_str());
  characteristic->notify();
}
void onRestartESP()
{
  Serial.println("Restarting in 5 seconds");
  delay(5000);
  ESP.restart();
}

class MyCharacteristicCallbacks : public BLECharacteristicCallbacks
{

  void onWrite(BLECharacteristic *pCharacteristic)
  {
    std::string rxValue = pCharacteristic->getValue();
    // Serial.print("value received = ");
    // Serial.println(rxValue.c_str());
    DynamicJsonDocument doc(256);
    DeserializationError error = deserializeJson(doc, rxValue);
    serializeJson(doc, Serial);
    if (!error)
    {
      if (doc["joystick"].isNull() == false)
      {
        // Giá trị của [xValue,yValue] là -1.0 -> 1.0
        double xValue = doc["joystick"]["x"];
        if (xValue >= 0)
        {
          Serial.println("Tiến tới");
        }

        else
        {
          Serial.println("Lùi lại");
        }

        double yValue = doc["joystick"]["y"];

        if (yValue >= 0)
        {
          Serial.println("Điều hướng qua phải");
        }
        else
        {
          Serial.println("Điều hướng qua trái");
        }
      }
      if (doc["button"].isNull() == false)
      {
        bool button1 = doc["button"]["button1"];
        bool button2 = doc["button"]["button2"];
        bool button3 = doc["button"]["button3"];
        bool buttonDefault = doc["button"]["buttonDefault"];
      }
    }
  }
};

void setup()
{
  Serial.begin(115200);
  Serial.println("Esp32 ble");

  BLEDevice::init("Blue_ESP32");

  // Create the BLE Server
  pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());

  // Create the BLE Service
  pService = pServer->createService(SERVICE_UUID);

  // Create a BLE Characteristic
  pCharacteristicTX = pService->createCharacteristic(
      CHARACTERISTIC_UUID_TX,
      BLECharacteristic::PROPERTY_NOTIFY | BLECharacteristic::PROPERTY_READ);

  pCharacteristicTX->addDescriptor(new BLE2902());

  pCharacteristicRX = pService->createCharacteristic(
      CHARACTERISTIC_UUID_RX,
      BLECharacteristic::PROPERTY_WRITE);

  // set callbacks để nhận tin nhắn từ client
  pCharacteristicRX->setCallbacks(new MyCharacteristicCallbacks());

  pService->start();
  BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(SERVICE_UUID);
  pAdvertising->setScanResponse(true);
  pAdvertising->setMinPreferred(0x06); // functions that help with iPhone connections issue
  pAdvertising->setMinPreferred(0x12);
  BLEDevice::startAdvertising();
  Serial.println("Characteristic defined! Now you can read it in the Client!");
}

void loop()
{
}