iCorrupcion
===========

Prototipo para el reto **#DenunciaLaCorrupcion**  desarrollado por [Mesquitestudio](http://www.mesquitestudio.com). 


Descripción
-----------
La app podrá levantar denuncias de corrupción de los ciudadanos, la app le mostrara al ciudadano una pantalla donde recabara toda la información requerida para poder detallar el problema. La denuncia contara con 4 etapas, que son las siguientes:

- Denuncia aun no enviada.
- Denuncia recibida.
- Denuncia atendida.
- Denuncia finalizada.

Version
----
1.0.0

Instrucciones
-----------
Pasos para poder correr el app.
- Clonar el repositorio.
- Usando la terminal se deberá posicionar en la carpeta del proyecto.
- Instalar los pod, usando el comando “pod install”.
- Abrir el archivo workspace.

Notas: El proyecto se realizo usando un dispositivo iPhone 5 y iOS8 



Manual
-----------
**Introducción**

Al iniciar la app se mostrara un instructivo con el funcionamiento de la app, esta solo aparecerá una vez.

**Denuncias**

Se mostrara una pantalla listado donde vera todas sus denuncias pendientes, En caso de no existir ninguna denuncia el usuario las podrás crear desde e boton de “plus”.

Se mostrar una nueva pantalla donde podrá crear una denuncia, se le solicitara al usuario que ingrese la siguiente información:
- Titulo
- Descripción.

Datos opcional:
- Foto.
- Video.
- Posición del usuario.
- Un punto en un mapa.
- Datos del usuario.
- Archivos adjuntos.

Al crear una denuncia se añadirá en el listado de denuncias y al dar tap sobre alguno ítem del listado podrá acceder a la pantalla de mensajes.

En la pantalla de menajes el usuario podrá estar en contacto con un técnico para recibir mas retroalimentación por parte del usuario que dio de alta la denuncia.

**Información**
Ademas de las denuncias en el app estará una sección informativa donde el usuario tendrá acceso a la siguiente información:
- Oficinas para realizar denuncias de manera presencial.
- Acceso a la instrucciones.
- Datos personales del usuario
- Aviso de privacidad
- Calificar el app por parte del usuario.

##Dependencias
**IOS**
- AFNetworking
- Mantle
- MZFormSheet
- SIAlertView
- MagicalRecord
- EDStarRating

**BACKEND**
- Laravel
- Bootstrap
- Datatables
- JQuery

##Demo Video
[![iCorrupcion](http://img.youtube.com/vi/Jo5ZkDNN248/0.jpg)](http://www.youtube.com/watch?v=Jo5ZkDNN248)

##Demo BACKEND
- [http://icorrupcion.mesquitestudio.com](http://icorrupcion.mesquitestudio.com)

##Licencia

The MIT License (MIT)
    http://opensource.org/licenses/MIT

Copyright 2014 Mesquitestudio

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.