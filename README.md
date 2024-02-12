# Kali-Forensics

Es un programa diseñado para facilitar la instalación de herramientas de forense digital en sistemas basados en Linux, específicamente en distribuciones como Debian o Ubuntu. Cada parte del script se encarga de una tarea específica, desde mostrar un menú de ayuda hasta instalar paquetes de software predeterminados asociados con diferentes categorías de análisis forense digital. Aquí te detallo cada sección del script:

.-Definición de Colores
El script comienza definiendo variables para colores que se utilizarán en la salida del texto, mejorando la legibilidad al resaltar diferentes secciones con colores distintos. Estos colores se aplican usando códigos de escape ANSI.


RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # Sin Color

.-Función de Menú de Ayuda (show_help)
Esta función imprime un menú de ayuda que describe cada opción disponible en el script. Las opciones permiten al usuario instalar conjuntos de herramientas específicas según la categoría de análisis forense sin necesidad de especificar cada herramienta individualmente.


show_help() { ... }
Funciones de Instalación por Categoría

.-Cada una de estas funciones se encarga de instalar un conjunto predeterminado de herramientas para una categoría específica de análisis forense. Por ejemplo, install_data_acquisition instala herramientas para la adquisición de datos forenses.

install_data_acquisition(): Instala herramientas de adquisición de datos.
install_disk_analysis(): Instala herramientas de análisis de disco y recuperación de datos.
install_memory_analysis(): Instala herramientas para el análisis de memoria.
install_network_analysis(): Instala herramientas para el análisis de redes.
install_system_analysis(): Instala herramientas para el análisis de sistemas.
Dentro de cada función, se llama a sudo apt-get install -y con la lista de paquetes a instalar, facilitando la automatización del proceso de instalación.

.-Función de Actualización e Instalación (update_and_install)
Esta función actualiza la lista de paquetes de apt y luego instala un conjunto específico de paquetes. Se utiliza dentro de las funciones de instalación por categoría para asegurar que las listas de paquetes estén actualizadas antes de la instalación.

update_and_install() { ... }

Función para Instalar una Herramienta Específica (install_specific_tool)

.-Permite al usuario instalar una herramienta específica proporcionando su nombre como argumento. Esta flexibilidad es útil cuando solo se necesita una herramienta en particular y no un conjunto completo asociado con una categoría.
install_specific_tool() { ... }

.-Procesamiento de Argumentos de Línea de Comandos
El bucle while getopts procesa los argumentos de línea de comandos proporcionados al script. Permite al usuario especificar qué acción desea realizar, como mostrar el menú de ayuda, instalar herramientas de una categoría específica, o instalar una herramienta específica por nombre

while getopts ":drsmrdt:h" opt; do { ... } done

.-Verificación de Argumentos
Al final del script, se verifica si se proporcionaron argumentos. Si no se pasaron argumentos, se muestra un mensaje indicando al usuario que utilice la opción -h para ver el menú de ayuda.

if [ $OPTIND -eq 1 ]; then { ... } fi

.-Cada sección del script está diseñada para ser autocontenida y modular, lo que facilita la adición o modificación de categorías y herramientas según sea necesario. Este script es un ejemplo práctico de cómo automatizar la gestión de paquetes en sistemas Linux, especialmente útil para profesionales en el campo de la seguridad informática y el análisis forense digital.





