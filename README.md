# Rappi Test Movie Catalog

![](movieCatalog.gif)

La aplicación cuenta con persistencia, por lo tanto esta puede ser utilizada sin datos. Una vez consultada la sección las películas y series visualizadas o buscadas se almacenan en la base de datos local y pueden ser vistas más adelante.

Los videos relacionados a la película o serie se pueden ver al deslizar el carousel en la sección de detalle.

Se puede calificar la película o serie en cuestión seleccionando las estrellas que se desea dar y presionando "Rate"

### Capas de aplicación
Existe en la aplicación una **capa de persistencia** en la que se encuentran los modelos de realm, esta capa se comunica mediante una fachada llamada "RealmHandler" con los controladores cuando es necesario, aquí se extrae información de la base de datos local y de igual manera se almacena

La **capa de datos** esta integrada por los modelos y se interactua con ella mediante una fachada llamada "DataFacade" que permite extraer datos utilizando la clase network y al hacer esto se almacena la información en la base de datos local con la ayuda del "RealmHandler"

Las **vistas** fueron creadas por medio de storyboards y xibs y se comunican entre ellas por medio de el "navigation controller" y una "tab bar", igualmente se instancian vistas de celdas para los posters de películas, una vista de video para el carousel que se encuentra en el detalle del film y la vista de detalle completa que se reusa para las películas y las series.

### Clases utilizadas

- DataFacade, esta clase de tipo fachada permite a los controladores pedir datos sin tener que preocuparse de si existe o no conexión a internet; aquí se evalua y se regresa la información ya sea de el endpoint o de la base de datos local en realm.
- Network: Esta clase es la que realiza la consulta de datos utilizando urlsession y contiene llamadas de tipo genericas para que pueda retornar cualquier tipo de datos que se necesite, aquí también existe una llamada para hacer un post del "rating" de la película o serie que se desee.
- En la clase Endpoints existen solo elementos de tipo static para poder llamarlos desde cualquier lugar de la aplicación; aquí se encuentran todos los urls de las llamadas de la apliación así como las constantes que se necesitan para hacer las requests. Las constantes podrían ir en el keychain pero por poco tiempo se incluyeron aquí.
- La clase connection status contiene un signletone de tipo booleano que se actualiza con el observable "**NWPathMonitor**", este permite identificar si existe conexión a internet y si esta cambia.
- La clase RealmHandler contiene una llamada generica para insertar objectos de cualquier tipo a la base de datos de realm. También tiene métodos para extraer la información y filtrarla de acuerdo a lo que se solicita.
- Existen extensiones para la creación de alertas, el activity indicator y la formulación de urls


Arquitectura
-------------

La acrquitectura utilizada fue MVC para poder tener los modelos tipo Decodable y Object(de Realm) y poder comunicar las vistas mediante un navigation controller.

Era posible utilizar clean swift pero por cuestiones personales no hubo tiempo para utilizar esta arquitectura.

#### Principio de responsabilidad única
-------------
El principio de responsabilidad única se refiere a que cada clase debe tener un único objetivo y no debe estar encargado de tareas que no le correspondan en su definición ya que esto puede llegar a crear una clase "Dios" y teniendo esto el código es díficil de mantener y cualquier cambio que requiera hacerse tendrá mayor complejidad. De igual manera las pruebas unitarias se vuelven complicadas teniendo clases con múltiples responsabilidades y esto lleva a que existan más errores en las aplicaciones

#### Código limpio
-------------
Para que el código pueda llamarse limpio es necesario que cumpla con características como no tener clases Dios, no tener código o espagueti o muchas funciones anidadas, no tener un buen manejo de errores y no manejar bien la interfaz.
Para esto es necesario contar con una buena arquitectura y definir los modelos y la capa de negocio estrictamente para que no exista un desorden en las clases, vistas y workers.

