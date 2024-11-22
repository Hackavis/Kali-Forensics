#!/bin/bash
# Definir colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # Sin Color

# Función de menú de ayuda
show_help() {
    echo -e "${YELLOW}Ayuda del script de instalación de herramientas de forense digital:${NC}"
    echo -e "${GREEN}-d${NC} : Instala herramientas de adquisición de datos."
    echo -e "${GREEN}-r${NC} : Instala herramientas de análisis de red."
    echo -e "${GREEN}-s${NC} : Instala herramientas de análisis de sistemas."
    echo -e "${GREEN}-m${NC} : Instala Volatility y sus dependencias para el análisis de memoria."
    echo -e "${GREEN}-rd${NC} : Instala herramientas de análisis de disco y recuperación de datos."
    echo -e "${GREEN}-t <nombre_herramienta>${NC} : Instala una herramienta específica por nombre."
    echo -e "${GREEN}-h${NC} : Muestra este menú de ayuda."
}

# Función para actualizar e instalar paquetes
update_and_install() {
    echo -e "${YELLOW}Actualizando lista de paquetes y realizando instalación...${NC}"
    sudo apt-get update
    sudo apt-get install -y "$@"
    sudo apt install forensics-all
}

# Funciones de instalación por categoría con herramientas específicas
install_data_acquisition() {
    echo -e "${YELLOW}Instalando herramientas de adquisición de datos...${NC}"
    update_and_install dc3dd guymager exfat-fuse exfat-utils

}

install_disk_analysis() {
    echo -e "${YELLOW}Instalando herramientas de análisis de disco y recuperación de datos...${NC}"
    update_and_install autopsy sleuthkit testdisk photorec scalpel
}

install_network_analysis() {
    echo -e "${YELLOW}Instalando herramientas de análisis de red...${NC}"
    update_and_install wireshark tcpdump nmap tshark
}

install_system_analysis() {
    echo -e "${YELLOW}Instalando herramientas de análisis de sistemas...${NC}"
    update_and_install chkrootkit rkhunter lynis
}

# Función actualizada para instalar Volatility
install_memory_analysis() {
    echo -e "${YELLOW}Preparando la instalación de Volatility...${NC}"
    sudo apt update
    sudo apt-get install dwarfdump pcregrep libpcre2-dev -y
    sudo apt install -y python2.7
    sudo apt install -y build-essential python2.7-dev python2-dev
    

    wget https://gist.githubusercontent.com/anir0y/a20246e26dcb2ebf1b44a0e1d989f5d1/raw/a9908e5dd147f0b6eb71ec51f9845fafe7fb8a7f/pip2%2520install -O run.sh 
    chmod +x run.sh 
    ./run.sh

    echo -e "${YELLOW}Instalando Volatility...${NC}"
    pip2 install pycrypto distorm3
    git clone https://github.com/volatilityfoundation/volatility.git
    chmod +x volatility/vol.py
    sudo mv volatility /opt
    sudo ln -s /opt/volatility/vol.py /usr/bin/vol.py
    sudo ln -s /opt/volatility/vol.py /usr/bin/volatility
    echo -e "${GREEN}Volatility instalado correctamente.${NC}"
}

# Función para instalar una herramienta específica
install_specific_tool() {
    tool_name=$1
    echo -e "${YELLOW}Instalando $tool_name...${NC}"
    update_and_install "$tool_name"
}

# Procesar argumentos de línea de comandos
while getopts ":drsmrdt:h" opt; do
  case ${opt} in
    h )
      show_help
      exit 0
      ;;
    d )
      install_data_acquisition
      ;;
    r )
      install_network_analysis
      ;;
    s )
      install_system_analysis
      ;;
    m )
      install_memory_analysis
      ;;
    rd )
      install_disk_analysis
      ;;
    t )
      install_specific_tool "$OPTARG"
      ;;
    \? )
      echo "Opción inválida: -$OPTARG" 1>&2
      show_help
      exit 1
      ;;
    : )
      echo "Opción -$OPTARG requiere un argumento." 1>&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

# Verificar si se pasaron argumentos. Si no, mostrar un mensaje.
if [ $OPTIND -eq 1 ]; then 
    echo -e "${RED}No se proporcionaron argumentos. Use -h para obtener ayuda.${NC}"
fi
