//
//  Task.swift
//  ManagmentApp
//
//  Created by Montserrat Gomez on 2024-06-19.
//

import Foundation
import SwiftUI

struct Task: Identifiable {
	var id: UUID = UUID()
	var tasktitle : String = ""
	var creationDate: Date = .init()
	var isCompleted: Bool = false
	var tint: Color
}

var sampleTasks: [Task] = [
	.init(tasktitle: "Estudiar swift", creationDate: .updateHour(-5), isCompleted: true, tint: .task1),
	.init(tasktitle: "Salir con amigos", creationDate: .now, isCompleted: false, tint: .task2),
	.init(tasktitle: "Hacer de comer", creationDate: .updateHour(1), isCompleted: false, tint: .task3),
	.init(tasktitle: "Sacar al perro", creationDate: .updateHour(-4), isCompleted: true, tint: .task4),
	.init(tasktitle: "Leer", creationDate: .updateHour(-1), isCompleted: true, tint: .task2),
	.init(tasktitle: "Limpiar", creationDate: .updateHour(-3), isCompleted: false, tint: .task4),
	.init(tasktitle: "Junta", creationDate: .updateHour(2), isCompleted: false, tint: .task5)
]

//MARK: extension para actualizar la fecha
extension Date {
	static func updateHour(_ value: Int) -> Date {
		let calendar = Calendar.current
		return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
	}
}
