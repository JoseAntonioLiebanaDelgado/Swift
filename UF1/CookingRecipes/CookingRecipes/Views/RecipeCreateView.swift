//
//  RecipeCreateView.swift
//  CookingRecipes
//
//  Created by Jose Antonio Liebana Delgado on 11/3/24.
//

import SwiftUI

struct RecipeCreateView: View {
    @EnvironmentObject var recipeStore:RecipeStore
    
    @State var nombre: String = ""
    @State var descripcion: String = ""
    @State var instrucciones: String = ""
    @State var cantidad: Float = 0
    @State var esFavorito = false
    @State var imagen: String = ""
    @State var createdAt = Date()

    
    @Environment(\.presentationMode) var presentationMode
    
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Nombre", text: $nombre)
                    TextField("Descripcion", text: $descripcion)
                    TextField("Instrucciones", text: $instrucciones)
                    //TextField("Cantidad", text: $cantidad)
                    //TextField("Es Favorito", text: $esFavorito)
                    TextField("Imagen", text: $imagen)
                    
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
                 
                     /*self.showAlert = !$recipeStore.addRecipe(nombre: nombre, descripcion: descripcion, instrucciones: instrucciones, createdAt: createdAt)*/
                 self.presentationMode.wrappedValue.dismiss()
                 }, label: {
                 Text("Save")
                 .fontWeight(.bold)
                 }).disabled(nombre.isEmpty))
                 }
                 }
            }
        
#Preview {
    RecipeCreateView()
}
