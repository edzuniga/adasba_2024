class ApiRoutes {
  //*Auth routes
  //URL principal de la dirección de la API
  static const urlApi = '3.140.55.34:8080';
  //static const urlApi = '10.0.2.2:8888'; //Pruebas con android emulator

  //*RUTAS DE AUTENTICACIÓN
  //Método POST -- LOGIN
  //Método PATCH -- RENOVAR TOKEN - se le debe agregar el $id al final
  //y se envía el refresh_token en json a través del body
  //Método DELETE - para hacer el logout - se le debe agregar el $id al final
  static const authApiRoute = '/api_sgp_mo/v1/sessions';

  //Obtener todos los usuarios
  //Método GET
  static const allUsersRoute = '/api_sgp_mo/v1/users/codalea_org/';
  //Para un SOLO usuario
  //Método PATCH -- se le debe agregar el $id al final
  //y se envía el access_token en el header
  //Método DELETE - se le debe agregar el $id al final
  static const userRoute = '/api_sgp_mo/v1/users/';
  static const addUserRoute = '/api_sgp_mo/v1/users';

  //Obtener todos los grupos
  //Método GET
  static const allGruposRoute = '/api_sgp_mo/v1/grupos/codalea_org/';
  //Para un SOLO usuario
  //Método PATCH -- se le debe agregar el $id al final
  //y se envía el access_token en el header
  //Método DELETE - se le debe agregar el $id al final
  static const grupoRoute = '/api_sgp_mo/v1/grupos/';
  static const addGrupoRoute = '/api_sgp_mo/v1/grupos';

  //*PROYECTOS
  static const allProyectosRoute = '/api_sgp_mo/v1/proyectos/codalea_org/';
  static const proyectoRoute = '/api_sgp_mo/v1/proyectos/';
  static const addProyectoRoute = '/api_sgp_mo/v1/proyectos';

  //*ACTORES
  static const allActoresRoute = '/api_sgp_mo/v1/actores/codalea_org/';
  static const actorRoute = '/api_sgp_mo/v1/actores/';
  static const addActorRoute = '/api_sgp_mo/v1/actores';

  //*COMPROMISOS LEY
  static const allCompromisosLeyRoute =
      '/api_sgp_mo/v1/compromisos/codalea_org/';
  static const compromisoLeyRoute = '/api_sgp_mo/v1/compromisos/';
  static const addCompromisoLeyRoute = '/api_sgp_mo/v1/compromisos';

  //*FUENTES
  static const allFuentesRoute = '/api_sgp_mo/v1/fuentes/codalea_org/';
  static const fuenteRoute = '/api_sgp_mo/v1/fuentes/';
  static const addFuenteRoute = '/api_sgp_mo/v1/fuentes';

  //*COMPONENTES
  static const allComponentesRoute = '/api_sgp_mo/v1/componentes/codalea_org/';
  static const componenteRoute = '/api_sgp_mo/v1/componentes/';
  static const addComponenteRoute = '/api_sgp_mo/v1/componentes';

  //*INDICADORES
  static const allIndicadoresRoute = '/api_sgp_mo/v1/indicadores/codalea_org/';
  static const indicadorRoute = '/api_sgp_mo/v1/indicadores/';
  static const addIndicadorRoute = '/api_sgp_mo/v1/indicadores';
}
