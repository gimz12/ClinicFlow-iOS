import SwiftUI

// MARK: - Models

struct ChecklistItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    var isChecked: Bool
}

// MARK: - QueueStatusView

struct QueueStatusView: View {
    @Binding var isPresented: Bool
    
    @State private var checklistItems: [ChecklistItem] = [
        ChecklistItem(title: "Medical History", subtitle: "Have your medical records accessible", isChecked: true),
        ChecklistItem(title: "Symptoms List", subtitle: "Clearly list all current symptoms", isChecked: true),
        ChecklistItem(title: "Previous Prescriptions", subtitle: "Bring existing medication details", isChecked: false),
        ChecklistItem(title: "Questions Ready", subtitle: "Prepare questions for your doctor", isChecked: false)
    ]
    
    private let primaryColor = Color(red: 0.13, green: 0.27, blue: 0.40)
    private let lightBlueBackground = Color(red: 0.93, green: 0.96, blue: 0.98)
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom Navigation Bar
            navigationBar
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    queueNumberCard
                    queueInformationSection
                    currentStatusSection
                    preparationChecklistSection
                    notificationBanner
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 120)
            }
            
            // Bottom Action Buttons
            bottomActionButtons
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarHidden(true)
    }
    
    // MARK: - Navigation Bar
    var navigationBar: some View {
        HStack {
            Button {
                isPresented = false
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                    Text("Back")
                        .font(.system(size: 17))
                }
                .foregroundColor(.primary)
            }
            
            Spacer()
            
            Text("Queue Status")
                .font(.system(size: 17, weight: .semibold))
            
            Spacer()
            
            Button {
                // More options
            } label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 18))
                    .foregroundColor(.primary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }
    
    // MARK: - Queue Number Card
    var queueNumberCard: some View {
        VStack(spacing: 16) {
            Text("YOUR QUEUE NUMBER")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(primaryColor)
                .tracking(1)
            
            // Large Queue Number
            Text("C18")
                .font(.system(size: 72, weight: .bold))
                .foregroundColor(primaryColor)
                .padding(.vertical, 20)
                .padding(.horizontal, 40)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
            
            // Consultation Info
            VStack(spacing: 8) {
                Text("General Consultation")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)
                
                HStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Image(systemName: "person")
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                        Text("Dr. Smith")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "door.left.hand.open")
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                        Text("Room A-201")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            // Get Directions Button
            Button {
                // Handle get directions
            } label: {
                Text("Get Directions")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(primaryColor)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(lightBlueBackground)
                    .cornerRadius(12)
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
    
    // MARK: - Queue Information Section
    var queueInformationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Queue Information")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.primary)
            
            HStack(spacing: 12) {
                // People Ahead Card
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 6) {
                        Image(systemName: "person.2.fill")
                            .font(.system(size: 14))
                            .foregroundColor(primaryColor)
                        Text("PEOPLE AHEAD")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(.secondary)
                            .tracking(0.5)
                    }
                    
                    Text("3")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text("~15 min per patient")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemBackground))
                .cornerRadius(14)
                .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
                
                // Wait Time Card
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 6) {
                        Image(systemName: "clock.fill")
                            .font(.system(size: 14))
                            .foregroundColor(primaryColor)
                        Text("WAIT TIME")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(.secondary)
                            .tracking(0.5)
                    }
                    
                    Text("45m")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text("Updated 1 min ago")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemBackground))
                .cornerRadius(14)
                .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
            }
        }
    }
    
    // MARK: - Current Status Section
    var currentStatusSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Current Status")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.primary)
            
            VStack(spacing: 0) {
                // Now Serving
                statusRow(
                    icon: "checkmark.circle.fill",
                    iconColor: .green,
                    iconBackground: Color.green.opacity(0.1),
                    title: "Now Serving",
                    subtitle: "Active consultation",
                    queueNumber: "C15",
                    showDivider: true
                )
                
                // Next in Line
                statusRow(
                    icon: "arrow.up.circle.fill",
                    iconColor: primaryColor,
                    iconBackground: lightBlueBackground,
                    title: "Next in Line",
                    subtitle: "Please be ready",
                    queueNumber: "C16",
                    showDivider: true
                )
                
                // Your Position
                statusRow(
                    icon: "person.circle.fill",
                    iconColor: primaryColor,
                    iconBackground: lightBlueBackground,
                    title: "Your Position",
                    subtitle: "4th in queue",
                    queueNumber: "C18",
                    showDivider: false
                )
            }
            .background(Color(.systemBackground))
            .cornerRadius(14)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
    }
    
    func statusRow(icon: String, iconColor: Color, iconBackground: Color, title: String, subtitle: String, queueNumber: String, showDivider: Bool) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(iconBackground)
                        .frame(width: 40, height: 40)
                    Image(systemName: icon)
                        .font(.system(size: 18))
                        .foregroundColor(iconColor)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                    Text(subtitle)
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(queueNumber)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(primaryColor)
            }
            .padding(16)
            
            if showDivider {
                Divider()
                    .padding(.leading, 70)
            }
        }
    }
    
    // MARK: - Preparation Checklist Section
    var preparationChecklistSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Preparation Checklist")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.primary)
            
            VStack(spacing: 0) {
                ForEach(Array(checklistItems.enumerated()), id: \.element.id) { index, item in
                    VStack(spacing: 0) {
                        HStack(spacing: 14) {
                            Button {
                                checklistItems[index].isChecked.toggle()
                            } label: {
                                ZStack {
                                    if item.isChecked {
                                        Circle()
                                            .fill(primaryColor)
                                            .frame(width: 24, height: 24)
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.white)
                                    } else {
                                        Circle()
                                            .stroke(Color(.systemGray3), lineWidth: 2)
                                            .frame(width: 24, height: 24)
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(item.title)
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.primary)
                                Text(item.subtitle)
                                    .font(.system(size: 13))
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                        }
                        .padding(16)
                        
                        if index < checklistItems.count - 1 {
                            Divider()
                                .padding(.leading, 54)
                        }
                    }
                }
            }
            .background(Color(.systemBackground))
            .cornerRadius(14)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
    }
    
    // MARK: - Notification Banner
    var notificationBanner: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(lightBlueBackground)
                        .frame(width: 44, height: 44)
                    Image(systemName: "bell.fill")
                        .font(.system(size: 18))
                        .foregroundColor(primaryColor)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Turn notifications on")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                    Text("We'll alert you when it's almost your turn")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            
            Button {
                // Handle enable notifications
            } label: {
                Text("Enable Notifications")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(primaryColor)
                    .cornerRadius(12)
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
    
    // MARK: - Bottom Action Buttons
    var bottomActionButtons: some View {
        VStack(spacing: 12) {
            // Navigate to Room Button
            Button {
                // Handle navigation
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 16, weight: .semibold))
                    Text("Navigate to Room A-201")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(primaryColor)
                .cornerRadius(14)
            }
            
            // Cancel Queue and Skip to Next
            HStack(spacing: 12) {
                Button {
                    isPresented = false
                } label: {
                    Text("Cancel Queue")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                }
                
                Button {
                    // Handle skip to next
                } label: {
                    Text("Skip to Next")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                }
            }
            
            // Current Screen Label
            Text("Current Screen: Consultation")
                .font(.system(size: 13))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(Color(.systemBackground))
    }
}

#Preview {
    QueueStatusView(isPresented: .constant(true))
}
