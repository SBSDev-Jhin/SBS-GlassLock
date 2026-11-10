# SBS GlassLock

**Bloqueo de pantalla transparente para X11, con huella y contraseña en paralelo.**
Bloquea la sesión sin ocultarla: el escritorio sigue visible, un punto pequeño muestra el estado y se desbloquea con
la contraseña **o** la huella, lo que ocurra primero.

Es un fork de [XSecureLock](https://github.com/google/xsecurelock) de Google, mantenido por
[SmartBrain Services](https://smartbrainservices.com), con licencia Apache-2.0. **No está afiliado ni respaldado por
Google.** Lee el [aviso legal](DISCLAIMER.md) antes de usarlo.

- **Punto verde** (arriba a la derecha de cada monitor): esperando contraseña o huella.
- **Punto rojo**: intento fallido; vuelve a verde a los 2 s.

## Comparación con xtrlock y XSecureLock

Mantiene lo que gusta de xtrlock (la pantalla sigue visible) y el soporte PAM de XSecureLock. A diferencia de xtrlock,
admite huella y cualquier método PAM, con indicador en cada monitor. A diferencia de XSecureLock original, deja el
escritorio visible y acepta contraseña y huella en paralelo. A cambio, no oculta la pantalla, necesita un compositor y
se compila desde el código fuente. Tabla completa y desventajas: [docs/COMPARISON.md](docs/COMPARISON.md) (en inglés).

## Instalación rápida

Requiere Linux con sesión **X11** y un **compositor** activo. No funciona en Wayland
([compatibilidad](docs/COMPATIBILITY.md)).

```bash
# 1. dependencias (Debian/Ubuntu)
sudo apt install build-essential autoconf automake pkg-config libx11-dev libxext-dev libxcomposite-dev \
  libxss-dev libpam0g-dev libxft-dev libxrandr-dev libxfixes-dev libxmu-dev libxmuu-dev

# 2. descargar e instalar (pide sudo una vez, solo para crear dos servicios PAM)
git clone https://github.com/<usuario>/sbs-glasslock.git && cd sbs-glasslock
bash contrib/sbs-glasslock/install.sh            # añade --no-fingerprint si no tienes lector de huella

# 3. probar con seguridad: se desbloquea solo a los 30 segundos
timeout 30 ~/.local/bin/sbs-glasslock
```

Después asigna `~/.local/bin/sbs-glasslock` a un atajo de teclado (ejemplos en [docs/INSTALL.md](docs/INSTALL.md)).

## Uso

1. Ejecuta `sbs-glasslock` (o tu atajo). La pantalla queda como está.
2. Toca cualquier tecla (se descarta): aparece el punto verde.
3. Escribe la contraseña y Enter, o usa la huella.

## Avisos importantes

- **No oculta la pantalla**: lo que esté visible (ventanas, notificaciones) puede leerse con el equipo bloqueado.
  No es un bloqueo de privacidad.
- **Prueba siempre con `timeout 30 ...`**: una configuración PAM incorrecta podría impedirte desbloquear. Ten a mano
  una consola de texto (`Ctrl+Alt+F2`).
- Se ofrece "tal cual", sin garantías. Ver [DISCLAIMER.md](DISCLAIMER.md) y [SECURITY.md](SECURITY.md).

Más información (en inglés): [instalación](docs/INSTALL.md), [compatibilidad](docs/COMPATIBILITY.md),
[funcionamiento](docs/HOW-IT-WORKS.md).

## Créditos

Construido sobre [XSecureLock](https://github.com/google/xsecurelock) de Google, inspirado en xtrlock, y apoyado en
Linux-PAM, fprintd/libfprint y X.Org. Lista completa con enlaces: [CREDITS.md](CREDITS.md).

## Licencia

Apache License 2.0, igual que el original. Trabajo original © Google Inc.; modificaciones © 2026 SmartBrain
Services, S.A.S. de C.V.
