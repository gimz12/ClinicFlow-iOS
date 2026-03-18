import SwiftUI

struct NewPasswordView: View {
    let onContinueToSignIn: () -> Void

    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                AuthHeaderIcon(symbolName: "checkmark", tint: Color(red: 0.04, green: 0.59, blue: 0.42), background: Color(red: 0.90, green: 0.97, blue: 0.93))
                    .frame(maxWidth: .infinity)
                    .padding(.top, 52)
                    .padding(.bottom, 32)

                VStack(spacing: 12) {
                    Text("Create New Password")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primary)

                    Text("Choose a strong password for your account")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 280)
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 40)

                AuthInputSection(title: "NEW PASSWORD") {
                    SecureField("Enter new password", text: $password)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("• At least 8 characters")
                    Text("• Include numbers and letters")
                }
                .font(.system(size: 15))
                .foregroundColor(.secondary)
                .padding(.bottom, 28)

                AuthInputSection(title: "CONFIRM PASSWORD") {
                    SecureField("Re-enter new password", text: $confirmPassword)
                }

                Button {
                    onContinueToSignIn()
                } label: {
                    Text("Continue to Sign In")
                }
                .authPrimaryButton()
                .disabled(!isPasswordValid)
                .opacity(isPasswordValid ? 1 : 0.55)
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 24)
        }
        .navigationTitle("New Password")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var isPasswordValid: Bool {
        password.count >= 8 &&
        password.rangeOfCharacter(from: .letters) != nil &&
        password.rangeOfCharacter(from: .decimalDigits) != nil &&
        password == confirmPassword
    }
}

#Preview {
    NavigationStack {
        NewPasswordView(onContinueToSignIn: {})
    }
}
