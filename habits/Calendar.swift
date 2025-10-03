//
//  Calendar.swift
//  Novus Calendar Page1
//
//  Created by Fai Altayeb on 01/10/2025.
//

import SwiftUI

struct Calendar: View {
    @State private var dateSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            // Title
            Text("Calendar")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
            
            // Month header
            HStack {
                Text("February")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Image(systemName: "arrowtriangle.left.and.line.vertical.and.arrowtriangle.right")
                    .resizable()
                    .frame(width: 28, height: 22)
                    .foregroundColor(.purple)
            }
            .padding(.leading, 18)
            
            // Weekday labels
            HStack(spacing: 24) {
                Text("Sun")
                Text("Mon")
                Text("Tue")
                Text("Wed")
                Text("Thu")
                Text("Fri")
                Text("Sat")
            }
            .font(.system(size: 15, weight: .regular))
            .foregroundStyle(Color(red: 129/255, green: 127/255, blue: 127/255))
            .frame(maxWidth: .infinity)
            
            // Week 1
            HStack(spacing: 40) {
                ForEach(1...7, id: \.self) { day in
                    Text("\(day)")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(.white)
                }
            }
            .padding(.top, 16)
            .background(
                Color(red: 25/255, green: 25/255, blue: 112/255).opacity(0.4)
                    .frame(width: 345, height: 35)
                    .cornerRadius(8)
                    .padding(.top, 16)
            )
            .frame(maxWidth: .infinity)
            .background(
                Color(red: 25/255, green: 25/255, blue: 112/255)
                    .frame(width: 335, height: 25)
                    .cornerRadius(8)
                    .padding(.top, 16)
            )
            
            // Week 2
            HStack(spacing: 38) {
                ForEach(8...14, id: \.self) { day in
                    Text("\(day)")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(.white)
                }
            }
            .padding(.top, 16)
            .background(
                Color(red: 100/255, green: 149/255, blue: 237/255).opacity(0.4)
                    .frame(width: 345, height: 35)
                    .cornerRadius(8)
                    .padding(.top, 16)
            )
            .frame(maxWidth: .infinity)
            .background(
                Color(red: 100/255, green: 149/255, blue: 237/255)
                    .frame(width: 335, height: 25)
                    .cornerRadius(8)
                    .padding(.top, 16)
            )
            
            // Week 3
            HStack(spacing: 36) {
                ForEach(15...21, id: \.self) { day in
                    if day == 20 {
                        Button(action: { dateSheet = true }) {
                            Text("\(day)")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundStyle(.white)
                        }
                        .sheet(isPresented: $dateSheet) {
                            ZStack {
                                Color(red: 230/255, green: 230/255, blue: 250/255)
                                    .ignoresSafeArea()
                                
                                Button(action: { dateSheet = false }) {
                                    Image(systemName: "x.circle.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundStyle(Color(red: 75/255, green: 0/255, blue: 130/255))
                                }
                                .position(x: 370, y: 40)
                                
                                VStack(alignment: .leading, spacing: 20) {
                                    Text("Friday 20")
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color(red: 75/255, green: 0/255, blue: 130/255))
                                    
                                    // Big habit
                                    HStack {
                                        Circle()
                                            .fill(Color(red: 251/255, green: 207/255, blue: 79/255))
                                            .frame(width: 20, height: 20)
                                        VStack(alignment: .leading) {
                                            Text("Your big habit for this week:")
                                                .font(.title3)
                                                .foregroundStyle(Color(red: 75/255, green: 0/255, blue: 130/255))
                                                .fontWeight(.semibold)
                                            Text("Public Speaking")
                                                .font(.caption)
                                                .fontWeight(.light)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding(.leading, -30)
                                    
                                    // Micro habit
                                    HStack {
                                        Circle()
                                            .fill(Color(red: 251/255, green: 207/255, blue: 79/255))
                                            .frame(width: 20, height: 20)
                                        VStack(alignment: .leading) {
                                            Text("Your micro habit for this day:")
                                                .font(.title3)
                                                .foregroundStyle(Color(red: 75/255, green: 0/255, blue: 130/255))
                                                .fontWeight(.semibold)
                                            Text("Speak with your family for 10 minutes")
                                                .font(.caption)
                                                .fontWeight(.light)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding(.leading, -30)
                                }
                            }
                            .presentationDetents([.medium, .large])
                        }
                    } else {
                        Text("\(day)")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding(.top, 16)
            .background(
                Color(red: 75/255, green: 0/255, blue: 130/255).opacity(0.4)
                    .frame(width: 345, height: 35)
                    .cornerRadius(8)
                    .padding(.top, 16)
            )
            .frame(maxWidth: .infinity)
            .background(
                Color(red: 75/255, green: 0/255, blue: 130/255)
                    .frame(width: 290, height: 25)
                    .cornerRadius(8)
                    .padding(.trailing, 44)
                    .padding(.top, 16)
            )
            
            // Week 4
            HStack(spacing: 35) {
                ForEach(22...28, id: \.self) { day in
                    Text("\(day)")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(.white)
                }
            }
            .padding(.top, 16)
            .background(
                Color(red: 251/255, green: 207/255, blue: 79/255).opacity(0.4)
                    .frame(width: 345, height: 35)
                    .cornerRadius(8)
                    .padding(.top, 16)
            )
            .frame(maxWidth: .infinity)
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 100)
    }
}

#Preview {
    Calendar()
}
