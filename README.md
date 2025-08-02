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

## ⚠️ ¿Por qué tarda en “🔁 Actualizando paquetes…”?

No te preocupes si parece que se queda congelado.  
Termux tiene muchas fuentes, y si tu conexión es lenta o el mirror está saturado, puede tardar **30 segundos a 2 minutos** en actualizar.

➡️ Para evitar que parezca bloqueado, el script ahora muestra un **spinner animado** mientras actualiza.

---

## 🔧 Instalación

### 1. Abre Termux y clona el repositorio:

```bash
git clone https://github.com/dasth3tic/termux-setup-menu.git
cd termux-setup-menu
