// Importa el framework SwiftUI necesario para construir la interfaz de usuario.
import SwiftUI

// Define la estructura ContentView que conforma el protocolo View.
struct ContentView: View {
    // Utiliza EnvironmentObject para inyectar una instancia observable del almacen de tareas en la vista.
    @EnvironmentObject var taskStore: TaskStore
    
    // Mantiene una variable de estado para controlar la visibilidad de la vista de creación de nuevas tareas.
    @State var isShowingCreateModal = false
    
    // Define el cuerpo de la vista ContentView.
    var body: some View {
        // Construye una vista de navegación que permite la navegación entre vistas.
        NavigationView {
            // Organiza el contenido en un VStack (Vertical Stack).
            VStack{
                // Crea una lista para mostrar los elementos.
                List{
                    // Agrupa los elementos en una sección.
                    Section {
                        // Itera sobre las tareas en el taskStore usando ForEach.
                        ForEach(taskStore.taskList, id: \.self) { task in
                            // Crea un enlace de navegación para cada tarea.
                            NavigationLink(destination: TaskDetailView(task: task)) {
                                // Organiza el contenido de cada fila en un HStack (Horizontal Stack).
                                HStack {
                                    // Muestra el estado de la tarea (completada o no).
                                    TaskStatusView(isDone: task.isDone)
                                    // Muestra el título de la tarea.
                                    Text("\(task.title ?? "")")
                                    // Empuja el contenido hacia la izquierda.
                                    Spacer()
                                }
                            }
                        }
                        // Proporciona una función para borrar tareas.
                        .onDelete(perform: taskStore.deleteTask(at:))
                    }
                }
                // Establece el color de fondo de la lista en blanco.
                .background(Color.white)
                
                // Crea un HStack para el botón de nueva tarea.
                HStack {
                    // Muestra el botón de nueva tarea.
                    NewTaskButton(isShowingCreateModal: $isShowingCreateModal)
                    // Empuja el botón hacia la izquierda.
                    Spacer()
                }
                // Añade un padding al HStack.
                .padding(.leading)
            }
            // Establece el título de la barra de navegación.
            .navigationBarTitle(Text("Tasks"))
        }
    }
}

// Define la vista NewTaskButton que permite al usuario abrir la vista para crear una nueva tarea.
struct NewTaskButton: View {
    // Crea un binding para la propiedad que controla la visibilidad del modal de creación de tareas.
    @Binding var isShowingCreateModal: Bool

    // Define el cuerpo de la vista NewTaskButton.
    var body: some View {
        // Crea un botón que, cuando se toca, muestra el modal para crear una nueva tarea.
        Button(
            action: { self.isShowingCreateModal.toggle() },
            label: {
                // Configura la etiqueta del botón con un ícono y texto.
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.red)
                Text("New Task")
                    .font(.headline)
                    .foregroundColor(.red)
            })
            // Presenta la vista TaskCreateView como una hoja modal cuando isShowingCreateModal es verdadero.
            .sheet(isPresented: $isShowingCreateModal,
                   onDismiss: { self.isShowingCreateModal = false }) {
                    TaskCreateView()
            }
    }
}
