Proyecto hecho por:
Anthony Guevara
Dario Espinoza
Jerson Prendas
Marbel Brenes

Funciones
1. Enviar Mensajes
Después de seleccionar un canal, simplemente se escribe un mensaje y se presiona Enter para enviarlo. El mensaje será procesado por 
Kafka y almacenado en MongoDB para que no se pierda si se cierra la aplicación.
Ejemplo:
Usuario: Ingresa al canal general
Acción: Escribe "¡Hola a todos!" y presiona Enter.
Resultado: El mensaje se muestra en tiempo real a todos los que están en el canal general.
2. Cambiar de Canal
¿Cómo funciona?
Puedes cambiar de canal en cualquier momento durante la sesión. Solo necesitas ingresar el nombre del nuevo canal cuando se te solicite y
 automáticamente comenzarás a ver los mensajes de ese canal.
Ejemplo:
Usuario: Está en el canal general.
Acción: Decide cambiar al canal tech.
Resultado: Escribe tech cuando se le pide el nuevo canal y automáticamente ve los mensajes de tech.
3. Leer Mensajes Viejos
¿Cómo funciona?
Al unirte a un canal, automáticamente se te mostrarán los últimos mensajes enviados en ese canal antes de la llegada.
Ejemplo:
Usuario: Se une al canal tech.
Acción: Al ingresar, la aplicación recupera y muestra los últimos 10 mensajes del canal tech.
Resultado: El usuario puede leer lo que se ha discutido anteriormente sin tener que preguntar o sentirse perdido.