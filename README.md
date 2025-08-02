# 🧰 Termux Setup Menu

Menú visual para instalar dependencias y módulos de Python en Termux sin errores, con barra de progreso, detección de errores y soporte completo para logs.

---

## 📦 ¿Qué hace este script?

- ✅ Instala automáticamente **todas las dependencias básicas del sistema**
- ✅ Instala módulos Python útiles que suelen ser necesarios
- ✅ Muestra **barra de progreso limpia** por cada elemento
- ✅ Registra errores en un archivo tipo `errores_YYYY-MM-DD.log`
- ✅ Opción para ver paquetes ya instalados
- ✅ Interfaz en menú tipo terminal

---

### 🧱 Instalar automáticamente:

- `git`
- `wget`
- `curl`
- `openssl`
- `proot`
- `ncurses-utils`
- `vim`
- `nano`
- `htop`
- `zip`, `unzip`
- `python`
- `clang`
- `make`
- `cmake`
- `openssl-tool`
- `libffi`
- `libcrypt`
- `libxml2`
- `libxslt`
- `clang`, `g++`, `binutils`
- `libjpeg-turbo`
- `libpng`
- `libwebp`
- `libtiff`
- `openblas`
- `sqlite`
- Y muchos otros necesarios para herramientas, compilación o entornos virtuales.

### 🐍 Instalar módulos de Python:

- `colorama`
- `requests`
- `urllib3`
- `beautifulsoup4`
- `lxml`
- `setuptools`
- `wheel`
- `pillow`
- `pygments`
- `python-dateutil`
- `flask`
- `pyyaml`

---

### 🧾 Extras:

- Muestra barra de progreso
- Detecta errores durante la instalación
- Guarda logs por día
- Todo en español



## ⚠️ ¿Por qué tarda en “🔁 Actualizando paquetes…”?

No te preocupes si parece que se queda congelado.  
Termux tiene muchas fuentes, y si tu conexión es lenta o el mirror está saturado, puede tardar **30 segundos a 2 minutos** en actualizar.
> Al seleccionar la opción 2, **el script puede parecer que se congela en “Actualizando paquetes...”**, pero no es un error. 
> Está ejecutando `apt update && apt upgrade`, lo cual puede tardar varios minutos.  
> **No cierres Termux, solo espera.**

➡️ Para evitar que parezca bloqueado, el script ahora muestra un **spinner animado** mientras actualiza.

---

## 🔧 Instalación

### 1. Abre Termux y clona el repositorio:

```bash
git clone https://github.com/dasth3tic/termux-setup-menu.git
cd termux-setup-menu
