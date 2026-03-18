import SwiftUI

struct SignUpView: View {
    let onCreateAccount: (String) -> Void
    let onSignIn: () -> Void

    @State private var fullName = ""
    @State private var patientID = ""
    @State private var phoneNumber = ""
    @State private var emailAddress = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Create Account")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primary)

                    Text("Register as a new patient")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                }
                .padding(.top, 32)
                .padding(.bottom, 32)

                AuthInputSection(title: "FULL NAME") {
                    TextField("Enter your full name", text: $fullName)
                        .textInputAutocapitalization(.words)
                }

                AuthInputSection(title: "PATIENT ID / REGISTRATION NUMBER") {
                    TextField("Provided by clinic", text: $patientID)
                        .textInputAutocapitalization(.characters)
                }

                AuthInputSection(title: "PHONE NUMBER") {
                    TextField("+1 (555) 000-0000", text: $phoneNumber)
                        .keyboardType(.phonePad)
                }

                AuthInputSection(title: "EMAIL ADDRESS") {
                    TextField("your.email@example.com", text: $emailAddress)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                }

                Text("I agree to the Terms of Service and Privacy Policy")
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
                    .padding(.bottom, 28)
                    .frame(maxWidth: .infinity, alignment: .center)

                Button {
                    onCreateAccount(phoneNumber)
                } label: {
                    Text("Create Account")
                }
                .authPrimaryButton()
                .disabled(!isFormValid)
                .opacity(isFormValid ? 1 : 0.55)
                .padding(.bottom, 20)

                HStack(spacing: 4) {
                    Spacer()
                    Text("Already have an account?")
                        .foregroundColor(.secondary)
                    Button("Sign In") {
                        onSignIn()
                    }
                    .fontWeight(.semibold)
                    .foregroundColor(authNavy)
                    Spacer()
                }
                .font(.system(size: 15))
            }
            .padding(.horizontal, 24)
        }
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var isFormValid: Bool {
        !fullName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !patientID.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !emailAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

#Preview {
    NavigationStack {
        SignUpView(onCreateAccount: { _ in }, onSignIn: {})
    }
}
