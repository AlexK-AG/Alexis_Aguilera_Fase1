# Documentación — Fase 1: Godot 4

## 1. Objetivo de la actividad

La actividad consiste en familiarizarse con el editor de Godot 4 y aplicar sus conceptos básicos mediante un juego interactivo tipo memorama. El proyecto permite practicar la organización de escenas, nodos, jerarquías, propiedades del Inspector y señales.

## 2. Resumen de la documentación estudiada

### Lección 1 — Nodos y escenas

Godot organiza los juegos mediante **nodos**. Un nodo es una unidad con una función específica: puede representar una interfaz, una imagen, un botón, un objeto 2D/3D, una cámara, un área de colisión, etc. Los nodos se pueden combinar en una **escena**, que funciona como una unidad reutilizable del proyecto. Una escena tiene un nodo raíz y puede contener otros nodos hijos.

### Lección 2 — Instancias y organización

Las escenas pueden reutilizarse mediante instancias. Esto permite crear un elemento una sola vez y utilizarlo varias veces sin tener que construirlo desde cero. En este proyecto se aplica esta idea con `Card.tscn`: se define una carta reutilizable y `Main.gd` crea una instancia de esa escena para cada carta del tablero.

### Lección 3 — Primer proyecto y flujo de trabajo

El editor de Godot permite crear y modificar escenas, configurar propiedades, ejecutar el proyecto y organizar los recursos. El **Viewport** permite visualizar y colocar los elementos de la escena, mientras que el **Inspector** permite modificar sus propiedades. También es importante guardar las escenas y el proyecto antes de ejecutar y mantener nombres y carpetas descriptivos.

## 3. Aplicación en el memorama

El proyecto utiliza una escena principal `Main.tscn` que contiene el tablero, el HUD y la pantalla de victoria. La escena `Card.tscn` representa una carta reutilizable. `Main.gd` instancia 16 cartas, asigna las imágenes de los equipos, mezcla las posiciones y compara las dos cartas seleccionadas. `Card.gd` controla el estado de cada carta, su animación y su interacción con el jugador.

## 4. Preguntas guía

### ¿Qué diferencia observas entre un nodo y una escena?

Un nodo es un componente individual que realiza una función concreta dentro del juego. Una escena es una estructura formada por uno o varios nodos organizados jerárquicamente y que puede guardarse y reutilizarse. Por ejemplo, un `TextureButton` puede ser un nodo, mientras que `Card.tscn` es una escena que representa una carta completa y reutilizable.

### ¿Por qué es importante la jerarquía de nodos (qué hijo depende de qué padre)?

La jerarquía permite organizar los elementos y establecer relaciones entre ellos. Los nodos hijos pueden heredar transformaciones y depender del contexto de su nodo padre. También facilita encontrar y controlar los elementos desde los scripts. En `Main.tscn`, por ejemplo, el tablero está dentro de varios contenedores que controlan su distribución y tamaño.

### ¿Cómo se relaciona el Inspector con el Viewport?

El Viewport muestra visualmente la escena y permite observar dónde están colocados los elementos. El Inspector permite modificar las propiedades del nodo seleccionado, como tamaño, posición, texto, colores o comportamiento. Los cambios realizados en el Inspector se reflejan en la escena que se observa en el Viewport.

### ¿Qué ventajas tiene crear escenas reutilizables (como la carta)?

Una escena reutilizable evita repetir trabajo. En lugar de construir las 16 cartas manualmente, se crea `Card.tscn` una vez y el script la instancia tantas veces como sea necesario. Esto facilita mantener el proyecto organizado y hacer cambios: si se modifica la escena de la carta, las instancias pueden aprovechar esa estructura común.

## 5. Señales utilizadas

El proyecto utiliza señales para comunicar eventos entre nodos. `Card.gd` define la señal personalizada `card_revealed(card: Card)`, que se emite cuando el jugador selecciona una carta. `Main.gd` conecta esa señal para recibir la carta seleccionada y determinar si forma una pareja con la siguiente. También se conectan señales `pressed` de las cartas y de los botones de reinicio.

## 6. Organización del proyecto

```text
project/
├── project.godot
├── icon.svg
├── assets/
│   ├── backgrounds/
│   └── teams/
├── scenes/
│   ├── Main.tscn
│   └── Card.tscn
└── scripts/
    ├── Main.gd
    └── Card.gd
```

No se incluye la carpeta `.godot/` porque contiene archivos generados por el editor.

## 7. Experimentación y creatividad

Además del funcionamiento básico, el proyecto incorpora animaciones para voltear las cartas, una animación para ocultar las parejas encontradas, contador de movimientos, contador de parejas, pantalla de victoria y botones para reiniciar o jugar nuevamente. Estas características hacen que la actividad sea más interactiva que un tablero estático.
