# Memorama de Equipos — Godot 4

Proyecto de la Fase 1: exploración práctica del editor de Godot 4 y creación de una escena interactiva mediante un juego tipo memorama.

## Descripción

El juego contiene 8 equipos y 16 cartas (8 parejas) organizadas en un tablero 4x4. El jugador selecciona dos cartas para encontrar parejas. El juego registra los movimientos, las parejas encontradas y muestra una pantalla de victoria al completar el tablero.

## Requisitos

- Godot 4.3 o superior.
- Renderer Compatibility.

## Ejecución

1. Abrir/importar el proyecto mediante `project.godot`.
2. Ejecutar el proyecto con **F6** o **F5**.

## Estructura

- `scenes/Main.tscn`: escena principal, tablero, HUD y pantalla de victoria.
- `scenes/Card.tscn`: escena reutilizable de una carta.
- `scripts/Main.gd`: creación del tablero, comparación de cartas y control del juego.
- `scripts/Card.gd`: comportamiento individual de cada carta.
- `assets/`: imágenes del reverso y de los equipos.
- `DOCUMENTACION.md`: resumen de la documentación estudiada y respuestas a las preguntas guía.

## Señales

Se utiliza la señal personalizada `card_revealed` de cada carta para comunicar al nodo principal que una carta fue seleccionada. También se conectan señales `pressed` para la interacción con las cartas y botones.

## Nota

La carpeta `.godot/` no forma parte del repositorio de entrega, ya que Godot la genera automáticamente al abrir el proyecto.
