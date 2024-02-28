// Importa el framework SwiftUI necesario para construir la interfaz de usuario.
import SwiftUI

// Define la estructura TaskCreateView que conforma el protocolo View.
struct TaskCreateView: View {
    // Utiliza EnvironmentObject para inyectar una instancia observable del almacén de tareas en la vista.
    @EnvironmentObject var taskStore: TaskStore
    
    // Define varias propiedades de estado para almacenar información de la nueva tarea.
    @State var title: String = ""
    @State var notes: String = ""
    @State var isDone = false
    @State var createdAt = Date()
    
    // Accede al presentationMode del entorno para controlar cómo se presenta esta vista.
    @Environment(\.presentationMode) var presentationMode
    
    // Una propiedad de estado para controlar la visibilidad de una alerta.
    @State var showAlert = false
    
    // Define el cuerpo de la vista TaskCreateView.
    var body: some View {
        // Construye una vista de navegación que permite la navegación entre vistas.
        NavigationView {
            // Utiliza un formulario para recoger la entrada del usuario.
            Form {
                // Crea una sección para el título y las notas de la tarea.
                Section {
                    TextField("Title", text: $title)
                    TextField("Notes", text: $notes)
                }
                // Crea otra sección para seleccionar la fecha de creación de la tarea.
                Section {
                    DatePicker(selection: $createdAt, displayedComponents: .date) {
                        Text("Date")
                    }
                }
            }
            // Presenta una alerta si showAlert es verdadero.
            .alert(isPresented: $showAlert){
                // Configura la alerta para mostrar un mensaje de error.
                Alert(title: Text("Error"),
                      message: Text("Duplicate task title"),
                      dismissButton: .default(Text("OK")){
                          // Cierra la alerta y la vista de creación de tarea.
                          self.showAlert.toggle()
                          self.presentationMode.wrappedValue.dismiss()
                      })
            }
            // Establece el color de fondo del formulario.
            .background(Color(.systemGroupedBackground))
            // Configura el título de la barra de navegación.
            .navigationBarTitle(Text("Create Task"), displayMode: .inline)
            // Añade botones de cancelar y guardar a la barra de navegación.
            .navigationBarItems(leading: Button("Cancel"){
                // Dismiss the view when cancel is tapped.
                self.presentationMode.wrappedValue.dismiss()
            }, trailing: Button(action: {
                // Intenta añadir la nueva tarea y muestra una alerta si el título ya existe.
                self.showAlert = !taskStore.addTask(title: title, notes: notes, createdAt: createdAt, isDone: isDone)
                self.presentationMode.wrappedValue.dismiss()
              }, label: {
                Text("Save")
                  .fontWeight(.bold)
              // Deshabilita el botón de guardar si el título está vacío.
              }).disabled(title.isEmpty))
        }
    }
}

// Proporciona una vista previa de TaskCreateView.
struct TaskCreateView_Previews: PreviewProvider {
    static var previews: some View {
        // Muestra una vista previa de TaskCreateView.
        TaskCreateView()
    }
}
