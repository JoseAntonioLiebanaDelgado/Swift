import SwiftUI

struct TaskStatusView: View {
    // Indica si la tarea está completada o no.
    let isDone: Bool
    
    var body: some View {
        // Representa el estado de la tarea como un círculo con un borde verde si está completada, rojo si no lo está.
        Circle()
            .padding(4)
            .overlay(
                Circle()
                    .stroke(isDone ? Color.green : Color.red, lineWidth: 2)
            )
            .foregroundColor(isDone ? .green : .clear)
            .frame(width: 20, height: 20)
    }
}

// Proporciona una vista previa de TaskStatusView.
struct TaskStatusView_Previews: PreviewProvider {
    static var previews: some View {
        // Muestra una vista previa de TaskStatusView con una tarea completada.
        TaskStatusView(isDone: true)
    }
}
