#!/bim/bash

# Mostramos un mensaje inicial indicando el comienzo del proceso de la creacion de particiones
echo "Iniciando la creación de una partición extendida en el disco /dev/sdc..."

# Utilizamos fdisk para crear la tabla de particiones
{
    echo "o"    # Crear una nueva tabla de particiones
    echo "n"    # Agregar una nueva partición
    echo "p"    # Especificar que es una particion primaria
    echo "1"    # Definir número de partición
    echo ""     # Dejar en blanco para usar el predeterminado
    echo "+10G" # Establecer el tamaño 10 GB , creando la partición extendida
    
    echo "n"    # Agregar otra nueva partición
    echo "e"    # Definir como partición extendida
    echo "2"    # Establecer el número de la segunda partición
    echo ""     # Dejar primer sector en blanco para usar el predeterminado
    echo ""     # Usar el espacio restante en el disco para esta partición

    # Crear particiones lógicas de 1 GB dentro de la partición extendida

    for i in {5..14}
    do
        echo "n"  # Nueva partición
        echo "l"  # Designar como particion lógica
        echo "$i" # Número de la partición lógica
        echo ""   # Dejar el primer sector en blanco para usar el predeterminado
        if [ "$i" -eq 14 ]; then
            echo "" # Usar todo el espacio restante en la última partición
        else
            echo "+1G" # Establecer el tamaño a 1 GB para las demás particiones
        fi
    done
    echo "w"  # Guardar los cambios
} | sudo fdisk /dev/sdc

#Mostramos un mensaje indicando el inicio de formateo de las particiones
echo "Formateando las particiones lógicas..."

#Formatear cada partición lógica
for i in {5..14}
do
    sudo mkfs.ext4 /dev/sdc$i
done

#Mostramos un mensaje que indica que se comenzará a montar las particiones
echo "Montando las particiones..."

#Montar cada partición en su correspondiente directorio
for i in {5..14}
do
    sudo mount /dev/sdc$i /punto_A/Examenes-UTN/alumno_$(( (i-5)/3 + 2 ))/parcial_$(( (i-5)%3 + 1 ))
done

#Mostramos un mensaje final indicando que el proceso ha finalizado
echo "Proceso completado."
