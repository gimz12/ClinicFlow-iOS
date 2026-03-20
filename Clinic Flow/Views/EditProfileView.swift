import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var fullName: String = "John Patient"
    @State private var email: String = "john.patient@example.com"
    @State private var phone: String = "+1 (555) 123-4567"
    @State private var patientId: String = "#P-12345"
    @State private var emergencyName: String = "Jane Patient"
    @State private var emergencyPhone: String = "+1 (555) 555-0100"
    @State private var insuranceProvider: String = "BlueShield"
    @State private var insuranceMemberId: String = "BS-009833"

    private let navy = Color(red: 0.10, green: 0.30, blue: 0.42)

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        sectionCard(title: "Personal Information") {
                            inputRow(label: "Full Name", text: $fullName)
                            inputRow(label: "Patient ID", text: $patientId)
                        }

                        sectionCard(title: "Contact") {
                            inputRow(label: "Email", text: $email, keyboard: .emailAddress)
                            inputRow(label: "Phone", text: $phone, keyboard: .phonePad)
                        }

                        sectionCard(title: "Emergency Contact") {
                            inputRow(label: "Name", text: $emergencyName)
                            inputRow(label: "Phone", text: $emergencyPhone, keyboard: .phonePad)
                        }

                        sectionCard(title: "Insurance") {
                            inputRow(label: "Provider", text: $insuranceProvider)
                            inputRow(label: "Member ID", text: $insuranceMemberId)
                        }
                    }
                    .padding(16)
                }

                Button(action: saveChanges) {
                    Text("Save Changes")
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

            Text("Edit Profile")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)

            Spacer()

            Button("Done") {
                saveChanges()
            }
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(navy)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private func sectionCard<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title.uppercased())
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.6)

            VStack(spacing: 12) {
                content()
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

    private func inputRow(label: String, text: Binding<String>, keyboard: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)

            TextField(label, text: text)
                .keyboardType(keyboard)
                .textInputAutocapitalization(.words)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(10)
        }
    }

    private func saveChanges() {
        dismiss()
    }
}

#Preview {
    EditProfileView()
}
