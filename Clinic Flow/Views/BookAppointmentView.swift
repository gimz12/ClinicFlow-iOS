import SwiftUI

// MARK: - Book Appointment View
struct BookAppointmentView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showConfirmation: Bool = false
    @State private var shouldDismissToDashboard: Bool = false
    
    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)
    private let lightBlue = Color(red: 0.88, green: 0.93, blue: 0.97)
    
    // Form State
    @State private var selectedDepartment: String = ""
    @State private var selectedDoctor: String = ""
    @State private var selectedDate: Date = Date()
    @State private var selectedTimeSlot: String = ""
    @State private var reasonForVisit: String = ""
    
    @State private var showDepartmentPicker: Bool = false
    @State private var showDoctorPicker: Bool = false
    @State private var showDatePicker: Bool = false
    
    let departments = ["General Medicine", "Cardiology", "Orthopedics", "Dermatology", "Pediatrics", "Neurology"]
    let doctors = ["Dr. Smith", "Dr. Sarah Johnson", "Dr. Williams", "Dr. Brown", "Dr. Davis"]
    let timeSlots = ["08:00 AM", "09:00 AM", "10:00 AM", "11:00 AM", "02:00 PM", "03:00 PM"]
    
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
                            Text("New Appointment")
                                .font(.system(size: 28, weight: .bold))
                            Text("Schedule your next visit")
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 8)
                        
                        // Form Fields
                        VStack(spacing: 20) {
                            departmentField
                            doctorField
                            dateField
                            timeSlotSection
                            reasonField
                        }
                        
                        // Help text
                        Text("This helps the doctor prepare for your visit")
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                            .padding(.top, 4)
                        
                        // Appointment Summary Card
                        if showSummary {
                            appointmentSummaryCard
                        }
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
            
            Text("Book Appointment")
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
    
    // MARK: - Department Field
    var departmentField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("DEPARTMENT")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.5)
            
            Button(action: {
                showDepartmentPicker.toggle()
            }) {
                HStack {
                    Text(selectedDepartment.isEmpty ? "Select Department" : selectedDepartment)
                        .font(.system(size: 16))
                        .foregroundColor(selectedDepartment.isEmpty ? .secondary : .primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 14))
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
            
            if showDepartmentPicker {
                VStack(spacing: 0) {
                    ForEach(departments, id: \.self) { dept in
                        Button(action: {
                            selectedDepartment = dept
                            showDepartmentPicker = false
                        }) {
                            HStack {
                                Text(dept)
                                    .font(.system(size: 15))
                                    .foregroundColor(.primary)
                                Spacer()
                                if selectedDepartment == dept {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(navy)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                        }
                        if dept != departments.last {
                            Divider().padding(.leading, 16)
                        }
                    }
                }
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
            }
        }
    }
    
    // MARK: - Doctor Field
    var doctorField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("PREFERRED DOCTOR")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.5)
            
            Button(action: {
                showDoctorPicker.toggle()
            }) {
                HStack {
                    Text(selectedDoctor.isEmpty ? "Select Doctor" : selectedDoctor)
                        .font(.system(size: 16))
                        .foregroundColor(selectedDoctor.isEmpty ? .secondary : .primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 14))
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
            
            if showDoctorPicker {
                VStack(spacing: 0) {
                    ForEach(doctors, id: \.self) { doctor in
                        Button(action: {
                            selectedDoctor = doctor
                            showDoctorPicker = false
                        }) {
                            HStack {
                                Text(doctor)
                                    .font(.system(size: 15))
                                    .foregroundColor(.primary)
                                Spacer()
                                if selectedDoctor == doctor {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(navy)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                        }
                        if doctor != doctors.last {
                            Divider().padding(.leading, 16)
                        }
                    }
                }
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
            }
        }
    }
    
    // MARK: - Date Field
    var dateField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("PREFERRED DATE")
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
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter.string(from: selectedDate)
    }
    
    // MARK: - Time Slot Section
    var timeSlotSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("TIME SLOT")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.5)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                ForEach(timeSlots, id: \.self) { slot in
                    Button(action: {
                        selectedTimeSlot = slot
                    }) {
                        Text(slot)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(selectedTimeSlot == slot ? .white : .primary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(selectedTimeSlot == slot ? navy : Color(.systemBackground))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(selectedTimeSlot == slot ? navy : Color(.systemGray4), lineWidth: 1)
                            )
                    }
                }
            }
        }
    }
    
    // MARK: - Reason Field
    var reasonField: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("REASON FOR VISIT")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.secondary)
                    .tracking(0.5)
                Text("(Optional)")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $reasonForVisit)
                    .font(.system(size: 16))
                    .frame(minHeight: 100)
                    .padding(12)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                
                if reasonForVisit.isEmpty {
                    Text("Describe your symptoms or reason for visit")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary.opacity(0.6))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 20)
                        .allowsHitTesting(false)
                }
            }
        }
    }
    
    // MARK: - Show Summary Check
    var showSummary: Bool {
        !selectedDepartment.isEmpty && !selectedDoctor.isEmpty && !selectedTimeSlot.isEmpty
    }
    
    var formattedSummaryDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: selectedDate)
    }
    
    // MARK: - Appointment Summary Card
    var appointmentSummaryCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("APPOINTMENT SUMMARY")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(navy)
                .tracking(0.5)
            
            VStack(spacing: 10) {
                summaryRow(label: "Department:", value: selectedDepartment)
                summaryRow(label: "Doctor:", value: selectedDoctor.replacingOccurrences(of: "Dr. ", with: "dr-").lowercased())
                summaryRow(label: "Date:", value: formattedSummaryDate)
                summaryRow(label: "Time:", value: selectedTimeSlot)
            }
        }
        .padding(16)
        .background(lightBlue.opacity(0.5))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(navy.opacity(0.2), lineWidth: 1)
        )
    }
    
    func summaryRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(navy)
        }
    }
    
    // MARK: - Bottom Buttons
    var bottomButtons: some View {
        VStack(spacing: 12) {
            // Confirm Appointment button
            Button(action: {
                showConfirmation = true
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
            .navigationDestination(isPresented: $showConfirmation) {
                AppointmentConfirmationView(
                    department: selectedDepartment,
                    doctor: selectedDoctor,
                    date: selectedDate,
                    timeSlot: selectedTimeSlot,
                    reason: reasonForVisit,
                    onDismissToDashboard: {
                        showConfirmation = false
                        shouldDismissToDashboard = true
                    }
                )
            }
            
            // Cancel button
            Button(action: {
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
        BookAppointmentView()
    }
}
