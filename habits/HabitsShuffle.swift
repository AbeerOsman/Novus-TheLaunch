import SwiftUI

struct HabitsShuffle: View {
    @State private var habits = ["Reading", "Public Speaking", "Meditation", "Workout", "Learning Swift"]
    @State private var currentIndex: Int = 0
    @State private var acceptedHabit: String? = nil
    
    let cardColors: [Color] = [
        Color(red: 0.39, green: 0.58, blue: 0.93),  // Blue - 6495ED
        Color(red: 0.29, green: 0.0, blue: 0.51),   // Purple - 4B0082
        Color(red: 0.98, green: 0.81, blue: 0.31),  // Yellow - FBCF4F
    ]
    
    var body: some View {
        VStack {
            Spacer()
                
            // Carousel
            GeometryReader { proxy in
                let cardWidth = proxy.size.width * 0.67
                let cardHeight: CGFloat = 250
                let sideCardScale: CGFloat = 0.85
                let sideCardOffset: CGFloat = cardWidth * 0.65
                
                ZStack {
                    // Left card
                    if habits.count > 0 {
                        let leftIndex = (currentIndex - 1 + habits.count) % habits.count
                        RoundedRectangle(cornerRadius: 28)
                            .fill(cardColors[leftIndex % cardColors.count])
                            .frame(width: cardWidth * sideCardScale, height: cardHeight * sideCardScale)
                            .overlay(
                                Text(habits[leftIndex])
                                    .font(.custom("SF Pro Rounded", size: 22).weight(.bold))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 16)
                            )
                            .offset(x: -sideCardOffset, y: 30)
                            .zIndex(0)
                    }
                    
                    // Center card
                    RoundedRectangle(cornerRadius: 28)
                        .fill(cardColors[currentIndex % cardColors.count])
                        .frame(width: cardWidth, height: cardHeight)
                        .overlay(
                            VStack(spacing: 24) {
                                if let chosen = acceptedHabit {
                                    Text("You chose: \(chosen)")
                                        .font(.custom("SF Pro Rounded", size: 28).weight(.bold))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 24)
                                } else {
                                    Text(habits[currentIndex % habits.count])
                                        
                                        .font(.system(size: 40, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 24)
                                    
                                    // Checkmark button
                                    Button(action: {
                                        withAnimation {
                                            acceptedHabit = habits[currentIndex]
                                        }
                                    }) {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 34, weight: .bold))
                                            .foregroundColor(Color(red: 0.29, green: 0.0, blue: 0.51))
                                            .frame(width: 50, height: 50)
                                            .background(Color.white)
                                            .clipShape(Circle())
                                            .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
                                    }
                                }
                            }
                        )
                        .shadow(color: Color.black.opacity(0.15), radius: 12, x: 0, y: 6)
                        .zIndex(1)
                        .gesture(
                            DragGesture()
                                .onEnded { value in
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                        if value.translation.width < -50 {
                                            currentIndex = (currentIndex + 1) % habits.count
                                        } else if value.translation.width > 50 {
                                            currentIndex = (currentIndex - 1 + habits.count) % habits.count
                                        }
                                    }
                                }
                        )
                    
                    // Right card
                    if habits.count > 2 {
                        let rightIndex = (currentIndex + 1) % habits.count
                        RoundedRectangle(cornerRadius: 28)
                            .fill(cardColors[rightIndex % cardColors.count])
                            .frame(width: cardWidth * sideCardScale, height: cardHeight * sideCardScale)
                            .overlay(
                                Text(habits[rightIndex])
                                    .font(.custom("SF Pro Rounded", size: 22).weight(.bold))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 16)
                            )
                            .offset(x: sideCardOffset, y: 30)
                            .zIndex(0)
                    }
                }
                .frame(width: proxy.size.width, height: cardHeight + 60)
            }
            .frame(height: 400)
            .padding(.top, 20)
            
            // Page indicator
            HStack(spacing: 8) {
                ForEach(0..<habits.count, id: \.self) { index in
                    Capsule()
                        .fill(index == currentIndex ? Color(red: 0.29, green: 0.0, blue: 0.51) : Color.gray.opacity(0.3))
                        .frame(width: index == currentIndex ? 36 : 8, height: 8)
                        .animation(.easeInOut(duration: 0.2), value: currentIndex)
                }
            }
            .padding(.top, 12)
            
            Spacer()
        }
        .background(
            Color(red: 230/255, green: 230/255, blue: 250/255)
                .frame(width: UIScreen.main.bounds.width, height: 900)
          )
    }
}

#Preview {
    HabitsShuffle()
}
