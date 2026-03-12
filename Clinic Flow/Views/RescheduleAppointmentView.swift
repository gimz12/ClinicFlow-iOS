import SwiftUI

// MARK: - Reschedule Appointment View
struct RescheduleAppointmentView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedDate: Date = Date()
    @State private var selectedTimeSlot: String = ""
    @State private var rescheduleReason: String = ""
    @State private var showDatePicker: Bool = false
    
    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)
    private let lightBlue = Color(red: 0.88, green: 0.93, blue: 0.97)
    
    var onDismissToDashboard: (() -> Void)? = nil
    
    // Current appointment details
    let currentDate: String = "Feb 28"
    let currentService: String = "Follow-up Consultation"
    let currentDoctor: String = "Dr. Sarah Johnson"
    let currentTime: String = "10:30 AM - 11:00 AM"
    
    // Available time slots
    let timeSlots: [(String, Bool)] = [
        ("08:00 AM", true),
        ("09:00 AM", true),
        ("10:00 AM", false),
        ("10:30 AM", true),
        ("11:00 AM", true),
        ("02:00 PM", true),
        ("03:00 PM", false),
        ("04:00 PM", true)
    ]
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter.string(from: selectedDate)
    }
    
    var canConfirm: Bool {
        !selectedTimeSlot.isEmpty
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
                    VStack(alignment: .leading, spacing: 20) {
                        // Title Section
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Reschedule Appointment")
                                .font(.system(size: 28, weight: .bold))
                            Text("Choose a new date and time")
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 8)
                        
                        // Current Appointment Card
                        currentAppointmentCard
                        
                        // New Date Field
                        newDateField
                        
                        // Available Time Slots
                        timeSlotsSection
                        
                        // Reason for Rescheduling
                        reasonField
                        
                        // Rescheduling Notice
                        reschedulingNotice
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 180)
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
            
            Text("Reschedule")
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
    
    // MARK: - Current Appointment Card
    var currentAppointmentCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("CURRENT APPOINTMENT")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.5)
            
            HStack(spacing: 16) {
                // Date box
                VStack(spacing: 2) {
                    Text("Feb")
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                    Text("28")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(navy)
                }
                .frame(width: 50, height: 50)
                .background(lightBlue)
                .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(currentService)
                        .font(.system(size: 15, weight: .semibold))
                    Text(currentDoctor)
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                    Text(currentTime)
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
    
    // MARK: - New Date Field
    var newDateField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("NEW DATE")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.5)
            
            Button(action: {
                showDatePicker.toggle()
            }) {
                HStack {
                    Text(formattedDate)
                        .font(.system(size: 16))
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "calendar")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                }
                .padding(16)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
            }
            
            if showDatePicker {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    in: Date()...,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
                .onChange(of: selectedDate) { _, _ in
                    showDatePicker = false
                }
            }
        }
    }
    
    // MARK: - Time Slots Section
    var timeSlotsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("AVAILABLE TIME SLOTS")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.5)
            
            VStack(spacing: 0) {
                ForEach(Array(timeSlots.enumerated()), id: \.offset) { index, slot in
                    Button(action: {
                        if slot.1 {
                            selectedTimeSlot = slot.0
                        }
                    }) {
                        HStack {
                            Text(slot.0)
                                .font(.system(size: 16, weight: selectedTimeSlot == slot.0 ? .semibold : .regular))
                                .foregroundColor(slot.1 ? (selectedTimeSlot == slot.0 ? navy : .primary) : navy.opacity(0.4))
                            
                            Spacer()
                            
                            if !slot.1 {
                                Text("Not Available")
                                    .font(.system(size: 14))
                                    .foregroundColor(.secondary)
                            } else if selectedTimeSlot == slot.0 {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(navy)
                            }
                        }
                        .padding(.vertical, 14)
                        .padding(.horizontal, 16)
                        .background(selectedTimeSlot == slot.0 ? lightBlue : Color(.systemBackground))
                    }
                    .disabled(!slot.1)
                    
                    if index < timeSlots.count - 1 {
                        Divider()
                            .padding(.leading, 16)
                    }
                }
            }
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(.systemGray5), lineWidth: 1)
            )
        }
    }
    
    // MARK: - Reason Field
    var reasonField: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("REASON FOR RESCHEDULING")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.secondary)
                    .tracking(0.5)
                Text("(Optional)")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $rescheduleReason)
                    .font(.system(size: 16))
                    .frame(minHeight: 80)
                    .padding(12)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                
                if rescheduleReason.isEmpty {
                    Text("Let us know why you need to reschedule")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary.opacity(0.6))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 20)
                        .allowsHitTesting(false)
                }
            }
        }
    }
    
    // MARK: - Rescheduling Notice
    var reschedulingNotice: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 40, height: 40)
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 18))
                    .foregroundColor(.blue)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Rescheduling Notice")
                    .font(.system(size: 14, weight: .semibold))
                Text("A confirmation will be sent to your registered email and phone number.")
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
            // Confirm Reschedule button
            Button(action: {
                if let callback = onDismissToDashboard {
                    callback()
                }
                dismiss()
            }) {
                Text("Confirm Reschedule")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(canConfirm ? navy : navy.opacity(0.5))
                    .cornerRadius(30)
            }
            .disabled(!canConfirm)
            .padding(.horizontal, 16)
            
            // Cancel button
            Button(action: {
                if let callback = onDismissToDashboard {
                    callback()
                }
                dismiss()
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
        RescheduleAppointmentView()
    }
}
