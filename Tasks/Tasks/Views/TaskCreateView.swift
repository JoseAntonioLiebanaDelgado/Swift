import SwiftUI

struct TaskCreateView: View {
    @EnvironmentObject var taskStore:TaskStore
    
    // MARK: - State -
    @State var title: String = ""
    @State var notes: String = ""
    @State var isDone = false
    @State var createdAt = Date()
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var showAlert = false
    
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
            .alert(isPresented: $showAlert){
                Alert(title: Text("Error"),
                      message: Text("Duplicate task title"),
                      dismissButton: .default(Text("OK")){
                        self.showAlert.toggle()
                        self.presentationMode.wrappedValue.dismiss()
                      })
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitle(Text("Create Task"), displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel"){
                self.presentationMode.wrappedValue.dismiss()
            }, trailing: Button(action: {
                
                self.showAlert = !taskStore.addTask(title: title, notes: notes, createdAt: createdAt, isDone: isDone)
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
