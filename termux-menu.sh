#!/data/data/com.termux/files/usr/bin/bash

# 🎨 COLORES
verde="\e[32m"; rojo="\e[31m"; amarillo="\e[33m"; azul="\e[34m"; normal="\e[0m"

# 📁 ARCHIVOS
fecha=$(date +%Y-%m-%d)
LOG="errores_$fecha.log"
TMP_LOG="$HOME/.termux_temp_error.log"

# 📦 DEPENDENCIAS DEL SISTEMA
dependencias=(
  git curl wget nano vim openssh zip unzip tar
  python python2 python3 php ruby nodejs
  clang make cmake
  openssl zlib libtool libffi libcrypt libevent-dev
  libjpeg-turbo libjpeg-dev libpng-dev libxml2 libxslt
  libsqlite libsqlite-dev
  coreutils busybox util-linux grep sed ffmpeg binutils
  proot tsu
  python-dev openssl-dev libffi-dev libsqlite-dev libxml2-dev libxslt-dev libjpeg-turbo-dev libpng-dev
)

# 🐍 MÓDULOS PYTHON
modulos_python=(
  colorama requests urllib3 beautifulsoup4 lxml setuptools wheel
  pillow pygments python-dateutil flask pyyaml
)

# 📊 BARRA DE PROGRESO
barra_progreso() {
  local current=$1 total=$2 nombre="$3"
  local porcentaje=$((current * 100 / total))
  local completado=$((porcentaje / 2))
  local restante=$((50 - completado))
  printf "["
  printf "%0.s#" $(seq 1 $completado)
  printf "%0.s-" $(seq 1 $restante)
  printf "] %3d%% %s\r" "$porcentaje" "$nombre"
}

# 🔄 ACTUALIZAR TERMUX
actualizar_termux() {
  echo -e "${amarillo}🔁 Actualizando paquetes...${normal}"
  apt update -y &>/dev/null && apt upgrade -y &>/dev/null
  echo -e "${verde}✔ Sistema actualizado.${normal}"
}

# ✅ INSTALAR DEPENDENCIAS
instalar_dependencias() {
  actualizar_termux
  echo -e "${azul}📦 Instalando paquetes del sistema...${normal}"
  total=${#dependencias[@]}
  [ -f "$LOG" ] && mv "$LOG" "${LOG%.log}_backup_$(date +%s).log"
  > "$LOG"
  > installed_sys.log

  for i in "${!dependencias[@]}"; do
    nombre="${dependencias[i]}"
    barra_progreso $((i+1)) "$total" "$nombre"

    if pkg list-installed "$nombre" &>/dev/null; then
      echo "$nombre" >> installed_sys.log
      continue
    fi

    if ! pkg install -y "$nombre" &> "$TMP_LOG"; then
      if [ -s "$TMP_LOG" ]; then
        echo "$nombre | $(grep -m 1 -E 'E:|error:' "$TMP_LOG")" >> "$LOG"
      else
        echo "$nombre | Error desconocido" >> "$LOG"
      fi
    fi

    rm -f "$TMP_LOG"
    sleep 0.2
  done
  echo -e "\n${verde}✔ Paquetes del sistema procesados.${normal}"
}

# ✅ INSTALAR MÓDULOS PYTHON (sin errores en pantalla)
instalar_modulos_python() {
  actualizar_termux
  echo -e "${azul}🐍 Instalando módulos Python seguros...${normal}"
  pip install --upgrade pip setuptools wheel &>/dev/null
  total=${#modulos_python[@]}
  > "$LOG"
  > installed_py.log

  for i in "${!modulos_python[@]}"; do
    nombre="${modulos_python[i]}"
    barra_progreso $((i+1)) "$total" "$nombre"

    if pip show "$nombre" &>/dev/null; then
      echo "$nombre" >> installed_py.log
      continue
    fi

    if ! pip install "$nombre" > "$TMP_LOG" 2>&1; then
      if [ -s "$TMP_LOG" ]; then
        mensaje=$(grep -i -m 1 -E 'error|failed|exception|Could not|WARNING' "$TMP_LOG")
        [ -z "$mensaje" ] && mensaje=$(tail -n 1 "$TMP_LOG")
        echo "$nombre | $mensaje" >> "$LOG"
      else
        echo "$nombre | Error desconocido" >> "$LOG"
      fi
    fi

    rm -f "$TMP_LOG"
    sleep 0.2
  done

  echo -e "\n${verde}✔ Módulos Python procesados.${normal}"
}

# 🚨 MOSTRAR ERRORES
mostrar_errores() {
  if [ -s "$LOG" ]; then
    echo -e "\n${rojo}⚠️ Se detectaron errores durante la instalación:${normal}"
    echo -e "${azul}──────────────────── ERRORES ────────────────────${normal}"
    column -t -s '|' "$LOG"
    echo -e "${azul}─────────────────────────────────────────────────${normal}"
    echo -e "${amarillo}📁 Guardado en: ${LOG}${normal}"
  else
    echo -e "${verde}🎉 Todo se instaló correctamente sin errores.${normal}"
  fi
}

# 📦 VER PAQUETES YA INSTALADOS
mostrar_instalados() {
  echo -e "\n${azul}📦 Paquetes del sistema ya instalados:${normal}"
  [ -s installed_sys.log ] && column -t installed_sys.log || echo "Ninguno aún."

  echo -e "\n${azul}🐍 Módulos Python ya instalados:${normal}"
  [ -s installed_py.log ] && column -t installed_py.log || echo "Ninguno aún."
}

# 📋 MENÚ PRINCIPAL
mostrar_menu() {
  clear

  # 🖼️ CABECERA PERSONALIZABLE
  echo -e "${azul}🔧 MENÚ DE CONFIGURACIÓN PARA TERMUX${normal}"
  echo "────────────────────────────────────"
  echo -e "1️⃣  ${normal}Instalar dependencias del sistema"
  echo -e "2️⃣  ${normal}Instalar módulos Python"
  echo -e "3️⃣  ${normal}Ver errores registrados"
  echo -e "4️⃣  ${normal}Ver paquetes ya instalados"
  echo -e "5️⃣  ${normal}Salir"
  echo "────────────────────────────────────"
  read -p "👉 Selecciona una opción: " opcion

  case "$opcion" in
    1) instalar_dependencias; mostrar_errores ;;
    2) instalar_modulos_python ;;  # <–– SIN mostrar_errores aquí
    3) mostrar_errores ;;
    4) mostrar_instalados ;;
    5)
      # 👋 MENSAJE DE DESPEDIDA PERSONALIZABLE
      echo -e "${amarillo}👋 ¡Hasta luego, Alex!${normal}"
      exit 0
      ;;
    *) echo -e "${rojo}❌ Opción no válida.${normal}" ;;
  esac

  read -p "Presiona Enter para volver al menú..."
  mostrar_menu
}

# ▶️ INICIO
mostrar_menu
