//
//  ContentView.swift
//  PhotoMania
//
//  Created by Mucha Naibei on 03/10/2022.
//

import SwiftUI

class ViewModel: ObservableObject{
    
    @Published var image: Image?
    
    func fetchNewImage(){
        guard let url = URL(string:"https://random.imagecdn.app/500/500")
        else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, __, _ in
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else{
                    return
                }
                self.image = Image(uiImage: uiImage)
            }
        }
        task.resume()
    }
}

struct ContentView: View {
   @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center) {
                Spacer()
                
                if let image = viewModel.image{
                    ZStack {
                        image
                           .resizable()
                           .foregroundColor(Color.indigo)
                           .frame(width: 400, height: 500)
                           .padding()
                    }
                    .frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.width / 1.5)
                } else {
                    Image(systemName: "photo")
                       .resizable()
                       .foregroundColor(Color.indigo)
                       .frame(width: 300, height: 300)
                       .padding()
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.fetchNewImage()
                    
                }, label: {
                    Text("Next Image")
                        .bold()
                        .frame(width: 200, height: 40)
                        .padding()
                        .background(Color.blue.opacity(0.6))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            )}
            .padding()
            .navigationTitle("Photo Mania")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
