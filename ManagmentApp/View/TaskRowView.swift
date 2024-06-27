//
//  TaskRowView.swift
//  ManagmentApp
//
//  Created by Montserrat Gomez on 2024-06-25.
/*
 SwiftData model conforma de @Obervable lo que significa que podemos usar @Bindable para que los cambios en el model se guarden automaticamente
 */

import SwiftUI

struct TaskRowView: View {
//	@Binding var task: Task
	@Bindable var task: Task
	
    var body: some View {
		HStack(alignment: .top, spacing: 15){
			Circle()
				.fill(indicatorColor)
				.frame(width: 10, height: 10, alignment: .center)
				.padding(4)
				.background(.white.shadow(.drop(color:.black.opacity(0.1) ,radius: 3)), in: .circle)
				.overlay {
					Circle()
						.frame(width: 50, height: 50, alignment: .center)
						.blendMode(.destinationOver)
						.onTapGesture {
							withAnimation(.snappy) {
								task.isCompleted.toggle()  
							}
						}
				}
			
			VStack(alignment: .leading, spacing: 0){
				Text(task.tasktitle)
					.fontWeight(.semibold)
					.foregroundStyle(.black)
					
				
				Label(task.creationDate.format("hh:mm a"), systemImage: "clock")
					.font(.caption)
					.foregroundStyle(.black)
			}
			.padding(15)
			.hSpacing(.leading)
			.background(task.tintColor, in: .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
			.strikethrough(task.isCompleted, pattern: .solid, color: .gray) //cuando es true
			.offset(y: -8)
		}
		
    }
	
	var indicatorColor: Color {
		if task.isCompleted {
			return .green
		}
		return task.creationDate.isSameHour ? .ultraViolet : (task.creationDate.isPastHour ? .red : .black)
	}
	
	
	
}

#Preview {
	ContentView()
}
