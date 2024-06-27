//
//  Home.swift
//  ManagmentApp
//
//  Created by Montserrat Gomez on 2024-06-19.
/* Cuadno se genera la primera semana, se hace un fetch de una previa y de una siguiente, cuando se alcancen estas, se vuelve a hacer fetch
 
 */

import SwiftUI

struct Home: View {
	///Task manager Properties
	@State private var currentDate: Date = .init()
	@State private var weekSlider: [[Date.weekDay]] = []
	@State private var currentWeekDayIndex: Int = 0
	@State private var createWeek: Bool = false
//	@State private var tasks: [Task] = sampleTasks.sorted(by: {$1.creationDate > $0.creationDate}) //datos de ejemplos
	@State private var createNewTask: Bool = false
	
	///Animation namespace
	@Namespace private var animation //MARK: Es normalmente usado cuando se quieren crear animaciones entre vistas o cambios de estados
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0, content: {
			HeaderView()
			
			///Task view
			ScrollView(.vertical){
				VStack{
					TaskView(currentDate: $currentDate)
				}
				.hSpacing(.center)
				.vSpacing(.center)
			}
			.overlay {
				ContentUnavailableView("No Tasks yet", systemImage: "tray.fill", description: Text("Add tasks to start"))
			}
		})
		.vSpacing(.top)
		//MARK: Button
		.overlay(alignment: .bottomTrailing){
			Button(action:
					{createNewTask.toggle()
				   }, label: {
				Image(systemName: "plus")
					.fontWeight(.semibold)
					.foregroundStyle(.white)
					.frame(width: 55, height: 55, alignment: .center)
					.background(.ultraViolet.shadow(.drop(color: .black.opacity(0.25), radius: 5, x: 10, y: 10)), in: .circle )
			}).padding(10)
		}
		.onAppear(perform: {
			if weekSlider.isEmpty {
				let currentWeek = Date().fetchWeek()
				
				if let firstDate = currentWeek.first?.date {
					weekSlider.append(firstDate.previousWeek())
				}
				
				weekSlider.append(currentWeek)
				
				if let lastDate = currentWeek.last?.date{
					weekSlider.append(lastDate.nextWeek())
				}
			}
		})
		.sheet(isPresented: $createNewTask, content: {
			NewTask()
				.presentationDetents([.height(300)])
				.interactiveDismissDisabled()
				.presentationCornerRadius(30)
				.presentationBackground(.BG)
		})
		
    }
	
	
	//MARK: Header
	//Te permite crear vistas personalizadas de vistas pequeñas
	@ViewBuilder
	func HeaderView() -> some View {
		VStack(alignment: .leading, spacing: 6){
			HStack(spacing: 5){
				Text(currentDate.format("MMMM"))
					.foregroundStyle(.ultraViolet)
				
				Text(currentDate.format("YYYY"))
					.foregroundStyle(.gray)
			}
			.font(.title.bold())
			
			Text(currentDate.formatted(date: .complete, time: .omitted))
				.font(.callout)
				.fontWeight(.semibold)
				.textScale(.secondary)
				.foregroundStyle(.gray)
			
			//MARK: Week Slider
			TabView(selection: $currentWeekDayIndex,
					content:  {
				ForEach(weekSlider.indices, id: \.self) { index in
					let week = weekSlider[index]
					WeekView(week)
						.padding(.horizontal, 10)
						.tag(index)
				}
			})
			.padding(.horizontal, -15)
			.tabViewStyle(.page(indexDisplayMode: .never))
			.frame(height: 90)
				
			
		}
		.hSpacing(.leading)
		.overlay(alignment: .topTrailing, content: {
			Button(action: {}, label: {
				Image("profile")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 45, height: 45, alignment: .center)
					.clipShape(Circle())
			})
		})
		.padding(15)
		.hSpacing(.leading)
		.background(.white)
		.onChange(of: currentWeekDayIndex, initial: false) { oldValuse, newValue in
			///Para crear nueva semana cuando alcanza la ultima o la previa
			//MARK: para preservar la memoria, despues de hacer el nuevo fetching, se eliminará el ultimo array, asi siempre seran 3 elementos
			if newValue == 0 || newValue == (weekSlider.count - 1) {
				createWeek = true
			}
			
		}
	}
	
	//MARK: Week view
	@ViewBuilder
	func WeekView(_ week: [Date.weekDay]) -> some View {
		HStack(spacing: 0){
			ForEach(week) { day in
				VStack(spacing: 0){
					Text(day.date.format("E"))
						.font(.callout)
						.fontWeight(.medium)
						.textScale(.secondary)
						.foregroundStyle(.gray)
					
					Text(day.date.format("dd"))
						.font(.callout)
						.fontWeight(.medium)
						.textScale(.secondary)
						.foregroundStyle(isSameDate(date1: day.date, date2: currentDate) ? .white : .gray)
						.frame(width: 35, height: 35)
						.background(content: {
							if isSameDate(date1: day.date, date2: currentDate){
								Circle()
									.fill(.ultraViolet)
									.matchedGeometryEffect(id: "TABINDICATOR", in: animation)
							}
							
							///Indicador para saber el dia actual
							if day.date.isToday {
								Circle()
									.fill(.ultraViolet)
									.frame(width: 5, height: 5)
									.vSpacing(.bottom)
									.offset(y: 12)
							}
							
							
						})
						.background(.white.shadow(.drop(radius: 1)), in: .circle)
						.padding(5)
				}
				.hSpacing(.center)
				.contentShape(.rect)
				.onTapGesture {
					///Cuando das clic y cambias de dia
					withAnimation(.snappy){
						currentDate = day.date
					}
				}
				
			}
		}
		.background {
			GeometryReader {
				let minX = $0.frame(in: .global).minX
				
				Color.clear
					.preference(key: OffsetKey.self, value: minX)
					.onPreferenceChange(OffsetKey.self) { value in
						//para que cuando el offset termine en 15
						if value.rounded() == 15 && createWeek {
							paginateWeek()
							createWeek = false
						}
						
					}
			}
		}
	}
	
	func paginateWeek() {
		if weekSlider.indices.contains(currentWeekDayIndex) {
			if let firstDate = weekSlider[currentWeekDayIndex].first?.date, currentWeekDayIndex == 0 {
				//insertar la semana anterior y borrar el ultimo elemento
				weekSlider.insert(firstDate.previousWeek(), at: 0)
				weekSlider.removeLast()
				currentWeekDayIndex = 1
			}
			
			if let lastDate = weekSlider[currentWeekDayIndex].last?.date, currentWeekDayIndex == (weekSlider.count - 1) {
				//insertar la nueva semana y borrar el ultimo elemento
				weekSlider.append(lastDate.nextWeek())
				weekSlider.removeFirst()
				currentWeekDayIndex = weekSlider.count - 2
			}
			
		}
	}
	
}

#Preview {
    Home()
}
