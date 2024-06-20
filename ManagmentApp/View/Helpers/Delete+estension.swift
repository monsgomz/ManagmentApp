//
//  Delete+estension.swift
//  ManagmentApp
//
//  Created by Montserrat Gomez on 2024-06-19.
//

import SwiftUI

extension Date {
	///Custom Date Format
	
	func format(_ format: String) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		
		return formatter.string(from: self)
	}
}
