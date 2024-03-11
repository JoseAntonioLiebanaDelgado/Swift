import SwiftUI
import CoreData

struct TaskDetailView: View {
    @EnvironmentObject var taskStore:TaskStore
    let task: Task
    
    @State var isDone=false
    
    var body: some View {
        Form {
            Section(header: Text("Notes")){
                Text(task.notes ?? "No Notes")
            }
            if let creationDate = task.creationDate{
                Section(header: Text("Created at")){
                    Text(Utils.dateformatter(date: creationDate))
                }
            }
            Toggle("Is Done?", isOn: $isDone)
                .onChange(of: isDone, perform: { value in
                    taskStore.changeIsDoneTask(task)
                })
            
        }.navigationTitle(task.title ?? "Sample title")
        .onAppear(){
            self.isDone = task.isDone
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let newTask = Task(context: TaskStore.context)
        newTask.title = "Some title"
        newTask.notes = "Here are the notes"
        newTask.creationDate = Date()
        return TaskDetailView(task: newTask)
    }
}
