import SwiftUI

// MARK: - Models
struct RoomDirectionStep: Identifiable {
    let id = UUID()
    let stepNumber: Int
    let title: String
    let subtitle: String
    let distance: String
    let isArrival: Bool
}

// MARK: - Room Navigation View
struct RoomNavigationView: View {
    @Environment(\.dismiss) private var dismiss
    var onNavigateToDashboard: (() -> Void)? = nil
    
    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)
    private let lightBlue = Color(red: 0.88, green: 0.93, blue: 0.97)
    
    let directionSteps: [RoomDirectionStep] = [
        RoomDirectionStep(stepNumber: 1, title: "Take the elevator to 2nd floor", subtitle: "From your current position", distance: "30m", isArrival: false),
        RoomDirectionStep(stepNumber: 2, title: "Turn right from elevator", subtitle: "Head towards East Wing", distance: "50m", isArrival: false),
        RoomDirectionStep(stepNumber: 3, title: "Continue along main corridor", subtitle: "Pass rooms A-205, A-203", distance: "60m", isArrival: false),
        RoomDirectionStep(stepNumber: 4, title: "Arrive at Room A-201", subtitle: "On your right side", distance: "10m", isArrival: true)
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
                    VStack(spacing: 16) {
                        destinationCard
                        floorPlanSection
                        directionsSection
                        actionButtonsRow
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 140)
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
    
    // MARK: - Destination Card
    var destinationCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                // Navigating to badge
                HStack(spacing: 6) {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 12, weight: .semibold))
                    Text("Navigating to")
                        .font(.system(size: 13, weight: .semibold))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.white.opacity(0.2))
                .cornerRadius(20)
                
                Spacer()
                
                // Arrow button
                Button(action: {
                    // External navigation action
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 40, height: 40)
                        Image(systemName: "arrow.right")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Room A-201")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
                Text("General Consultation • Dr. Smith")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.8))
            }
            
            // Stats Row
            HStack(spacing: 0) {
                // Floor
                VStack(alignment: .leading, spacing: 4) {
                    Text("Floor")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.7))
                    Text("2F")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(Color.white.opacity(0.1))
                .cornerRadius(12)
                
                Spacer().frame(width: 8)
                
                // Distance
                VStack(alignment: .leading, spacing: 4) {
                    Text("Distance")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.7))
                    Text("150m")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(Color.white.opacity(0.1))
                .cornerRadius(12)
                
                Spacer().frame(width: 8)
                
                // Time
                VStack(alignment: .leading, spacing: 4) {
                    Text("Time")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.7))
                    Text("2min")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(Color.white.opacity(0.1))
                .cornerRadius(12)
            }
        }
        .padding(20)
        .background(navy)
        .cornerRadius(20)
        .shadow(color: navy.opacity(0.35), radius: 8, y: 4)
    }
    
    // MARK: - Floor Plan Section
    var floorPlanSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Floor Plan")
                    .font(.system(size: 17, weight: .bold))
                Spacer()
                Button(action: {
                    // Expand action
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
            
            // Floor Plan Card
            VStack(spacing: 0) {
                // Floor info header
                HStack {
                    HStack(spacing: 8) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(navy)
                                .frame(width: 28, height: 28)
                            Text("2F")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        VStack(alignment: .leading, spacing: 1) {
                            Text("Second Floor")
                                .font(.system(size: 14, weight: .semibold))
                            Text("East Wing")
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 8, height: 8)
                        Text("Active")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.green)
                    }
                }
                .padding(16)
                
                // Map placeholder
                ZStack {
                    // Background gradient for 3D floor effect
                    LinearGradient(
                        colors: [navy.opacity(0.6), navy.opacity(0.85)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    
                    // Floor grid pattern
                    GeometryReader { geometry in
                        Path { path in
                            let spacing: CGFloat = 30
                            // Horizontal lines
                            for i in 0...Int(geometry.size.height / spacing) {
                                let y = CGFloat(i) * spacing
                                path.move(to: CGPoint(x: 0, y: y))
                                path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                            }
                            // Vertical lines
                            for i in 0...Int(geometry.size.width / spacing) {
                                let x = CGFloat(i) * spacing
                                path.move(to: CGPoint(x: x, y: 0))
                                path.addLine(to: CGPoint(x: x, y: geometry.size.height))
                            }
                        }
                        .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
                    }
                    
                    // Compass
                    VStack {
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 28, height: 28)
                                Text("N")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(navy)
                            }
                            .overlay(
                                // Red line pointing north
                                Rectangle()
                                    .fill(Color.red)
                                    .frame(width: 2, height: 12)
                                    .offset(x: 6, y: -8)
                                    .rotationEffect(.degrees(-45))
                            )
                            .padding(12)
                            
                            Spacer()
                        }
                        Spacer()
                    }
                    
                    // Current position marker
                    VStack {
                        Spacer()
                        HStack {
                            VStack(spacing: 4) {
                                ZStack {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 24, height: 24)
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 16, height: 16)
                                    Circle()
                                        .stroke(Color.blue.opacity(0.3), lineWidth: 8)
                                        .frame(width: 32, height: 32)
                                }
                                
                                Text("You are here")
                                    .font(.system(size: 10, weight: .medium))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(12)
                            }
                            .padding(.leading, 40)
                            
                            Spacer()
                            
                            // Destination marker
                            VStack(spacing: 4) {
                                ZStack {
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 24, height: 24)
                                    Image(systemName: "location.fill")
                                        .font(.system(size: 12))
                                        .foregroundColor(.white)
                                }
                                
                                Text("A-201")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(Color.red)
                                    .cornerRadius(12)
                            }
                            .padding(.trailing, 50)
                            .padding(.bottom, 20)
                        }
                        .padding(.bottom, 30)
                    }
                    
                    // Legend
                    VStack {
                        Spacer()
                        HStack {
                            HStack(spacing: 16) {
                                HStack(spacing: 6) {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 10, height: 10)
                                    Text("You")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.primary)
                                }
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 1, height: 16)
                                
                                HStack(spacing: 6) {
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 10, height: 10)
                                    Text("Goal")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.primary)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(12)
                            
                            Spacer()
                        }
                    }
                }
                .frame(height: 200)
                .cornerRadius(12)
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
            }
            .background(Color(.systemBackground))
            .cornerRadius(14)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
    }
    
    // MARK: - Directions Section
    var directionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Directions")
                .font(.system(size: 17, weight: .bold))
            
            VStack(spacing: 0) {
                ForEach(Array(directionSteps.enumerated()), id: \.element.id) { index, step in
                    HStack(spacing: 12) {
                        // Step indicator
                        ZStack {
                            Circle()
                                .fill(step.isArrival ? Color.green : navy)
                                .frame(width: 32, height: 32)
                            
                            if step.isArrival {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                            } else {
                                Text("\(step.stepNumber)")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(step.title)
                                .font(.system(size: 15, weight: step.isArrival ? .bold : .semibold))
                                .foregroundColor(step.isArrival ? .green : .primary)
                            Text(step.subtitle)
                                .font(.system(size: 13))
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Text(step.distance)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 12)
                    
                    if index < directionSteps.count - 1 {
                        HStack(spacing: 12) {
                            // Vertical line connecting steps
                            Rectangle()
                                .fill(Color(.systemGray4))
                                .frame(width: 2, height: 20)
                                .padding(.leading, 15)
                            Spacer()
                        }
                    }
                }
            }
            .padding(16)
            .background(Color(.systemBackground))
            .cornerRadius(14)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
    }
    
    // MARK: - Action Buttons Row
    var actionButtonsRow: some View {
        HStack(spacing: 12) {
            // Share Location
            Button(action: {
                // Share location action
            }) {
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(Color.teal.opacity(0.1))
                            .frame(width: 48, height: 48)
                        Image(systemName: "arrow.up")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.teal)
                    }
                    
                    VStack(spacing: 2) {
                        Text("Share Location")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.primary)
                        Text("Send to companion")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color(.systemBackground))
                .cornerRadius(14)
                .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
            }
            
            // AR View
            Button(action: {
                // AR View action
            }) {
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(Color.orange.opacity(0.1))
                            .frame(width: 48, height: 48)
                        Image(systemName: "eye.fill")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.orange)
                    }
                    
                    VStack(spacing: 2) {
                        Text("AR View")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.primary)
                        Text("Camera navigation")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color(.systemBackground))
                .cornerRadius(14)
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
                        .font(.system(size: 16, weight: .semibold))
                    Text("Mark as Arrived")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(navy)
                .cornerRadius(30)
                .shadow(color: .black.opacity(0.15), radius: 6, y: 3)
            }
            .padding(.horizontal, 16)
            
            // Voice Directions button
            Button(action: {
                // Voice directions action
            }) {
                HStack(spacing: 6) {
                    Image(systemName: "mic.fill")
                        .font(.system(size: 14))
                    Text("Voice Directions")
                        .font(.system(size: 15, weight: .medium))
                }
                .foregroundColor(navy)
            }
            .padding(.bottom, 8)
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
        RoomNavigationView()
    }
}
