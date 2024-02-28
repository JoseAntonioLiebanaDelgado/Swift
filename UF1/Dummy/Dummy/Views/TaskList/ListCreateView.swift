import SwiftUI

struct ListCreateView: View {

    @EnvironmentObject private var taskStore:TaskStore
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    @State var text: String = ""

  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        HStack {
          Spacer()
          CircularImageView(color: .red)
          Spacer()
        }
        .padding([.top, .bottom])
        HStack {
          Text("Enter a list title")
          Spacer()
        }
        .padding([.leading, .trailing])
        TextField("Title", text: $text)
          .padding()
          .background(
            Color(red: 231 / 255, green: 234 / 255.0, blue: 237 / 255.0)
        )
          .cornerRadius(10)
          .padding()
        Spacer()
      }
      .navigationBarTitle(Text("Create Task List"), displayMode: .inline)
      .navigationBarItems(
        leading: Button("Close") {
            presentationMode.wrappedValue.dismiss()
        },
        trailing: Button("Save") {
            //TO DO SAVE NEW LIST
            taskStore.addNewTaskList(name: text, context: viewContext)
            presentationMode.wrappedValue.dismiss()
          
        }.disabled(self.text.isEmpty))
    }
  }
    


}

struct ListCreateView_Previews: PreviewProvider {
    static var previews: some View {
        ListCreateView()
    }
}
