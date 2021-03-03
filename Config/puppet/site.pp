# Configuración específica para los nodos por defectos. En este caso no es ninguna
node default {}

node 'aplicacion-devops.localhost' {

    #incluyo el modulo sudo
    class { 'sudo': }

    #Genero entradas en sudo para el grupo admins y usuarios vagrant y jenkins
    sudo::conf { 'admins':
        ensure  => present,
        content => '%admin ALL=(ALL) ALL',
    }
    sudo::conf { 'vagrant':
        ensure  => present,
        content => 'vagrant ALL=(ALL) NOPASSWD: ALL',
    }
    sudo::conf { 'jenkins':
        content  => "jenkins ALL=(ALL) NOPASSWD: ALL",
    }

    # Instalación de Jenkins. Solo lo instalo si el nodo cliente contiene los
    # sistemas operativos Debian o Ubuntu.
    # La variable $::operatingsystem se obtiene de los "facts" que envían los agentes y representa el
    # el sistema operativo del nodo.
    case $::operatingsystem {
        'Debian', 'Ubuntu' : { 
            include jenkins 
            include jenkins::dependencies
        }
        default  : { notify {"$::operatingsystem no esta soportado":} }
    }

}
