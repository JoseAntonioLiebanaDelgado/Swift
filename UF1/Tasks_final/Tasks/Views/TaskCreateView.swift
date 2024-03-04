import SwiftUI

struct TaskCreateView: View {
    @EnvironmentObject var taskStore:TaskStore
    
    // MARK: - State -
    @State var title: String = ""
    @State var notes: String = ""
    @State var isDone = false
    @State var createdAt = Date()
    
    @Environment(\.presentationMode) var presentationMode
    
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
                // MARK: TO DO SAVE TASK
                
                taskStore.addTask(title: title, notes: notes, createdAt: createdAt, isDone: isDone)
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
