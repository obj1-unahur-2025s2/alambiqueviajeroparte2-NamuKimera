object luke {
  var cantidadViajes = 0
  var recuerdo = null
  var vehiculo = alambiqueVeloz

  method cantidadViajes() = cantidadViajes 
  method viajar(lugar){
    if (lugar.puedeLlegar(vehiculo)) {
        cantidadViajes = cantidadViajes + 1
        recuerdo = lugar.recuerdoTipico()
        vehiculo.desgaste()
    }
  }
  method recuerdo() = recuerdo
  method vehiculo(nuevo) {vehiculo = nuevo}
}

object alambiqueVeloz {
  var velocidad = 10
  var combustible = 20
  const consumoPorViaje = 10
  var patente = "AB123JK"

  method velocidad() = velocidad
  method puedeFuncionar() = combustible >= consumoPorViaje
  method desgaste() {
      combustible = combustible - consumoPorViaje
  }
  method rapido() = true
  method patenteValida() = patente.take(1) == "A"
}

// --Vehiculos--

object antigualla {
  var velocidad = 30
  var gangsters = 7

  method velocidad() = velocidad
  method puedeFuncionar() = gangsters.even()
  method rapido() = gangsters > 6
  method desgaste(){
    gangsters = gangsters -1
  }
  method patenteValida() = chatarra.rapido()
}
object chatarra {
  var velocidad = 5
  var cañones = 10
  var municiones = "ACME"

  method velocidad() = velocidad
  method puedeFuncionar() = municiones == "ACME" and cañones.between(6,12)
  method rapido() = municiones.size() < cañones
  method desgaste(){
    cañones = (cañones / 2).roundUp(0)
    if (cañones < 5 )
      municiones = municiones + " Obsoleto"
  }
  method patenteValida() = municiones.take(4) == "ACME" 
  method cañones() = cañones
}

object convertible {
  var velocidad = 40
  var convertido = antigualla

  method velocidad() = velocidad
  method puedeFuncionar() = convertido.puedeFuncionar() 
  method rapido() = convertido.rapido()
  method desgaste(){
    convertido.desgaste()
  }
  method convertir(vehiculo){
    convertido = vehiculo
  }
  method patenteValida() = convertido.patenteValida()
}

object moto {
  method velocidad() = 50
  method rapido() = true
  method puedeFuncionar() = not self.rapido()
  method desgaste() { }
  method patenteValida() = false
}

// --Ciudades--

object paris {
  method recuerdoTipico() = "Llavero Torre Eiffel"
  method puedeLlegar(movil) =  movil.puedeFuncionar()  
}

object buenosAires {
  method recuerdoTipico() = "Mate"
  method puedeLlegar(auto) =  auto.rapido() 
}

object bagdad {
  var recuerdo = "bidon de petroleo"
  method recuerdoTipico() = recuerdo
  method recuerdo(nuevo) {recuerdo = nuevo}
  method puedeLlegar(cualquierCosa) = true
}

object lasVegas {
  var homenaje = paris
  method homenaje(lugar) {homenaje = lugar}
  method recuerdoTipico() = homenaje.recuerdoTipico()
  method puedeLlegar(vehiculo) = homenaje.puedeLlegar(vehiculo)
}

object hurlingham {
  method puedeLlegar(vehiculo) = vehiculo.puedeFuncionar() and vehiculo.rapido() and vehiculo.patenteValida()
  method recuerdoTipico() = "sticker de la Unahur"
}

// Parte 2

object centroInscripcion {
  var ciudad = hurlingham
  const inscriptos = #{}
  const rechazados = #{}

  method anotar(vehiculo) {
    if (vehiculo.puedeLlegar(ciudad)) {
      inscriptos.add(vehiculo)
    }
    else {
      rechazados.add(vehiculo)
    }
  }
  method cambiarCiudad(nuevaCiudad) {
    ciudad = nuevaCiudad
    rechazados.addAll(inscriptos)
    inscriptos.clear()
    inscriptos.addAll(rechazados.filter({a => a.puedeLlegar(nuevaCiudad)}))
    rechazados.removeAll(inscriptos)
  }
  method irALaCarrera() {
    return
      inscriptos.forEach({a => a.desgaste()})
  }
  method ganador() {
    return
      inscriptos.max({a => a.velocidad()})
  }
}

object antiguallaBlindada {
  const gangsters = ["Juan Triste", "Juan Inalambrico", "Juan Chernobyl", "Juan Callejero", "Juan", "Juan Programador", "Juan Artista"]

  method puedeFuncionar() = gangsters.even()
  method rapido() = gangsters > 6
  method desgaste() {
    gangsters.remove(gangsters.anyOne())
  }
  method velocidad() {
    return
    gangsters.sum({g => g.size()})
  }
}