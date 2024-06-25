//
//  NewTask.swift
//  ManagmentApp
//
//  Created by Montserrat Gomez on 2024-06-25.
//

import SwiftUI

struct NewTask: View {
	@Environment(\.dismiss) private var dismiss
	@State private var taskTitle : String = ""
	@State private var taskDate: Date = .init()
	@State private var taskColor:Color = .task1
	
    var body: some View {
		VStack(alignment: .leading, spacing: 15){
			Button(action:
					{ dismiss() },
				   label: {
				Text("Cancel")
					.foregroundStyle(.red)
					.bold()
			})
			.hSpacing(.trailing)
			
			VStack(alignment: .leading, spacing: 8){
				Text("Task title")
					.font(.caption)
					.foregroundStyle(.gray)
				
				TextField("Write here!", text: $taskTitle)
					.padding(.vertical, 12)
					.padding(.horizontal, 15)
					.background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
			}.padding(.top, 5)
			
			HStack{
				VStack(alignment: .leading, spacing: 8){
					Text("Task Date")
						.font(.caption)
						.foregroundStyle(.gray)
					
					DatePicker("", selection: $taskDate)
						.datePickerStyle(.compact)
						.scaleEffect(0.9, anchor: .leading)
				}
				
				//espacio para el tap
				.padding(.trailing, -15)
				
				VStack(alignment: .leading, spacing: 8){
					Text("Task Color")
						.font(.caption)
						.foregroundStyle(.gray)
					
					let colors: [Color] = [.task1, .task2, .task3, .task4, .task5]
					
					HStack(spacing: 0){
						ForEach(colors, id: \.self) { color in
							Circle()
								.fill(color)
								.frame(width: 20, height: 20, alignment: .center)
								.background(content: {
									Circle()
										.stroke(lineWidth: 3)
										.opacity(taskColor == color ? 1 : 0)
								})
								.hSpacing(.center)
								.contentShape(.rect)
								.onTapGesture {
									withAnimation(.snappy){
										taskColor = color
									}
								}
							
							
						}
					}
				}
				
			}
			.padding(.top, 5)
			
			Spacer(minLength: 0)
			
			Button(action: {}, label: {
				Text("Create Task")
					.font(.title3)
					.fontWeight(.semibold)
					.textScale(.secondary)
					.foregroundStyle(.black)
					.hSpacing(.center)
					.padding(.vertical, 12)
					.background(taskColor, in: .rect(cornerRadius: 10))
			})
			.disabled(taskTitle == "")
			.opacity(taskTitle == "" ? 0.5 : 1)
			
			
		}
		.padding(15)
    }
}

#Preview {
    NewTask()
		.vSpacing(.bottom)
}
