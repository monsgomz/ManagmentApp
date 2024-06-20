//
//  Home.swift
//  ManagmentApp
//
//  Created by Montserrat Gomez on 2024-06-19.
//

import SwiftUI

struct Home: View {
	///Task manager Properties
	@State private var currentDate: Date = .init()
    var body: some View {
		VStack(alignment: .leading, spacing: 0, content: {
			HeaderView()
		})
			
		
    }
	
	//MARK: Te permite crear vistas personalizadas de vistas pequeñas
	@ViewBuilder
	func HeaderView() -> some View {
		VStack(alignment: .leading, spacing: 0){
			HStack{
				Text(currentDate.format("MMMM"))
					.foregroundStyle(.ultraViolet)
				
				Text(currentDate.format("YYYY"))
					.foregroundStyle(.gray)
			}
			.font(.title.bold())
			
		}
	}
}

#Preview {
    Home()
}
