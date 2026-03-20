import SwiftUI

// MARK: - Direction Step Model
struct IndoorDirectionStep: Identifiable {
    let id = UUID()
    let stepNumber: Int
    let title: String
    let subtitle: String
    let distance: String
    let isCompleted: Bool
}

// MARK: - Indoor Navigation View
struct IndoorNavigationView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var showExpand: Bool = false
    @State private var showShareLocation: Bool = false
    @State private var showARView: Bool = false
    @State private var showVoiceDirections: Bool = false
    
    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)
    private let lightBlue = Color(red: 0.88, green: 0.93, blue: 0.97)
    
    var onNavigateToDashboard: (() -> Void)? = nil
    
    // Navigation details
    let roomNumber: String = "A-201"
    let consultationType: String = "General Consultation"
    let doctorName: String = "Dr. Smith"
    let floor: String = "2F"
    let distance: String = "150m"
    let estimatedTime: String = "2min"
    
    // Direction steps
    let directionSteps: [IndoorDirectionStep] = [
        IndoorDirectionStep(stepNumber: 1, title: "Take the elevator to 2nd floor", subtitle: "From your current position", distance: "30m", isCompleted: false),
        IndoorDirectionStep(stepNumber: 2, title: "Turn right from elevator", subtitle: "Head towards East Wing", distance: "50m", isCompleted: false),
        IndoorDirectionStep(stepNumber: 3, title: "Continue along main corridor", subtitle: "Pass rooms A-205, A-203", distance: "60m", isCompleted: false),
        IndoorDirectionStep(stepNumber: 4, title: "Arrive at Room A-201", subtitle: "On your right side", distance: "10m", isCompleted: true)
    ]
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                headerView
                
                // Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        // Navigation Info Card
                        navigationInfoCard
                        
                        // Floor Plan Section
                        floorPlanSection
                        
                        // Directions Section
                        directionsSection
                        
                        // Action Buttons (Share & AR)
                        actionButtonsRow
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 160)
                }
                
                Spacer()
            }
            
            // Bottom buttons
            VStack {
                Spacer()
                bottomButtons
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $showExpand) {
            ExpandedFloorPlanView()
        }
        .navigationDestination(isPresented: $showShareLocation) {
            ShareLocationView()
        }
        .navigationDestination(isPresented: $showARView) {
            ARNavigationView()
        }
        .navigationDestination(isPresented: $showVoiceDirections) {
            VoiceDirectionsView()
        }
    }
    
    // MARK: - Header
    var headerView: some View {
        HStack {
            Button(action: {
                if let callback = onNavigateToDashboard {
                    callback()
                } else {
                    dismiss()
                }
            }) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                    Text("Back")
                        .font(.system(size: 17))
                }
                .foregroundColor(.primary)
            }
            
            Spacer()
            
            Text("Navigation")
                .font(.system(size: 17, weight: .semibold))
            
            Spacer()
            
            // Placeholder for alignment
            HStack(spacing: 4) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                Text("Back")
                    .font(.system(size: 17))
            }
            .opacity(0)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }
    
    // MARK: - Navigation Info Card
    var navigationInfoCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header row
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 12, weight: .semibold))
                    Text("Navigating to")
                        .font(.system(size: 12, weight: .medium))
                }
                .foregroundColor(.white.opacity(0.9))
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.white.opacity(0.2))
                .cornerRadius(16)
                
                Spacer()
                
                Button(action: {
                    // Expand/minimize action
                }) {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 36, height: 36)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                }
            }
            
            // Room info
            VStack(alignment: .leading, spacing: 4) {
                Text("Room \(roomNumber)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                Text("\(consultationType) • \(doctorName)")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.8))
            }
            
            // Stats row
            HStack(spacing: 12) {
                statBox(label: "Floor", value: floor)
                statBox(label: "Distance", value: distance)
                statBox(label: "Time", value: estimatedTime)
            }
        }
        .padding(16)
        .background(navy)
        .cornerRadius(16)
    }
    
    func statBox(label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.7))
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
    }
    
    // MARK: - Floor Plan Section
    var floorPlanSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Floor Plan")
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
                Button(action: {
                    showExpand = true
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "rectangle.expand.vertical")
                            .font(.system(size: 14))
                        Text("Expand")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .foregroundColor(navy)
                }
            }
            
            // Floor indicator
            HStack(spacing: 12) {
                Text("2F")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 32, height: 32)
                    .background(navy)
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Second Floor")
                        .font(.system(size: 15, weight: .semibold))
                    Text("East Wing")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                HStack(spacing: 4) {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 8, height: 8)
                    Text("Active")
                        .font(.system(size: 13))
                        .foregroundColor(.green)
                }
            }
            .padding(12)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            
            // Map View
            ZStack {
                floorPlanBackground
                
                // Grid lines
                GeometryReader { geometry in
                    Path { path in
                        let width = geometry.size.width
                        let height = geometry.size.height
                        let spacing: CGFloat = 30
                        
                        // Vertical lines
                        for x in stride(from: 0, to: width, by: spacing) {
                            path.move(to: CGPoint(x: x, y: 0))
                            path.addLine(to: CGPoint(x: x, y: height))
                        }
                        
                        // Horizontal lines
                        for y in stride(from: 0, to: height, by: spacing) {
                            path.move(to: CGPoint(x: 0, y: y))
                            path.addLine(to: CGPoint(x: width, y: y))
                        }
                    }
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
                }
                
                // Compass
                VStack {
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.2))
                                .frame(width: 36, height: 36)
                            Text("N")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                            
                            // Compass needle
                            Path { path in
                                path.move(to: CGPoint(x: 18, y: 8))
                                path.addLine(to: CGPoint(x: 24, y: 18))
                            }
                            .stroke(Color.red, lineWidth: 2)
                        }
                        Spacer()
                    }
                    .padding(12)
                    Spacer()
                }
                
                // Current position marker
                VStack {
                    Spacer()
                        .frame(height: 80)
                    HStack {
                        Spacer()
                            .frame(width: 60)
                        
                        VStack(spacing: 4) {
                            ZStack {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 24, height: 24)
                                Circle()
                                    .stroke(Color.white, lineWidth: 3)
                                    .frame(width: 24, height: 24)
                            }
                            
                            Text("You are here")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.black.opacity(0.6))
                                .cornerRadius(4)
                        }
                        
                        Spacer()
                    }
                    Spacer()
                }
                
                // Destination marker
                VStack {
                    Spacer()
                        .frame(height: 70)
                    HStack {
                        Spacer()
                        
                        VStack(spacing: 4) {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 28, height: 28)
                                Image(systemName: "arrow.down")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.red)
                            }
                            
                            Text(roomNumber)
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.red)
                                .cornerRadius(4)
                        }
                        
                        Spacer()
                            .frame(width: 80)
                    }
                    Spacer()
                }
                
                // Path line (simplified)
                Path { path in
                    path.move(to: CGPoint(x: 90, y: 120))
                    path.addLine(to: CGPoint(x: 150, y: 120))
                    path.addLine(to: CGPoint(x: 150, y: 80))
                    path.addLine(to: CGPoint(x: 220, y: 80))
                }
                .stroke(style: StrokeStyle(lineWidth: 3, dash: [6, 4]))
                .foregroundColor(.blue.opacity(0.8))
                
                // Legend
                VStack {
                    Spacer()
                    HStack(spacing: 16) {
                        HStack(spacing: 6) {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 10, height: 10)
                            Text("You")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                        }
                        
                        Rectangle()
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 1, height: 16)
                        
                        HStack(spacing: 6) {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 10, height: 10)
                            Text("Goal")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(20)
                    .padding(.bottom, 12)
                }
            }
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    private var floorPlanBackground: some View {
        Image("FloorPlan")
            .resizable()
            .scaledToFill()
            .overlay(navy.opacity(0.15))
    }
    
    // MARK: - Directions Section
    var directionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Directions")
                .font(.system(size: 16, weight: .semibold))
            
            VStack(spacing: 0) {
                ForEach(Array(directionSteps.enumerated()), id: \.element.id) { index, step in
                    HStack(alignment: .top, spacing: 12) {
                        // Step number or checkmark
                        ZStack {
                            Circle()
                                .fill(step.isCompleted ? Color.green : navy)
                                .frame(width: 28, height: 28)
                            
                            if step.isCompleted {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.white)
                            } else {
                                Text("\(step.stepNumber)")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(step.title)
                                .font(.system(size: 15, weight: step.isCompleted ? .semibold : .regular))
                                .foregroundColor(step.isCompleted ? .green : .primary)
                            Text(step.subtitle)
                                .font(.system(size: 13))
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Text(step.distance)
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    
                    if index < directionSteps.count - 1 {
                        Divider()
                            .padding(.leading, 56)
                    }
                }
            }
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
    }
    
    // MARK: - Action Buttons Row
    var actionButtonsRow: some View {
        HStack(spacing: 12) {
            // Share Location
            Button(action: {
                showShareLocation = true
            }) {
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(lightBlue)
                            .frame(width: 44, height: 44)
                        Image(systemName: "arrow.up")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(navy)
                    }
                    
                    VStack(spacing: 2) {
                        Text("Share Location")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.primary)
                        Text("Send to companion")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
            }
            
            // AR View
            Button(action: {
                showARView = true
            }) {
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(lightBlue)
                            .frame(width: 44, height: 44)
                        Image(systemName: "eye.fill")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(navy)
                    }
                    
                    VStack(spacing: 2) {
                        Text("AR View")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.primary)
                        Text("Camera navigation")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
            }
        }
    }
    
    // MARK: - Bottom Buttons
    var bottomButtons: some View {
        VStack(spacing: 12) {
            // Mark as Arrived button
            Button(action: {
                if let callback = onNavigateToDashboard {
                    callback()
                } else {
                    dismiss()
                }
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark")
                        .font(.system(size: 14, weight: .bold))
                    Text("Mark as Arrived")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(navy)
                .cornerRadius(30)
            }
            .padding(.horizontal, 16)
            
            // Voice Directions
            Button(action: {
                showVoiceDirections = true
            }) {
                HStack(spacing: 6) {
                    Image(systemName: "waveform.circle")
                        .font(.system(size: 16))
                    Text("Voice Directions")
                        .font(.system(size: 15, weight: .medium))
                }
                .foregroundColor(navy)
            }
            .padding(.bottom, 16)
        }
        .padding(.top, 12)
        .background(
            Color(.systemBackground)
                .shadow(color: .black.opacity(0.05), radius: 8, y: -4)
        )
    }
}

#Preview {
    NavigationStack {
        IndoorNavigationView()
    }
}
