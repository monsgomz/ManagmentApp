//
//  View+extension.swift
//  ManagmentApp
//
//  Created by Montserrat Gomez on 2024-06-19.
//

import SwiftUI

extension View {
	///Custom spacers
	@ViewBuilder
	func hSpacing(_ alignment: Alignment) -> some View{
		self.frame(maxWidth: .infinity, alignment: alignment)
	}
	
	@ViewBuilder
	func vSpacing(_ alignment: Alignment) -> some View{
		self.frame(maxHeight: .infinity, alignment: alignment)
	}
	
	
	
}
