import SwiftUI

struct ContentView: View {
    
    @State private var isAnimated: Bool = false
    @State private var name = ""
    @State private var motto = ""
    @State private var note = ""
    
    @State private var showSettingPopup = false
    @State private var showNotivicationPopup = false
    @State private var showAddHabitsPopup = false
    @State private var showShufflePopup = false

    
    @State private var shakePhone: Bool = false
    @State private var shakeCount: Int = 0   // track shakes for undo/redo
    
    var body: some View {
        ZStack(alignment: .top) {
            
            // Background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 230/255, green: 230/255, blue: 250/255).opacity(0.8),
                    Color.white
                ]),
                startPoint: .top,
                endPoint: .center
            )
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                
                // Header with name + settings + icons
                HStack {
                    // Welcome text + edit button
                    HStack(spacing: 9) {
                        Text("Welcome Back, \(name) !")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundStyle(.black)
                    
                        Button(action: { showSettingPopup = true }) {
                            Image(systemName: "pencil.and.scribble")
                                .foregroundColor(Color(hex: "4B0082"))
                                .font(.system(size: 15, weight: .heavy))
                        }
                        .sheet(isPresented: $showSettingPopup) {
                            SettingSheet(
                                name: $name,
                                motto: $motto,
                                note: $note,
                                showSettingPopup: $showSettingPopup
                            )
                        }
                    }
                    
                    Spacer()
                    
                    // Icons
                    HStack(spacing: 12) {
                        StreakIcon()
                        NotificationIcon(isAnimated: $isAnimated, showNotivicationPopup: $showNotivicationPopup)
                        
                    }
                }
                .padding(.horizontal)
                .padding(.top, 32)
                .padding(.bottom, 32)
                
                // Page title
                Text("Tracking Your \n Habits")
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                    .frame(width: 350, height: 100, alignment: .leading)
                    .padding(.horizontal)
                
                // Calendar
                CalendarSection()
                
                // Today’s Activities
                HStack {
                    Text("Today’s Activities")
                        .font(.system(size: 20, weight: .semibold))
                    
                    Spacer()
                    
                    // Add Habits button
                    Button(action: { showAddHabitsPopup = true }) {
                        Circle()
                            .fill(Color(red: 230/255, green: 230/255, blue: 250/255))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color(hex: "4B0082"))
                            )
                    }
                    .sheet(isPresented: $showAddHabitsPopup) {
                        AddHabitsSheet(
                            shakePhone: $shakePhone,
                            shakeCount: $shakeCount,
                            showShufflePopup: $showShufflePopup,
                            dismissParent: { showAddHabitsPopup = false }
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
                
                
                // Activities list
                ActivitiesList()
                
            }
        }
        // Second sheet (appears after AddHabitsSheet dismisses)
        .sheet(isPresented: $showShufflePopup) {
            HabitsShuffle()
                .presentationDetents([.medium, .large])
        }
    }
}

struct SettingSheet: View {
    @Binding var name: String
    @Binding var motto: String
    @Binding var note: String
    @Binding var showSettingPopup: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Your Name", text: $name)
                .padding()
                .frame(width: 345, height: 40)
                .keyboardType(.default) .submitLabel(.done)
                .background(.white) .cornerRadius(10)
                
            
            TextField("Your Motto", text: $motto)
                .padding()
                .frame(width: 345, height: 40)
                .keyboardType(.default) .submitLabel(.done)
                .background(.white) .cornerRadius(10)
            
            TextField("Your Note to Self", text: $note)
                .padding()
                .frame(width: 345, height: 40)
                .keyboardType(.default) .submitLabel(.done)
                .background(.white) .cornerRadius(10)
            
            Button("Done") {
                showSettingPopup = false
            }
            .font(.system(size: 18, weight: .bold))
            .frame(width: 150, height: 40)
            .foregroundColor(.white)
            .background(Color(hex: "4B0082"))
            .cornerRadius(8)
        }
        .padding()
        .presentationDetents([.medium, .large])
        .frame(width: UIScreen.main.bounds.width, height: 900)
        .background(Color(red: 230/255, green: 230/255, blue: 250/255))
        
    }
}

struct AddHabitsSheet: View {
    @Binding var shakePhone: Bool
    @Binding var shakeCount: Int
    @Binding var showShufflePopup: Bool
    
    var dismissParent: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("SHAKE!")
                .font(.system(size: 50, weight: .bold, design: .rounded))
                .foregroundColor(Color(hex: "4B0082"))
            
            Image(.sheke)
                .resizable()
                .scaledToFit()
                .frame(width: 240, height: 240)
                .rotationEffect(.degrees(shakePhone ? -10 : 10))
                .animation(.easeInOut(duration: 0.25).repeatForever(autoreverses: true), value: shakePhone)
                .onAppear { shakePhone = true }
            
            HStack(spacing: 40) {
                Button("Undo") {
                    if shakeCount > 0 { shakeCount -= 1 }
                }
                .disabled(shakeCount == 0)
                .buttonStyle(ActionButtonStyle(enabled: shakeCount > 0))
                
                Button("Redo") { shakeCount += 1 }
                    .buttonStyle(ActionButtonStyle(enabled: true))
            }
            .padding(.top, 20)
            
            Spacer()
            
            if shakeCount > 0 {
                Text("Shakes: \(shakeCount)")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(Color(hex: "191970"))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 230/255, green: 230/255, blue: 250/255))
        .presentationDetents([.medium, .large])
        .onShake {
            // Dismiss current sheet then show shuffle
            dismiss()
            dismissParent()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                showShufflePopup = true
            }
        }
    }
}



struct StreakIcon: View {
    var body: some View {
        ZStack {
            Circle().fill(Color(red: 230/255, green: 230/255, blue: 250/255)).frame(width: 40, height: 40)
            Image(systemName: "flame.fill")
                .foregroundColor(Color(red: 252/255, green: 85/255, blue: 6/255))
            Text("x2").font(.system(size:14, design: .rounded))
                .bold()
                .offset(x:5, y: 7)
                .foregroundColor(Color(red: 75/255, green: 0/255, blue: 130/255))
        }
    }
}

struct NotificationIcon: View {
    @Binding var isAnimated: Bool
    @Binding var showNotivicationPopup: Bool
    
    var body: some View {
        Button(action: { showNotivicationPopup = true }) {
            Circle()
                .fill(Color(red: 230/255, green: 230/255, blue: 250/255))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: "bell.badge")
                        .foregroundStyle(Color(red: 252/255, green: 85/255, blue: 6/255), Color(hex: "4B0082"))
                        .offset(x: isAnimated ? -2 : 2)
                        .animation(.easeInOut(duration: 0.5).repeatForever(), value: isAnimated)
                )
                .onAppear { isAnimated = true }
        }
        .sheet(isPresented: $showNotivicationPopup) {
            NotificationsView()
                .presentationDetents([.medium, .large])
        }
    }
}

struct CalendarSection: View {
    @State private var showCalenderSheet = false
    var body: some View {
        VStack {
            Button{
                showCalenderSheet = true
            }label: {
                Text("View All")
                     .font(.system(size: 10, weight: .regular))
                     .frame(maxWidth: .infinity, alignment: .trailing)
                     .padding(.bottom, 8)
                     .padding(.trailing, 20)
                     .underline()
                     .foregroundColor(Color(hex: "4B0082"))
            }.sheet(isPresented: $showCalenderSheet){
                Calendar()
            }
            
                
           
            
            HStack(spacing: 24) {
                ForEach(["Sun","Mon","Tue","Wed","Thu","Fri","Sat"], id: \.self) { day in
                    Text(day)
                        .foregroundColor(.gray)
                        .font(.system(size: 15, weight: .regular))
                }
            }
            
            HStack(spacing: 40) {
                ForEach(1...7, id: \.self) { day in
                    Text("\(day)")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .regular))
                }
            }
            .padding(.top, 16)
            .background(Color(red: 75/255, green: 0/255, blue: 130/255).opacity(0.4)
                .opacity(0.4)
                .cornerRadius(8)
                .frame(width: 345, height: 35)
                .padding(.top, 16))
            .background( Color(red: 75/255, green: 0/255, blue: 130/255) .frame(width: 280, height: 25) .cornerRadius(8)
                .padding(.trailing, 45)
                .padding(.top, 16) )
            
        }
        .padding(.horizontal)
    }
}

struct ActivitiesList: View {
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 230/255, green: 230/255, blue: 250/255))
                .frame(maxWidth: .infinity, minHeight: 338, maxHeight: 338)
                .padding(.horizontal)
            
            ScrollView {
                VStack(spacing: 24) {
                    ForEach(0..<7, id: \.self) { _ in
                        HStack {
                            Text("Speak to your family for 10 Minutes")
                                .font(.system(size: 17, weight: .bold))
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color(hex: "4B0082"))
                        }
                        .padding(.horizontal, 12)
                        .frame(height: 40)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.white).opacity(0.7))
                        .frame(width: 350)
                    }
                }
                .padding(.top, 16)
            }
            .frame(height: 330)
        }
    }
}

struct ActionButtonStyle: ButtonStyle {
    var enabled: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 28)
            .background(enabled ? Color(hex: "4B0082") : Color.gray.opacity(0.4))
            .clipShape(Capsule())
    }
}

// MARK: - HEX Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        (r,g,b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        self.init(.sRGB,
                  red: Double(r) / 255,
                  green: Double(g) / 255,
                  blue: Double(b) / 255,
                  opacity: 1)
    }
}

// MARK: - Shake Detection
extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: .deviceDidShakeNotification, object: nil)
        }
    }
}

extension Notification.Name {
    static let deviceDidShakeNotification = Notification.Name("deviceDidShakeNotification")
}

struct ShakeDetector: ViewModifier {
    var onShake: () -> Void
    func body(content: Content) -> some View {
        content.onReceive(NotificationCenter.default.publisher(for: .deviceDidShakeNotification)) { _ in
            onShake()
        }
    }
}

extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        modifier(ShakeDetector(onShake: action))
    }
}

#Preview {
    ContentView()
}
