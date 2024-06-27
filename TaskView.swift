//
//  TaskView.swift
//  ManagmentApp
//
//  Created by Montserrat Gomez on 2024-06-25.
//

import SwiftUI
import SwiftData

struct TaskView: View {
	@Binding var currentDate: Date
	///SwiftData Dynamic Query
	@Query private var tasks: [Task]
	
	init(currentDate: Binding<Date>) {
		self._currentDate = currentDate //MARK: Revisar que es _
		///Prdicado
		let calendar = Calendar.current
		let startOfDate = calendar.startOfDay(for: currentDate.wrappedValue)
		let endOfDate = calendar.date(byAdding: .day, value: 1, to: startOfDate)!
		let predicate = #Predicate<Task> { ///Un predicado es una condicion logica que regresa true or false
			/*Calendar.current.isDate($0.creationDate, inSameDayAs: currentDate.wrappedValue)*/ //No se pueden llamar a funciones dentro del predicado
			return $0.creationDate >= startOfDate && $0.creationDate < endOfDate
		}
		
		let sortDescriptor = [SortDescriptor(\Task.creationDate, order: .reverse)]
		
		self._tasks = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
	}
	
    var body: some View {
		VStack(alignment: .leading, spacing:  30){
			ForEach(tasks) { task in
				TaskRowView(task: task)
					.background(alignment: .leading) {
						if tasks.last?.id != task.id {
							Rectangle()
								.frame(width: 1)
								.offset(x: 8)
								.padding(.bottom, -35)
						}
					}
				
			}
		}
		.padding([.vertical, .leading], 15)
		.padding(.top, 15)
    }
}

#Preview {
    ContentView()
}
