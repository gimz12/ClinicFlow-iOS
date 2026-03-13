import SwiftUI

// MARK: - Appointment Details View
struct AppointmentDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showReschedule: Bool = false
    @State private var showNavigation: Bool = false
    @State private var shouldDismissToDashboard: Bool = false
    
    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)
    private let lightBlue = Color(red: 0.88, green: 0.93, blue: 0.97)
    
    var onDismissToDashboard: (() -> Void)? = nil
    
    // Appointment details
    let serviceName: String = "Follow-up Consultation"
    let appointmentDate: String = "Feb 28"
    let appointmentDay: String = "Thu"
    let appointmentTime: String = "10:30 AM - 11:00 AM"
    
    // Doctor info
    let doctorName: String = "Dr. Sarah Johnson"
    let doctorSpecialty: String = "Cardiologist"
    let doctorDepartment: String = "Cardiology Department"
    let doctorExperience: String = "15+ years experience"
    
    // Location
    let buildingName: String = "Main Hospital Building"
    let roomInfo: String = "Room C-205, 2nd Floor, Cardiology Wing"
    
    // Preparation items
    let preparationItems: [(String, Bool)] = [
        ("Bring previous medical records", true),
        ("List current medications", true),
        ("Arrive 15 minutes early", false),
        ("Bring insurance card", false)
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
                    VStack(alignment: .leading, spacing: 20) {
                        // Title Section
                        VStack(alignment: .leading, spacing: 4) {
                            Text(serviceName)
                                .font(.system(size: 28, weight: .bold))
                            Text("Appointment confirmation")
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 8)
                        
                        // Upcoming Appointment Card
                        upcomingAppointmentCard
                        
                        // Doctor Information
                        doctorInformationSection
                        
                        // Location
                        locationSection
                        
                        // Prepare for Visit
                        prepareForVisitSection
                        
                        // Cancellation Policy
                        cancellationPolicyCard
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
        .onChange(of: shouldDismissToDashboard) { _, newValue in
            if newValue {
                if let callback = onDismissToDashboard {
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
                dismiss()
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
            
            Text("Appointment Details")
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
    
    // MARK: - Upcoming Appointment Card
    var upcomingAppointmentCard: some View {
        HStack(spacing: 16) {
            // Date box
            VStack(spacing: 2) {
                Text("Feb")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.8))
                Text("28")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                Text(appointmentDay)
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.8))
            }
            .frame(width: 60, height: 70)
            .background(navy)
            .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("UPCOMING")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(navy)
                    .tracking(0.5)
                Text(serviceName)
                    .font(.system(size: 16, weight: .semibold))
                Text(appointmentTime)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(16)
        .background(lightBlue)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(navy.opacity(0.2), lineWidth: 1)
        )
    }
    
    // MARK: - Doctor Information Section
    var doctorInformationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("DOCTOR INFORMATION")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.5)
            
            VStack(spacing: 12) {
                // Doctor header
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(lightBlue)
                            .frame(width: 50, height: 50)
                        Image(systemName: "person.fill")
                            .font(.system(size: 22))
                            .foregroundColor(navy)
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(doctorName)
                            .font(.system(size: 16, weight: .semibold))
                        Text(doctorSpecialty)
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                
                Divider()
                
                // Doctor details
                HStack(spacing: 8) {
                    Image(systemName: "building.2")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                    Text(doctorDepartment)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                
                HStack(spacing: 8) {
                    Image(systemName: "clock")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                    Text(doctorExperience)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
            }
            .padding(16)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
    }
    
    // MARK: - Location Section
    var locationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("LOCATION")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.5)
            
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(lightBlue)
                        .frame(width: 44, height: 44)
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(navy)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(buildingName)
                        .font(.system(size: 15, weight: .semibold))
                    Text(roomInfo)
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                    
                    Button(action: {
                        showNavigation = true
                    }) {
                        HStack(spacing: 4) {
                            Text("Get Directions")
                                .font(.system(size: 14, weight: .semibold))
                            Image(systemName: "chevron.right")
                                .font(.system(size: 12, weight: .semibold))
                        }
                        .foregroundColor(navy)
                    }
                    .padding(.top, 4)
                    .navigationDestination(isPresented: $showNavigation) {
                        IndoorNavigationView(onNavigateToDashboard: {
                            showNavigation = false
                            shouldDismissToDashboard = true
                        })
                    }
                }
                
                Spacer()
            }
            .padding(16)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
    }
    
    // MARK: - Prepare for Visit Section
    var prepareForVisitSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("PREPARE FOR VISIT")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.5)
            
            VStack(spacing: 0) {
                ForEach(Array(preparationItems.enumerated()), id: \.offset) { index, item in
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(item.1 ? Color.green.opacity(0.1) : Color(.systemGray5))
                                .frame(width: 24, height: 24)
                            Image(systemName: item.1 ? "checkmark" : "circle")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(item.1 ? .green : .secondary)
                        }
                        
                        Text(item.0)
                            .font(.system(size: 15))
                            .foregroundColor(.primary)
                        
                        Spacer()
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    
                    if index < preparationItems.count - 1 {
                        Divider()
                            .padding(.leading, 52)
                    }
                }
            }
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
    }
    
    // MARK: - Cancellation Policy Card
    var cancellationPolicyCard: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 44, height: 44)
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Cancellation Policy")
                    .font(.system(size: 15, weight: .semibold))
                Text("Please cancel at least 24 hours in advance if you cannot attend.")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(16)
        .background(lightBlue.opacity(0.5))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(navy.opacity(0.15), lineWidth: 1)
        )
    }
    
    // MARK: - Bottom Buttons
    var bottomButtons: some View {
        VStack(spacing: 12) {
            // Reschedule Appointment button
            Button(action: {
                showReschedule = true
            }) {
                Text("Reschedule Appointment")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(navy)
                    .cornerRadius(30)
            }
            .padding(.horizontal, 16)
            .navigationDestination(isPresented: $showReschedule) {
                RescheduleAppointmentView(onDismissToDashboard: {
                    showReschedule = false
                    shouldDismissToDashboard = true
                })
            }
            
            // Cancel Appointment button
            Button(action: {
                shouldDismissToDashboard = true
            }) {
                Text("Cancel Appointment")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color(.systemBackground))
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
            }
            .padding(.horizontal, 16)
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
        AppointmentDetailsView()
    }
}
