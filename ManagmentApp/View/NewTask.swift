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
				Image(systemName: "xmark.circle.fill")
					.font(.title)
					.tint(.red)
			})
		}
    }
}

#Preview {
    NewTask()
		.vSpacing(.bottom)
}
