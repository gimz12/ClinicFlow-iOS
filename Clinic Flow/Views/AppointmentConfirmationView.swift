import SwiftUI

// MARK: - Appointment Confirmation View
struct AppointmentConfirmationView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showFinalConfirmation: Bool = false
    @State private var shouldDismissToDashboard: Bool = false
    
    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)
    private let lightBlue = Color(red: 0.88, green: 0.93, blue: 0.97)
    
    // Appointment Details
    let department: String
    let doctor: String
    let date: Date
    let timeSlot: String
    let reason: String
    var onDismissToDashboard: (() -> Void)? = nil
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter.string(from: date)
    }
    
    var formattedShortDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                headerView
                
                // Content
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        // Title Section
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Confirm Appointment")
                                .font(.system(size: 28, weight: .bold))
                            Text("Review your appointment details")
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 8)
                        
                        // Appointment Details Card
                        appointmentDetailsCard
                        
                        // Information cards
                        infoSection
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 200)
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
                onDismissToDashboard?()
                dismiss()
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
            
            Text("Confirm Booking")
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
    
    // MARK: - Appointment Details Card
    var appointmentDetailsCard: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("APPOINTMENT DETAILS")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(navy)
                    .tracking(0.5)
                Spacer()
                Image(systemName: "calendar.badge.checkmark")
                    .foregroundColor(navy)
            }
            .padding(16)
            .background(lightBlue)
            
            // Details
            VStack(spacing: 16) {
                detailRow(icon: "building.2.fill", label: "Department", value: department)
                Divider()
                detailRow(icon: "person.fill", label: "Doctor", value: doctor)
                Divider()
                detailRow(icon: "calendar", label: "Date", value: formattedShortDate)
                Divider()
                detailRow(icon: "clock.fill", label: "Time", value: timeSlot)
                
                if !reason.isEmpty {
                    Divider()
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 8) {
                            Image(systemName: "text.alignleft")
                                .font(.system(size: 16))
                                .foregroundColor(navy)
                                .frame(width: 24)
                            Text("Reason")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                        }
                        Text(reason)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.primary)
                            .padding(.leading, 32)
                    }
                }
            }
            .padding(16)
            .background(Color(.systemBackground))
        }
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
    
    func detailRow(icon: String, label: String, value: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(navy)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
    }
    
    // MARK: - Info Section
    var infoSection: some View {
        VStack(spacing: 12) {
            // Reminder card
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.orange.opacity(0.1))
                        .frame(width: 40, height: 40)
                    Image(systemName: "bell.fill")
                        .foregroundColor(.orange)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Reminder")
                        .font(.system(size: 14, weight: .semibold))
                    Text("You'll receive a reminder 1 hour before your appointment")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(16)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
            
            // Cancellation policy card
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.1))
                        .frame(width: 40, height: 40)
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.blue)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Cancellation Policy")
                        .font(.system(size: 14, weight: .semibold))
                    Text("Free cancellation up to 24 hours before appointment")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(16)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
    }
    
    // MARK: - Bottom Buttons
    var bottomButtons: some View {
        VStack(spacing: 12) {
            // Confirm Appointment button
            Button(action: {
                showFinalConfirmation = true
            }) {
                Text("Confirm Appointment")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(navy)
                    .cornerRadius(30)
                    .shadow(color: .black.opacity(0.15), radius: 6, y: 3)
            }
            .padding(.horizontal, 16)
            .navigationDestination(isPresented: $showFinalConfirmation) {
                PaymentView(
                    service: "Follow-up Consultation",
                    doctor: doctor,
                    dateTime: "\(formattedShortDate), \(timeSlot)",
                    onDismissToDashboard: {
                        showFinalConfirmation = false
                        shouldDismissToDashboard = true
                    }
                )
            }
            
            // Cancel button
            Button(action: {
                // Dismiss all the way to dashboard
                shouldDismissToDashboard = true
            }) {
                Text("Cancel")
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
            
            // Contact reception
            HStack(spacing: 4) {
                Text("Need assistance?")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                Button("Contact reception") {
                    // Contact action
                }
                .font(.system(size: 13, weight: .semibold))
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
        AppointmentConfirmationView(
            department: "Orthopedics",
            doctor: "Dr. Williams",
            date: Date(),
            timeSlot: "09:00 AM",
            reason: "Follow-up checkup"
        )
    }
}
