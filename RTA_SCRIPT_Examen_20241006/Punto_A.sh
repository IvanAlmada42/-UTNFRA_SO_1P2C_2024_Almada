#!/bin/bash

echo "Aca estoy creando la estructura de directorio"

mkdir -p $HOME/Examenes-UTN/{alumno_{1..3}/parcial_{1..3},profesores}

echo "Aca se va a mostrar la estructura"

tree $HOME/Examenes-UTN
