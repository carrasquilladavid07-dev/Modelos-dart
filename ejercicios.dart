class Criterio {
  int id;
  String descripcion;
  String estado; 
  String observacion;

  Criterio(this.id, this.descripcion, this.estado, this.observacion);

  void cambiarEstado(String nuevoEstado) => estado = nuevoEstado;
  void registrarObservacion(String nuevaObservacion) => observacion = nuevaObservacion;

  void mostrarInfo() {
    print('Criterio #$id: $descripcion');
    print('  Estado: $estado');
    print('  Observación: ${observacion.isEmpty ? "Sin observación" : observacion}');
  }

  bool cumple() => estado == 'Cumple';
}


class ModeloAnalisis {
  int id;
  String nombre;
  String descripcion;
  List<Criterio> criterios;

  ModeloAnalisis(this.id, this.nombre, this.descripcion) : criterios = [];

  // Ejercicio 4
  void agregarCriterio(Criterio criterio) {
    criterios.add(criterio);
  }

  List<Criterio> consultarCriterios() {
    return criterios;
  }

  void mostrarCriterios() {
    print('Criterios del ${nombre}:');
    for (var criterio in criterios) {
      criterio.mostrarInfo();
    }
  }

  Criterio? buscarCriterio(int idBuscado) {
    for (var criterio in criterios) {
      if (criterio.id == idBuscado) {
        return criterio;
      }
    }
    return null;
  }

  int contarCriterios() {
    return criterios.length;
  }

  // Ejercicio 5
  int contarCumplen() {
    int contador = 0;
    for (var criterio in criterios) {
      if (criterio.estado == 'Cumple') {
        contador++;
      }
    }
    return contador;
  }

  int contarNoCumplen() {
    int contador = 0;
    for (var criterio in criterios) {
      if (criterio.estado == 'No cumple') {
        contador++;
      }
    }
    return contador;
  }

  int contarEnRevision() {
    int contador = 0;
    for (var criterio in criterios) {
      if (criterio.estado == 'En revisión') {
        contador++;
      }
    }
    return contador;
  }

  // Ejercicio 6
  double calcularPorcentajeCumplimiento() {
    if (criterios.isEmpty) {
      return 0;
    }
    return (contarCumplen() / criterios.length) * 100;
  }

  // Ejercicio 7
  String determinarEstado() {
    if (contarNoCumplen() > 0) {
      return 'Requiere ajustes';
    } else if (contarEnRevision() > 0) {
      return 'En revisión';
    } else {
      return 'Aprobado';
    }
  }
}

// Ejercicio 8
class Verificacion {
  ModeloAnalisis modelo;
  DateTime fecha;
  String responsable;
  double porcentaje;
  String estadoFinal;
  String observaciones;

  Verificacion(this.modelo, this.fecha, this.responsable, this.observaciones)
      : porcentaje = modelo.calcularPorcentajeCumplimiento(),
        estadoFinal = modelo.determinarEstado();

  // Ejercicio 9
  void generarResumen() {
    print('RESULTADO DE LA VERIFICACIÓN');
    print('');
    print('Modelo: ${modelo.nombre}');
    print('Fecha de verificación: ${fecha.day}/${fecha.month}/${fecha.year}');
    print('Responsable: $responsable');
    print('');
    print('Total de criterios: ${modelo.contarCriterios()}');
    print('Cumplen: ${modelo.contarCumplen()}');
    print('No cumplen: ${modelo.contarNoCumplen()}');
    print('En revisión: ${modelo.contarEnRevision()}');
    print('');
    print('Cumplimiento: ${porcentaje.toStringAsFixed(0)} %');
    print('');
    print('Estado: ${estadoFinal.toUpperCase()}');
    if (observaciones.isNotEmpty) {
      print('Observaciones: $observaciones');
    }
  }
}

// Ejercicio 10
final List<List<String>> datosCasosUso = [
  ['Todos los actores están identificados', 'Cumple', ''],
  ['Cada caso de uso tiene un nombre que describe una acción', 'Cumple', ''],
  ['Las relaciones entre actores y casos de uso son correctas', 'Cumple', ''],
  ['Los casos de uso cubren los requisitos funcionales', 'Cumple', ''],
  ['Los límites del sistema están definidos', 'Cumple', ''],
  ['Las relaciones include y extend están bien utilizadas', 'Cumple', ''],
  ['No existen casos de uso duplicados', 'Cumple', ''],
  ['Cada caso de uso tiene al menos un actor', 'Cumple', ''],
  ['Los casos de uso tienen especificación documentada', 'No cumple', 'Faltan las especificaciones de dos casos de uso'],
  ['La nomenclatura es consistente en todo el diagrama', 'En revisión', 'Pendiente de revisar con el instructor'],
];

final List<List<String>> datosActividades = [
  ['Existe un nodo inicial y al menos un nodo final', 'Cumple', ''],
  ['Todas las actividades tienen un nombre claro', 'Cumple', ''],
  ['Los flujos de control conectan correctamente las actividades', 'Cumple', ''],
  ['Las decisiones tienen condiciones definidas', 'Cumple', ''],
  ['El diagrama representa el proceso descrito en los requisitos', 'Cumple', ''],
];

final List<List<String>> datosSecuencia = [
  ['Los participantes están identificados', 'Cumple', ''],
  ['Los mensajes tienen un nombre claro', 'Cumple', ''],
  ['El orden de los mensajes es coherente', 'Cumple', ''],
  ['Las respuestas están representadas', 'Cumple', ''],
  ['La secuencia es consistente con el modelo de clases', 'En revisión', 'Falta contrastar con el modelo de clases'],
];

final List<List<String>> datosClases = [
  ['Todas las clases tienen nombre', 'Cumple', ''],
  ['Los atributos tienen tipo de dato', 'Cumple', ''],
  ['Las relaciones tienen multiplicidad', 'Cumple', ''],
  ['Los métodos están definidos en las clases', 'No cumple', 'Hay clases sin métodos'],
  ['No existen clases duplicadas', 'No cumple', 'Se repite la clase Producto'],
];

void titulo(String texto) {
  print('');
  print('==============================================');
  print(texto);
  print('==============================================');
}


void ejecutarFlujoCompleto(
  int id,
  String nombre,
  String descripcion,
  List<List<String>> datos,
) {
  var modelo = ModeloAnalisis(id, nombre, descripcion);

  for (var i = 0; i < datos.length; i++) {
    modelo.agregarCriterio(Criterio(i + 1, datos[i][0], 'En revisión', ''));
  }

  for (var i = 0; i < datos.length; i++) {
    var criterio = modelo.buscarCriterio(i + 1);
    if (criterio != null) {
      criterio.cambiarEstado(datos[i][1]);
      if (datos[i][2].isNotEmpty) {
        criterio.registrarObservacion(datos[i][2]);
      }
    }
  }

  
  var verificacion = Verificacion(modelo, DateTime.now(), 'Aprendiz SENA', '');
  verificacion.generarResumen();
}

void main() {
  // -------------------------------------------------------------
  titulo('EJERCICIO 1. Crear la clase Criterio');
  var c1 = Criterio(1, 'Todos los actores están identificados', 'Cumple', '');
  var c2 = Criterio(2, 'Los límites del sistema están definidos', 'En revisión', '');
  var c3 = Criterio(3, 'Los casos de uso tienen especificación documentada', 'No cumple', '');
  c1.mostrarInfo();
  c2.mostrarInfo();
  c3.mostrarInfo();

  // -------------------------------------------------------------
  titulo('EJERCICIO 2. Implementar comportamientos en Criterio');
  c2.cambiarEstado('Cumple');
  c3.registrarObservacion('Faltan las especificaciones de dos casos de uso');
  c2.mostrarInfo();
  c3.mostrarInfo();
  print('¿El criterio 1 cumple? ${c1.cumple()}');
  print('¿El criterio 3 cumple? ${c3.cumple()}');

  // -------------------------------------------------------------
  titulo('EJERCICIO 3. Crear la clase ModeloAnalisis');
  ModeloAnalisis m1 = ModeloAnalisis(
      1, 'Modelo de casos de uso', 'Verifica actores, casos de uso y relaciones');
  ModeloAnalisis m2 = ModeloAnalisis(
      2, 'Modelo de actividades', 'Verifica flujos de trabajo y decisiones');
  ModeloAnalisis m3 = ModeloAnalisis(
      3, 'Modelo de secuencia', 'Verifica interacción entre objetos en el tiempo');
  ModeloAnalisis m4 = ModeloAnalisis(
      4, 'Modelo de clases', 'Verifica atributos, métodos y relaciones entre clases');

  for (var m in [m1, m2, m3, m4]) {
    print('Modelo #${m.id}: ${m.nombre} - ${m.descripcion}');
  }
  print('Cada modelo inicia con ${m1.criterios.length} criterios.');

  // -------------------------------------------------------------
  titulo('EJERCICIO 4. Agregar criterios a un modelo');
  for (var i = 0; i < datosCasosUso.length; i++) {
    m1.agregarCriterio(
      Criterio(i + 1, datosCasosUso[i][0], datosCasosUso[i][1], datosCasosUso[i][2]),
    );
  }
  print('Criterios consultados: ${m1.consultarCriterios().length}');
  m1.mostrarCriterios();
  var encontrado = m1.buscarCriterio(9);
  if (encontrado != null) {
    print('Criterio encontrado:');
    encontrado.mostrarInfo();
  }
  if (m1.buscarCriterio(99) == null) {
    print('El criterio 99 no existe en el modelo');
  }
  print('Cantidad de criterios: ${m1.contarCriterios()}');

  // -------------------------------------------------------------
  titulo('EJERCICIO 5. Verificar los criterios');
  print('Cumplen: ${m1.contarCumplen()}');
  print('No cumplen: ${m1.contarNoCumplen()}');
  print('Requieren revisión: ${m1.contarEnRevision()}');

  // -------------------------------------------------------------
  titulo('EJERCICIO 6. Calcular el porcentaje de cumplimiento');
  print('Porcentaje de cumplimiento: '
      '${m1.calcularPorcentajeCumplimiento().toStringAsFixed(0)} %');

  // -------------------------------------------------------------
  titulo('EJERCICIO 7. Determinar el estado del modelo');
  print('Estado del modelo: ${m1.determinarEstado()}');

  // -------------------------------------------------------------
  titulo('EJERCICIO 8. Crear la clase Verificacion');
  var verificacion = Verificacion(
      m1, DateTime.now(), 'Aprendiz SENA', 'Verificación inicial del modelo');
  print('Modelo evaluado: ${verificacion.modelo.nombre}');
  print('Responsable: ${verificacion.responsable}');
  print('Porcentaje: ${verificacion.porcentaje.toStringAsFixed(0)} %');
  print('Estado final: ${verificacion.estadoFinal}');
  print('Observaciones: ${verificacion.observaciones}');

  // -------------------------------------------------------------
  titulo('EJERCICIO 9. Generar el resumen de la verificación');
  verificacion.generarResumen();

  // -------------------------------------------------------------
  titulo('EJERCICIO 10. Integración de la solución');
  ejecutarFlujoCompleto(1, 'Modelo de casos de uso', 'Verifica actores, casos de uso y relaciones', datosCasosUso);
  print('');
  ejecutarFlujoCompleto(2, 'Modelo de actividades', 'Verifica flujos de trabajo y decisiones', datosActividades);
  print('');
  ejecutarFlujoCompleto(3, 'Modelo de secuencia', 'Verifica interacción entre objetos en el tiempo', datosSecuencia);
  print('');
  ejecutarFlujoCompleto(4, 'Modelo de clases', 'Verifica atributos, métodos y relaciones entre clases', datosClases);
}
