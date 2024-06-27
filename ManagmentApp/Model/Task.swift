//
//  Task.swift
//  ManagmentApp
//
//  Created by Montserrat Gomez on 2024-06-19.
//

import SwiftUI
import SwiftData

@Model ///Para convertir el modelo a uno de SwiftData
class Task: Identifiable {
	var id: UUID
	var tasktitle : String
	var creationDate: Date
	var isCompleted: Bool
	var tint: String
	//	var tint: Color //El tipo Color es incompatible con SwiftData
	
	init(id: UUID = UUID(), tasktitle: String, creationDate: Date = Date(), isCompleted: Bool = false, tint: String) {
		self.id = id
		self.tasktitle = tasktitle
		self.creationDate = creationDate
		self.isCompleted = isCompleted
		self.tint = tint
	}
	
	var tintColor: Color {
		switch tint {
		case "Task1": return .task1
		case "Task2": return .task2
		case "Task3": return .task3
		case "Task4": return .task4
		case "Task5": return .task5
			
		default:
			return Color.gray
		}
	}
}

//MARK: extension para actualizar la fecha
extension Date {
	static func updateHour(_ value: Int) -> Date {
		let calendar = Calendar.current
		return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
	}
}


///Ejemplo de tasks
//var sampleTasks: [Task] = [
//	.init(tasktitle: "Estudiar swift", creationDate: .updateHour(-5), isCompleted: true, tint: .task1),
//	.init(tasktitle: "Salir con amigos", creationDate: .now, isCompleted: false, tint: .task2),
//	.init(tasktitle: "Hacer de comer", creationDate: .updateHour(1), isCompleted: false, tint: .task3),
//	.init(tasktitle: "Sacar al perro", creationDate: .updateHour(-4), isCompleted: true, tint: .task4),
//	.init(tasktitle: "Leer", creationDate: .updateHour(-1), isCompleted: true, tint: .task2),
//	.init(tasktitle: "Limpiar", creationDate: .updateHour(-3), isCompleted: false, tint: .task4),
//	.init(tasktitle: "Junta", creationDate: .updateHour(2), isCompleted: false, tint: .task5)
//]
