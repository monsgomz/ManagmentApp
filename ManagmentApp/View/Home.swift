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
	
	
	///Animation namespace
	@Namespace private var animation //MARK: Es normalmente usado cuando se quieren crear animaciones entre vistas o cambios de estados
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0, content: {
			HeaderView()
		})
		.vSpacing(.top)
		.onAppear(perform: {
			if weekSlider.isEmpty {
				let currentWeek = Date().fetchWeek()
				
				weekSlider.append(currentWeek)
				
				if let firstDate = currentWeek.first?.date {
					weekSlider.append(firstDate.previousWeek())
				}
				
				if let lastDate = currentWeek.last?.date{
					weekSlider.append(lastDate.nextWeek())
				}
			}
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
	}
}

#Preview {
    Home()
}
