import SwiftUI

struct TaskDetailView: View {
    
    @State var isDone = false
    @EnvironmentObject private var taskStore: TaskStore
    @Environment(\.managedObjectContext) private var viewContext
    
    let task:Task
    
    var body: some View {
        Form {
            Section(header: Text("Notes")){
                Text("\(task.notes ?? "no notes")")
            }
            Section(header: Text("Created at")){
                Text(Utils.dateformatter(date: task.creationAt!))
            }
            Toggle("Is Done?", isOn: $isDone)
                .onChange(of: isDone, perform: {value in
                    taskStore.updateIsDoneinTask(task, with: value, context: viewContext)
                })
            
        }.navigationTitle("\(task.title!)")
        .onAppear(){
            self.isDone = task.isDone
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let context = PersistenceController.preview.container.viewContext
    let newTask = Task(context: context)
    newTask.title = "some title"
    newTask.creationAt = Date()
    return TaskDetailView(task: newTask)
  }
}
