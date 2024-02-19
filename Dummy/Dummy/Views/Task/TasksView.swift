import SwiftUI
import CoreData
import Foundation

struct TasksView: View {
    
    @State var isShowingCreateModal = false
    @EnvironmentObject private var taskStore:TaskStore
    
    let list:TaskList
    
    @FetchRequest(sortDescriptors: []) private var items: FetchedResults<Task>
    
    init(list:TaskList){
        self.list = list
        _items = FetchRequest<Task>( sortDescriptors: [], predicate: NSPredicate(format: "list.name == %@", list.name!))
    }
    
    var body: some View {
        VStack{
            List{
                Section {
                    ForEach(items, id: \.self) {item in
                        NavigationLink(destination: TaskDetailView(task:item)){
                        HStack {
                            TaskStatusView(isDone: item.isDone)
                            Text("\(item.title ?? "no title")")
                            Spacer()
                        }
                        }
                    }.onDelete(perform: deleteItems)
                }
            }
            HStack {
                NewTaskButton(isShowingCreateModal: $isShowingCreateModal)
                Spacer()
            }
            .padding(.leading)
        }
        .navigationBarTitle(Text("Tasks from list \(list.name ?? " ")"))
        .onAppear(){
            taskStore.updateSelectList(list)
        }
        
    }
    
    
    private func deleteItems(offsets: IndexSet) {
        //TODO REMOVE
        /*withAnimation {
         offsets.map { list.tasks[$0] }.forEach(viewContext.delete)
         do {
         try viewContext.save()
         } catch {
         let nsError = error as NSError
         fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
         }
         }*/
    }
}

struct NewTaskButton: View {
    @Binding var isShowingCreateModal: Bool
    
    var body: some View {
        Button(
            action: { self.isShowingCreateModal.toggle()},
            label: {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.red)
                Text("New Task")
                    .font(.headline)
                    .foregroundColor(.red)
            })
            .sheet(isPresented: $isShowingCreateModal,
                   onDismiss:{self.isShowingCreateModal=false}){
                TaskCreateView()
            }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let taskList = TaskList(context: viewContext)
        taskList.name = "some name"
            
        return TasksView(list: taskList)
    }
}
