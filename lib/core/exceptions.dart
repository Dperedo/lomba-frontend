///Excepciones utilizadas por el sistema.

///Para excepciones relacionadas con el backend.
class ServerException implements Exception {}

///Para excepciones relacionadas con el localStorage (Cache)
class CacheException implements Exception {}

///Para excepciones relacionadas con la conectividad (network)
class ConnectionException implements Exception {}

///Para excepciones relacionadas con la base de datos.
class DatabaseException implements Exception {}
