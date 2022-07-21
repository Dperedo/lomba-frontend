# newflutter - lomba

A new Flutter project.

## Getting Started

Para ejecutar el primer test del proyecto, es necesario hacer lo siguiente:

Primero revisar que la URL del backend sea la correcta. 
Esto se revisa en el archivo /lib/helpers/preferences.dart

Segundo: descargar chromedriver desde https://chromedriver.chromium.org/downloads
Descargar en una carpeta y levantarlo con el siguiente comando desde una terminal o consola:

´´´
./chromedriver.exe --port=4444
´´´

Después, en la raíz del proyecto ejecutar el siguiente comando

´´´
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/permissions_test.dart -d chrome
´´´

Para dockerizar los comandos son los siguientes:

´´´
docker build --build-arg APIURL=http://localhost:8287  -t lombafrontend --no-cache .
´´´
El parámetro APIURL es opcional.

Luego para levantar, hacer lo siguiente:

´´´
docker run -d -p 1201:80 --name frontlocal lombafrontend
´´´