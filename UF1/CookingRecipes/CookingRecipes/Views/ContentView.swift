//
//  ContentView.swift
//  CookingRecipes
//
//  Created by Jose Antonio Liebana Delgado on 6/3/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var recipeStore:RecipeStore
    
    @State var isShowingCreateModal = false
    var body: some View {
        NavigationView {
            VStack{
                List{
                    /*Section {
                     ForEach(recipeStore.taskList, id: \.self) { task in
                     //Text("\(task.title ?? "no title")")
                     
                     NavigationLink(destination: TaskDetailView(task: task)) {
                     HStack {
                     RecipeStatusView(isDone: task.isDone)
                     Text("\(task.title ?? "")")
                     Spacer()
                     }
                     }
                     
                     }.onDelete(perform: recipeStore.deleteTask(at:))
                     }
                     }
                     .background(Color.white)*/
                    HStack {
                        NewTaskButton(isShowingCreateModal: $isShowingCreateModal)
                        Spacer()
                    }
                    .padding(.leading)
                }
                .navigationBarTitle(Text("Recipes"))
            }
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
                    Text("New Recipe")
                        .font(.headline)
                        .foregroundColor(.red)
                })
            .sheet(isPresented: $isShowingCreateModal,
                   onDismiss:{self.isShowingCreateModal=false}){
                RecipeCreateView()
            }
        }
    }
}
