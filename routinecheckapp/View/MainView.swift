//
//  MainView.swift
//  RoutineCheckAppTestAssignment
//
//  Created by Muhammad Ahmed on 17/12/2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = RoutineViewModel()
    
    @State private var title: String = ""
    @State private var descriptionroutine: String = ""
    @State private var date = Date()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Routine Check")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                
                VStack(spacing: 15) {
                    TextField("Title", text: $title)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    
                    TextField("Description", text: $descriptionroutine)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    
                    DatePicker("Select Date", selection: $date, displayedComponents: .date)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)
                
                Button(action: {
                    viewModel.addRoutine(title: title, descriptionroutine: descriptionroutine, date: date)
                    NotificationManager.shared.scheduleNotification(title: title, body: descriptionroutine, date: date)
                    clearFields()
                }) {
                    Text("Add Routine")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [.orange, .red]),
                                                   startPoint: .leading,
                                                   endPoint: .trailing))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)
                
                List {
                    ForEach(viewModel.routines, id: \.id) { routine in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(routine.title ?? "No Title")
                                .font(.headline)
                                .foregroundColor(.purple)
                            Text(routine.descriptionroutine ?? "No Description")
                                .font(.headline)
                                .foregroundColor(.purple)
                            Text("\(formattedDate(routine.date ?? Date()))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                    }
                    .listRowBackground(Color.clear)
                }
                .listStyle(PlainListStyle())
                .background(Color.clear)
            }
            .padding()
        }
        .onAppear {
            viewModel.loadRoutines()
            NotificationManager.shared.requestPermission()
        }
    }
    
    private func clearFields() {
        title = ""
        descriptionroutine = ""
        date = Date()
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

