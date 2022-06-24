//
//  ContentView.swift
//  Navigation
//
//  Created by MAC21 on 22/06/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject var locationViewModel = LocationViewModel()
        
    var body: some View {
        Map(coordinateRegion: $locationViewModel.userLocation, showsUserLocation: true)
            .ignoresSafeArea()
        if locationViewModel.userHasLocation{
            Text("Localizacion Aceptada ✅")
                .bold()
                .padding(.top, 12)
            Link("Pulsa para cambiar la autorizacion de Localización",destination:  URL(string: UIApplication.openSettingsURLString)!)
                .padding(32)
        } else {
            Text("Localizacion Denegada 🚫")
                .bold()
                .padding(.top, 12)
            Link("Pulsa para cambiar la autorizacion de Localización",destination:  URL(string: UIApplication.openSettingsURLString)!)
                .padding(32)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
