//
//  Date+estension.swift
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
	
	//TODO: Revisar este codigo, estudiarlo
 	///Fetching week based on given date
	func fetchWeek(_ date : Date = .init()) -> [weekDay] {
		let calendar = Calendar.current
		let startOfDate = calendar.startOfDay(for: date)
		
		var week: [weekDay] = []
		let weekOfDate = calendar.dateInterval(of: .weekOfMonth, for: startOfDate)
		guard let startOfWeek = weekOfDate?.start else {
			return []
		}
		
		///Iterating to get the full week
		(0..<7).forEach { index in
			if let weekDay = calendar.date(byAdding: .day, value: index, to: startOfWeek){
				week.append(.init(date: weekDay))
			}
			
		}
		
		return week
		
	}
	
	struct weekDay: Identifiable {
		var id: UUID = .init()
		var date: Date
	}
}
