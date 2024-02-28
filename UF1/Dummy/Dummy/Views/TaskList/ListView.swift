
import SwiftUI

struct ListView: View {
    
    @State var isShowingCreateModal = false
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \TaskList.name, ascending: true)]) private var items: FetchedResults<TaskList>

    
    var body: some View {
        List{
            ForEach(items, id: \.self){item in
                NavigationLink(destination: TasksView(list:item)){
                    Text("\(item.name ?? "No name list")")
                }
            }.onDelete(perform: deleteItems)
        }.navigationBarTitle(Text("List"))
        .navigationBarItems(trailing: Button("+"){
            self.isShowingCreateModal.toggle()
        })
        .sheet(isPresented: $isShowingCreateModal){
            ListCreateView()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        //TODO REMOVE
        /*
         offsets.map { items[$0] }.forEach(viewContext.delete)
         do {
         try viewContext.save()
         } catch {
         print("Error delete items \(error)")
         }
         */

    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
