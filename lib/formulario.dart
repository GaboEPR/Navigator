import 'package:flutter/material.dart';

class Formulario extends StatefulWidget {
  final Function() onReturnToHome;
  
  const Formulario({super.key, required this.onReturnToHome});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  String nombre = '';
  bool trabaja = false;
  bool estudia = false;
  String genero = '';
  bool notificaciones = false;
  double precio = 50;
  DateTime? fechaSeleccionada;

  void _mostrarConfirmacion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text('¿Deseas volver al inicio?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                widget.onReturnToHome(); // Llama a la función para regresar al home
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (fecha != null) {
      setState(() {
        fechaSeleccionada = fecha;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _mostrarConfirmacion(context);
        return false; // Evita que el botón back físico cierre directamente
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Formulario'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _mostrarConfirmacion(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () => _mostrarConfirmacion(context),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Encabezado
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: Colors.blue,
                child: const Text(
                  'Formulario de Captura de Datos',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              
              // Image.asset('../assets/iujo.jpg'),
              
              TextField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                onChanged: (valor) {
                  setState(() {
                    nombre = valor;
                  });
                },
              ),

              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Trabaja'),
                value: trabaja,
                onChanged: (val) => setState(() => trabaja = val!),
              ),
              CheckboxListTile(
                title: const Text('Estudia'),
                value: estudia,
                onChanged: (val) => setState(() => estudia = val!),
              ),

              ListTile(
                title: const Text('Masculino'),
                leading: Radio<String>(
                  value: 'Masculino',
                  groupValue: genero,
                  onChanged: (val) => setState(() => genero = val!),
                ),
              ),
              ListTile(
                title: const Text('Femenino'),
                leading: Radio<String>(
                  value: 'Femenino',
                  groupValue: genero,
                  onChanged: (val) => setState(() => genero = val!),
                ),
              ),

              SwitchListTile(
                title: const Text('Activar Notificaciones'),
                value: notificaciones,
                onChanged: (val) => setState(() => notificaciones = val),
              ),

              const Text('Seleccione Precio Estimado'),
              Slider(
                value: precio,
                min: 0,
                max: 100,
                divisions: 10,
                label: precio.round().toString(),
                onChanged: (val) => setState(() => precio = val),
              ),

              ListTile(
                title: const Text('Introduzca la Fecha'),
                subtitle: Text(fechaSeleccionada == null
                    ? 'No seleccionada'
                    : '${fechaSeleccionada!.day}/${fechaSeleccionada!.month}/${fechaSeleccionada!.year}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _seleccionarFecha(context),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Mostrar resumen de los datos
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Datos ingresados'),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Nombre: $nombre'),
                            Text('Trabaja: ${trabaja ? 'Sí' : 'No'}'),
                            Text('Estudia: ${estudia ? 'Sí' : 'No'}'),
                            Text('Género: $genero'),
                            Text('Notificaciones: ${notificaciones ? 'Activadas' : 'Desactivadas'}'),
                            Text('Precio estimado: \$${precio.toStringAsFixed(2)}'),
                            Text('Fecha: ${fechaSeleccionada?.toString() ?? 'No seleccionada'}'),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Enviar Datos'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}