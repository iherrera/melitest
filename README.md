### MeLiTest - MercadoLibre API Exercise

Setup:

- La App usa CocoaPods como manejador de dependencias. Ejecutar "pod install" y abrir el workspace en lugar del proyecto.

- Base URL y Public Key se setean en info.plist

La App fue desarrollada utilizando Swift 4, haciendo énfasis en Protocol Oriented Programming. Diseñé Api Manager para estar totalmente desacoplado del framework de networking (Alamofire en este caso) y ser altamente testeable. Codable protocol y JSONDecoder son usados para parsear los modelos provenientes del backend.  

El código está comentado en inglés (como norma general) y en partes significativas.

### Unit Tests

Elegí testear la clase ApiManager ya que me pareció lo más significativo. La estrategia consistió en inyectar un network manager mockeado para simular las llamadas exitosas y fallidas al backend.

### UI / Integration Tests

XCTest fue utilizado para testear UI/Integración. Un network manager mockeado (diferente al de los Unit Tests) fue usado para simular las llamadas al backend y completar los datos necesarios para llevar a cabo los tests.
