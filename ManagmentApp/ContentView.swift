//
//  ContentView.swift
//  ManagmentApp
//
//  Created by Montserrat Gomez on 2024-06-19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Home()
				.background(.BG)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.preferredColorScheme(.light)
				
        }

    }
}

#Preview {
    ContentView()
}
