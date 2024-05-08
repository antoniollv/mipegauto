# Descripción de las POCs en cuenta privada de AWS

## Acciones comunes - Publicación de imágenes de contenedor en _AWS ECR_

Los paso descritos a continuación son comunes para todas las POCs realizadas

- Publicación de imágenes de contenedor en _AWS Elastic Container Registry (ECR)_

### Login con AWS CLI con cuenta AWS federada, SSO

Una vez realizada la configuración del usuario en la consola de AWS **instalar o actualizar a la última versión de _AWS CLI 2_**, ver documentación de AWS. Hay que de refrescar el entorno si se está actualizando, con cerra ventana de shell y abrir una nueva sobra

Configurar y login en la _CLI_

```Bash
aws configure sso-session
aws sso login --sso-session alledova
```

`alledova` es el nombre elegido para el perfil durante el proceso de configuración `aws configure sso-session`

El comando `aws configure sso-session` solo es necesario ejecutarlo una vez para configura el _SSO_

### Login en AWS Elastic Container Registry (ECR)

```Bash
aws ecr get-login-password --region eu-west-1 --profile alledova | docker login --username AWS --password-stdin 925989944655.dkr.ecr.eu-west-1.amazonaws.com
```

### Construcción y registro de la imagen de contenedor

En el ejemplo vemos como se construye y publica la imagen de contenedor para el servicio _AWS Lambda_, las diferencias respecto a la imagen para _AWS ECS_ radica en el **_Dockerfile_** utilizado, ya que la ruta de montaje del volumen _EFS_ difiere entre los dos servicios. El servicio _Lambda_ obliga a montar en `/mnt`, de modo que varían las propiedades de ruta de directorios en el archivo `pegauto.properties`

```Bash
docker build -t 925989944655.dkr.ecr.eu-west-1.amazonaws.com/moradores/lab:lambda -f Dockerfile.lambda .
docker push 925989944655.dkr.ecr.eu-west-1.amazonaws.com/moradores/lab:lambda
```

## POC AWS Elastic Container Service (ECS)

## los formatos disponibles con la opción -w de curl

Claro, a continuación te proporciono una lista de los formatos disponibles que puedes utilizar con la opción `-w` (o `--write-out`) de `curl` para personalizar la salida de acuerdo a tus necesidades:

1. **Variables de Información de la Solicitud/Respuesta HTTP**:

   - `%{url_effective}`: URL efectiva después de todas las redirecciones.
   - `%{http_code}`: Código de estado HTTP de la respuesta.
   - `%{http_connect}": Código de estado HTTP de la conexión.
   - `%{remote_ip}`: Dirección IP remota del servidor.
   - `%{time_total}`: Tiempo total de la operación en segundos.
   - `%{time_namelookup}`: Tiempo que tomó la resolución de nombres en segundos.
   - `%{time_connect}`: Tiempo que tomó establecer la conexión en segundos.
   - `%{time_appconnect}`: Tiempo que tomó la conexión de la aplicación en segundos.
   - `%{time_pretransfer}`: Tiempo que tomó antes de que se iniciara la transferencia en segundos.
   - `%{time_starttransfer}`: Tiempo que tomó hasta que se empezó a recibir la primera respuesta en segundos.
   - `%{size_download}`: Tamaño de la descarga en bytes.
   - `%{size_upload}`: Tamaño de la carga en bytes.
   - `%{speed_download}`: Velocidad de descarga en bytes por segundo.
   - `%{speed_upload}`: Velocidad de carga en bytes por segundo.
   - `%{content_type}`: Tipo de contenido de la respuesta.
   - `%{redirect_url}`: URL a la que se redirigió en caso de una redirección.

2. **Variables de Información de SSL/TLS**:

   - `%{ssl_verify_result}`: Resultado de la verificación SSL/TLS.
   - `%{ssl_cipher}`: Nombre de la cifra SSL/TLS utilizada.

3. **Variables de Información de FTP**:

   - `%{ftp_entry_path}`: Ruta de entrada del servidor FTP.

Para usar cualquiera de estas variables de formato, simplemente colócalas dentro de la cadena de formato que pasas con la opción `-w`. Por ejemplo:

```bash
curl -w "Tiempo total: %{time_total}s | Código de estado: %{http_code}\n" https://example.com
```

Este comando mostrará el tiempo total de la solicitud en segundos y el código de estado HTTP de la respuesta para la URL especificada.

Para obtener más información y consultar la lista completa de variables de formato disponibles, puedes consultar la documentación oficial de `curl` en línea o ejecutar `man curl` en tu terminal para ver la página del manual.
