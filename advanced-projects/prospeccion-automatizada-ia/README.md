# Agente de Prospección Comercial Automatizada con IA

Sistema de automatización end-to-end que identifica empresas potenciales, investiga su negocio automáticamente, y redacta mails de venta personalizados con IA generativa — adaptando incluso el idioma según el mercado del cliente.

## El problema

Los equipos comerciales que buscan abrir mercados internacionales enfrentan un cuello de botella clásico: la prospección manual (investigar cada empresa, redactar un mensaje personalizado, enviarlo, hacer seguimiento) no escala. Cuantas más empresas se quieren contactar, más tiempo humano se necesita — y ese tiempo no se está usando en las conversaciones que realmente generan valor: cerrar reuniones.

**El objetivo:** construir un pipeline que automatice todo el proceso repetitivo (investigación + redacción + envío + registro), mientras mantiene la calidad y personalización de un mensaje escrito a mano.

## Cómo funciona

```
Google Sheets → Limpieza de datos (Python) → Web Scraping → Extracción de texto →
IA Generativa (redacción + idioma según país) → Envío por Gmail → Registro y control de duplicados
```

1. **Fuente de datos**: una hoja de Google Sheets con la lista de empresas a contactar (nombre, web, email, país).
2. **Validación y limpieza (Python)**: se descartan filas con datos inválidos o vacíos, se normalizan URLs con formatos inconsistentes (links de Markdown, URLs sin protocolo, etc.), y se filtran las empresas que ya recibieron un mensaje previamente (control de duplicados).
3. **Scraping**: se descarga el HTML de la web de cada empresa y se extrae la meta descripción — la síntesis que la propia empresa escribió sobre su negocio, mucho más limpia que el texto de navegación de la página.
4. **Redacción con IA (Gemini)**: un prompt diseñado con foco en copywriting B2B analiza esa descripción y redacta un mail corto, persuasivo y sin sonar robótico, mencionando detalles reales del negocio del prospecto. El mismo prompt decide el idioma de salida según el país de la empresa (español para mercados hispanohablantes, inglés para el resto).
5. **Envío y registro**: el mail se manda por Gmail, se marca la empresa como "contactada" para no duplicar el envío, y se guarda un log completo (empresa, contacto, fecha, contenido) para trazabilidad.

## Estructura esperada del Google Sheet de origen

| Columna         | Descripción                                                        |
|------------------|---------------------------------------------------------------------|
| `Nombre_Empresa` | Nombre de la empresa a contactar                                     |
| `Web`            | URL del sitio web (tolera formatos inconsistentes: sin protocolo, en formato Markdown, etc.) |
| `Email_Contacto` | Email de contacto                                                    |
| `País`           | Usado para decidir el idioma del mensaje generado                    |
| `Enviado`        | Se completa automáticamente tras el envío exitoso (control de duplicados) |

> **Nota:** el workflow requiere estas columnas con estos nombres exactos, ya que el script de validación las busca por clave. El JSON del flujo no incluye credenciales ni el ID del Sheet real — se comparte como evidencia de la arquitectura y lógica del sistema, no como un flujo listo para ejecutar sin configuración propia.

## Stack técnico

- **n8n** — orquestación del flujo
- **Python** — validación, limpieza y normalización de datos
- **Google Sheets API** — fuente de datos y logging
- **Web Scraping (HTTP + HTML parsing)** — extracción de información de sitios web
- **Google Gemini (LLM)** — generación de contenido personalizado
- **Gmail API** — envío automatizado

## Ejemplo de resultado

Ver [`ejemplos/mails_generados.md`](./ejemplos/mails_generados.md) para mails reales generados por el sistema, incluyendo el cambio automático de idioma según el país de la empresa contactada.

## Desafíos técnicos resueltos

- **Normalización de datos inconsistentes**: URLs con formato Markdown, sin protocolo, o mal escritas.
- **Manejo de errores en scraping real**: sitios con protección anti-bot, HTML de gran tamaño que agotaba la memoria del proceso, contenido dinámico (SPA) que no aporta texto útil sin ejecutar JavaScript.
- **Calidad del input para la IA**: descartar el ruido de navegación/menús y priorizar la meta descripción como fuente de contexto limpia.
- **Idempotencia**: sistema de control de duplicados para evitar reenvíos accidentales a la misma empresa.
- **Localización dinámica**: un mismo prompt decide el idioma de salida según el mercado de destino, sin lógica de programación adicional.

## Estado del proyecto

Prueba de concepto funcional, probada con empresas reales de distintos rubros (retail, industrial, tecnología) y países (Argentina, España, Estados Unidos).
