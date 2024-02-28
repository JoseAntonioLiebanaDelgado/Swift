import SwiftUI

struct TaskCreateView: View {
    // MARK: - State -
    @State var title: String = ""
    @State var notes: String = ""
    @State var isDone = false
    @State var createdAt = Date()
    
    
    // MARK: - Environment -
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var taskStore:TaskStore
    @Environment(\.managedObjectContext) private var viewContext
    
    
    var body: some View {
        NavigationView {
            Form {
              Section {
                TextField("Title", text: $title)
                TextField("Notes", text: $notes)
              }
              Section {
                DatePicker(selection: $createdAt, displayedComponents: .date) {
                  Text("Date")
                }
              }
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitle(Text("Create Task"), displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel"){
                self.presentationMode.wrappedValue.dismiss()
            }, trailing: Button(action: {
                //TO DO SAVE NEW TASK
                taskStore.addNewTask(title: title, notes: notes, isDone: isDone, createdAt: createdAt, list: taskStore.selectedList!, context: viewContext)
                self.presentationMode.wrappedValue.dismiss()
              }, label: {
                Text("Save")
                  .fontWeight(.bold)
              }).disabled(title.isEmpty))
          }
    }

}

struct TaskCreateView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCreateView()
    }
}
