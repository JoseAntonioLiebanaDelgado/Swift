import SwiftUI
import CoreData

struct TaskDetailView: View {
    // Inyecta una instancia observable del almacén de tareas en la vista.
    @EnvironmentObject var taskStore: TaskStore
    // Define la tarea a mostrar en detalle.
    let task: Task
    
    // Estado para controlar si la tarea está completada o no.
    @State var isDone = false
    
    var body: some View {
        // Utiliza un formulario para organizar la información de la tarea.
        Form {
            // Sección para mostrar las notas de la tarea.
            Section(header: Text("Notes")){
                Text(task.notes ?? "No Notes")
            }
            // Sección para mostrar la fecha de creación de la tarea si está disponible.
            if let creationDate = task.creationDate {
                Section(header: Text("Created at")){
                    Text(Utils.dateformatter(date: creationDate))
                }
            }
            // Toggle para permitir al usuario cambiar el estado de la tarea.
            Toggle("Is Done?", isOn: $isDone)
                // Realiza una acción cuando el estado del Toggle cambia.
                .onChange(of: isDone, perform: { value in
                    // Cambia el estado de la tarea en el almacén de tareas.
                    taskStore.changeIsDoneTask(task)
                })
            
        }
        // Configura el título de la barra de navegación con el título de la tarea o un título de muestra.
        .navigationTitle(task.title ?? "Sample title")
        // Realiza una acción cuando la vista aparece en pantalla.
        .onAppear(){
            // Establece el estado de isDone al estado actual de la tarea.
            self.isDone = task.isDone
        }
    }
}

// Proporciona una vista previa de TaskDetailView.
struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Crea una nueva tarea para mostrar en la vista previa.
        let newTask = Task(context: TaskStore.context)
        newTask.title = "Some title"
        newTask.notes = "Here are the notes"
        newTask.creationDate = Date()
        // Retorna la vista previa de TaskDetailView con la nueva tarea creada.
        return TaskDetailView(task: newTask)
    }
}
