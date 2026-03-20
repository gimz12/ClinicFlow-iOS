import SwiftUI

// MARK: - Models
struct ChecklistItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    var isChecked: Bool
}

struct QueueStatusItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let queueNumber: String
    let icon: String
    let iconColor: Color
    let iconBgColor: Color
}

// MARK: - Queue Status View
struct QueueStatusView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showNavigation: Bool = false
    @State private var shouldDismissToDashboard: Bool = false

    var onNavigateToDashboard: (() -> Void)? = nil
    
    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)
    private let lightBlue = Color(red: 0.88, green: 0.93, blue: 0.97)
    
    @State private var checklistItems: [ChecklistItem] = [
        ChecklistItem(title: "Medical History", subtitle: "Have your medical records accessible", isChecked: true),
        ChecklistItem(title: "Symptoms List", subtitle: "Clearly list all current symptoms", isChecked: true),
        ChecklistItem(title: "Previous Prescriptions", subtitle: "Bring any existing medication details", isChecked: false),
        ChecklistItem(title: "Questions Ready", subtitle: "Prepare questions for your doctor", isChecked: false)
    ]
    
    let statusItems: [QueueStatusItem] = [
        QueueStatusItem(title: "Now Serving", subtitle: "Active consultation", queueNumber: "C15",
                        icon: "checkmark.circle.fill", iconColor: .green, iconBgColor: Color.green.opacity(0.1)),
        QueueStatusItem(title: "Next in Line", subtitle: "Please be ready", queueNumber: "C16",
                        icon: "arrow.up.circle.fill", iconColor: .blue, iconBgColor: Color.blue.opacity(0.1)),
        QueueStatusItem(title: "Your Position", subtitle: "4th in queue", queueNumber: "C18",
                        icon: "person.fill", iconColor: Color(red: 0.13, green: 0.27, blue: 0.40), iconBgColor: Color(red: 0.88, green: 0.93, blue: 0.97))
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
                        queueNumberCard
                        queueInformationSection
                        currentStatusSection
                        preparationChecklistSection
                        notificationCard
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
        .navigationDestination(isPresented: $showNavigation) {
            RoomNavigationView(onNavigateToDashboard: {
                showNavigation = false
                shouldDismissToDashboard = true
            })
        }
        .onChange(of: shouldDismissToDashboard) { _, newValue in
            if newValue {
                if let callback = onNavigateToDashboard {
                    callback()
                } else {
                    dismiss()
                }
            }
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
            
            Text("Queue Status")
                .font(.system(size: 17, weight: .semibold))
            
            Spacer()
            
            // Placeholder for alignment
            Button(action: {}) {
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
                .foregroundColor(navy)
                .tracking(0.5)
            
            // Queue Number Box
            Text("C18")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(navy)
                .frame(width: 120, height: 100)
                .background(lightBlue)
                .cornerRadius(16)
            
            VStack(spacing: 6) {
                Text("General Consultation")
                    .font(.system(size: 18, weight: .semibold))
                
                HStack(spacing: 8) {
                    HStack(spacing: 4) {
                        Image(systemName: "person.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                        Text("Dr. Smith")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                    
                    Text("•")
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                        Text("Room A-201")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Button(action: {
                showNavigation = true
            }) {
                Text("Get Directions")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(navy)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(lightBlue)
                    .cornerRadius(25)
            }
            .padding(.horizontal, 20)
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
            
            HStack(spacing: 16) {
                // People Ahead
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(lightBlue)
                            .frame(width: 44, height: 44)
                        Image(systemName: "person.2.fill")
                            .foregroundColor(navy)
                            .font(.system(size: 18))
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("PEOPLE AHEAD")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.secondary)
                            .tracking(0.3)
                        Text("3")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.primary)
                        Text("~15 min per patient")
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Wait Time
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(lightBlue)
                            .frame(width: 44, height: 44)
                        Image(systemName: "clock.fill")
                            .foregroundColor(navy)
                            .font(.system(size: 18))
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("WAIT TIME")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.secondary)
                            .tracking(0.3)
                        Text("45m")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.primary)
                        Text("Updated 1 min ago")
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
    
    // MARK: - Current Status Section
    var currentStatusSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Current Status")
                .font(.system(size: 17, weight: .bold))
            
            VStack(spacing: 0) {
                ForEach(Array(statusItems.enumerated()), id: \.element.id) { index, item in
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(item.iconBgColor)
                                .frame(width: 40, height: 40)
                            Image(systemName: item.icon)
                                .foregroundColor(item.iconColor)
                                .font(.system(size: 18))
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(item.title)
                                .font(.system(size: 15, weight: .semibold))
                            Text(item.subtitle)
                                .font(.system(size: 13))
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Text(item.queueNumber)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(navy)
                    }
                    .padding(.vertical, 12)
                    
                    if index < statusItems.count - 1 {
                        Divider()
                    }
                }
            }
            .padding(16)
            .background(Color(.systemBackground))
            .cornerRadius(14)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
    }
    
    // MARK: - Preparation Checklist Section
    var preparationChecklistSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Preparation Checklist")
                .font(.system(size: 17, weight: .bold))
            
            VStack(spacing: 0) {
                ForEach(Array(checklistItems.enumerated()), id: \.element.id) { index, item in
                    HStack(spacing: 12) {
                        // Checkbox
                        Button(action: {
                            checklistItems[index].isChecked.toggle()
                        }) {
                            ZStack {
                                Circle()
                                    .fill(item.isChecked ? Color.green : Color(.systemGray5))
                                    .frame(width: 24, height: 24)
                                
                                if item.isChecked {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.white)
                                } else {
                                    Circle()
                                        .fill(navy.opacity(0.3))
                                        .frame(width: 8, height: 8)
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(item.title)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(item.isChecked ? .primary : .secondary)
                            Text(item.subtitle)
                                .font(.system(size: 13))
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    
                    if index < checklistItems.count - 1 {
                        Divider().padding(.leading, 36)
                    }
                }
            }
            .padding(16)
            .background(Color(.systemBackground))
            .cornerRadius(14)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
    }
    
    // MARK: - Notification Card
    var notificationCard: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 44, height: 44)
                Image(systemName: "bell.fill")
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Turn notifications on")
                    .font(.system(size: 15, weight: .semibold))
                Text("We'll alert you when it's almost your turn")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                
                Button(action: {
                    // Enable notifications
                }) {
                    Text("Enable Notifications")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .cornerRadius(20)
                }
                .padding(.top, 4)
            }
            
            Spacer()
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
    
 
    // MARK: - Bottom Buttons
var bottomButtons: some View {
    VStack(spacing: 14) {

        // Navigate button
        Button(action: {
            showNavigation = true
        }) {
            HStack(spacing: 8) {
                Image(systemName: "arrow.right")
                    .font(.system(size: 16, weight: .semibold))

                Text("Navigate to Room A-201")
                    .font(.system(size: 16, weight: .semibold))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(navy)
            .cornerRadius(30)
            .shadow(color: .black.opacity(0.15), radius: 6, y: 3) // shadow like design
        }
        .padding(.horizontal, 16)

        // Cancel + Skip
        HStack(spacing: 16) {

            // Cancel Queue (Outlined Button)
            Button(action: {
                if let callback = onNavigateToDashboard {
                    callback()
                } else {
                    dismiss()
                }
            }) {
                Text("Cancel Queue")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color(.systemGray6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .cornerRadius(14)
            }

            // Skip to Next
            Button(action: {
                // Skip action
            }) {
                Text("Skip to Next")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color(.systemGray6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .cornerRadius(14)
            }
        }
        .padding(.horizontal, 16)
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
        QueueStatusView()
    }
}
