import SwiftUI

struct StartNewVisitView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var selectedDepartment: String = "General Medicine"
    @State private var checkInMethod: String = "QR"
    @State private var kioskCode: String = ""

    private let navy = Color(red: 0.10, green: 0.30, blue: 0.42)
    private let departments = [
        "General Medicine",
        "Cardiology",
        "Pediatrics",
        "Orthopedics",
        "Dermatology"
    ]

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        statusCard
                        departmentCard
                        methodCard
                        instructionsCard
                    }
                    .padding(16)
                }

                Button(action: completeCheckIn) {
                    Text("Complete Check-in")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(navy)
                        .cornerRadius(14)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 18)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    private var header: some View {
        HStack {
            Button(action: { dismiss() }) {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(navy)
            }

            Spacer()

            Text("Start New Visit")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)

            Spacer()

            Text(" ")
                .frame(width: 42)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private var statusCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Check-in Status")
                .font(.system(size: 16, weight: .semibold))
            Text("You are about to check in for today's visit. Confirm your department and method.")
                .font(.system(size: 13))
                .foregroundColor(.secondary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var departmentCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Department")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)

            ForEach(departments, id: \.self) { department in
                Button(action: { selectedDepartment = department }) {
                    HStack {
                        Text(department)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.primary)
                        Spacer()
                        if selectedDepartment == department {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(navy)
                        }
                    }
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var methodCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Check-in Method")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)

            Picker("Method", selection: $checkInMethod) {
                Text("QR Code").tag("QR")
                Text("Front Desk").tag("Desk")
                Text("Kiosk").tag("Kiosk")
            }
            .pickerStyle(.segmented)

            if checkInMethod == "QR" {
                VStack(spacing: 10) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray5))
                        .frame(height: 140)
                        .overlay(
                            Image(systemName: "qrcode")
                                .font(.system(size: 36, weight: .semibold))
                                .foregroundColor(navy)
                        )
                    Text("Show this QR code at the reception to confirm your visit.")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
            } else if checkInMethod == "Kiosk" {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Enter kiosk code")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.secondary)
                    TextField("Kiosk code", text: $kioskCode)
                        .keyboardType(.numberPad)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
            } else {
                Text("Proceed to the front desk to check in with your patient ID.")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var instructionsCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("What happens next")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)

            instructionRow("You'll receive a queue number and wait estimate.")
            instructionRow("Navigate to your department using the Navigate tab.")
            instructionRow("We'll notify you when it's time to proceed.")
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private func instructionRow(_ text: String) -> some View {
        HStack(spacing: 8) {
            Circle()
                .fill(navy)
                .frame(width: 6, height: 6)
            Text(text)
                .font(.system(size: 13))
                .foregroundColor(.secondary)
        }
    }

    private func completeCheckIn() {
        dismiss()
    }
}

#Preview {
    StartNewVisitView()
}
