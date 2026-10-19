#include <ESP8266WiFi.h>

// ===== Wi-Fi settings =====
const char* ssid = "Motors";
const char* password = "12345678";

WiFiServer server(80);

// ===== TB6612FNG pins =====
// GPIO numbers for the ESP8266
// These assignments assume your PCB exposes these GPIOs.

const int EN12 = 5;    // GPIO5
const int AIN1 = 4;    // GPIO4
const int AIN2 = 14;   // GPIO14

const int PWMB = 12;   // GPIO12
const int BIN1 = 13;   // GPIO13
const int BIN2 = 16;   // GPIO16

// ===== PWM settings =====
const int PWM_MAX = 1023;
int motorSpeed = 200;  // Slider value: 0-255

// ===== Motor control =====

void stop() {
  digitalWrite(EN12, HIGH);
  digitalWrite(AIN1, HIGH);
  digitalWrite(AIN2, HIGH);
}

void forward() {
  digitalWrite(EN12, HIGH);
  digitalWrite(AIN1, HIGH);
  digitalWrite(AIN2, LOW);
}

void backward() {
  digitalWrite(EN12, HIGH);
  digitalWrite(AIN1, LOW);
  digitalWrite(AIN2, HIGH);
}

// ===== Webpage =====

String makePage() {
  String page = R"rawliteral(
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Rolling Bob</title>

  <style>
    body {
      font-family: Arial, sans-serif;
      text-align: center;
      background: #f0f3f7;
      margin: 0;
      padding: 20px;
    }

    h1 {
      color: #182b49;
    }

    .panel {
      background: white;
      max-width: 400px;
      margin: auto;
      padding: 22px;
      border-radius: 16px;
      box-shadow: 0 3px 12px #0002;
    }

    button {
      width: 100%;
      padding: 18px;
      margin: 8px 0;
      font-size: 22px;
      border: none;
      border-radius: 10px;
      color: white;
      cursor: pointer;
    }

    .forward { background: #168447; }
    .backward { background: #2864c5; }
    .stop { background: #d93434; }

    input[type=range] {
      width: 100%;
      margin: 20px 0;
    }

    .speed {
      font-size: 20px;
      font-weight: bold;
    }
  </style>
</head>

<body>
  <div class="panel">
    <h1>Rolling Bob</h1>
    <p>ESP8266 Motor Control</p>

    <button class="forward"
      onclick="location.href='/F'">FORWARD</button>

    <button class="backward"
      onclick="location.href='/B'">BACKWARD</button>

    <button class="stop"
      onclick="location.href='/S'">STOP</button>

    <hr>

    <label for="speed">Motor speed</label>

    <div class="speed">
      <span id="speedValue">200</span> / 255
    </div>

    <input
      type="range"
      id="speed"
      min="0"
      max="255"
      value="200"
      oninput="document.getElementById('speedValue').textContent=this.value"
      onchange="fetch('/SPD?value='+this.value)"
    >

  </div>
</body>
</html>
)rawliteral";

  return page;
}

// ===== Setup =====

void setup() {
  pinMode(EN12, OUTPUT);
  pinMode(AIN1, OUTPUT);
  pinMode(AIN2, OUTPUT);
  pinMode(16, OUTPUT);

  stop();

  // WiFi.persistent(false);
  // WiFi.mode(WIFI_AP);

  // bool wifiStarted = WiFi.softAP(ssid, password);

  // if (wifiStarted) {
  //   Serial.println();
  //   Serial.println("Wi-Fi started successfully!");
  //   Serial.print("Network: ");
  //   Serial.println(ssid);
  //   Serial.print("Open: http://");
  //   Serial.println(WiFi.softAPIP());
  // } else {
  //   Serial.println("Wi-Fi failed to start!");
  // }

  // server.begin();
  // Serial.println("Web server started.");
}

// ===== Main loop =====

void loop() {
  delay(1000);
  forward();
  
  // WiFiClient client = server.available();

  // if (!client) {
  //   return;
  // }

  // client.setTimeout(1000);

  // String request = client.readStringUntil('\r');
  // client.readStringUntil('\n');

  // Serial.println(request);

  // // Forward
  // if (request.startsWith("GET /F ")) {
  //   forward();
  // }

  // // Backward
  // else if (request.startsWith("GET /B ")) {
  //   backward();
  // }

  // // Stop
  // else if (request.startsWith("GET /S ")) {
  //   stop();
  // }

  // // Speed slider: /SPD?value=0-255
  // else if (request.startsWith("GET /SPD?")) {
  //   int pos = request.indexOf("value=");

  //   if (pos >= 0) {
  //     int valueStart = pos + 6;
  //     int valueEnd = request.indexOf('&', valueStart);

  //     String value = (valueEnd < 0)
  //                      ? request.substring(valueStart)
  //                      : request.substring(valueStart, valueEnd);

  //     motorSpeed = constrain(value.toInt(), 0, 255);
  //     applySpeed();

  //     Serial.print("Speed: ");
  //     Serial.println(motorSpeed);
  //   }
  // }

  // // Respond with the webpage
  // client.println("HTTP/1.1 200 OK");
  // client.println("Content-Type: text/html; charset=utf-8");
  // client.println("Connection: close");
  // client.println();

  // client.print(makePage());

  // delay(1);
  // client.stop();
}
