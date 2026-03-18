import SwiftUI

struct ForgotPasswordView: View {
    let onSendCode: (RecoveryMethod, String) -> Void
    let onBackToSignIn: () -> Void

    @State private var selectedMethod: RecoveryMethod = .email
    @State private var contactValue = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                AuthHeaderIcon(symbolName: "exclamationmark.circle", tint: Color(red: 0.29, green: 0.36, blue: 0.47))
                    .frame(maxWidth: .infinity)
                    .padding(.top, 52)
                    .padding(.bottom, 32)

                VStack(spacing: 12) {
                    Text("Forgot Password")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primary)

                    Text("Enter your contact information to receive a verification code")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 320)
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 40)

                Text("RECOVERY METHOD")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.primary)
                    .tracking(0.5)
                    .padding(.bottom, 16)

                VStack(spacing: 16) {
                    ForEach(RecoveryMethod.allCases, id: \.self) { method in
                        RecoveryMethodCard(
                            method: method,
                            isSelected: selectedMethod == method
                        )
                        .onTapGesture {
                            selectedMethod = method
                            contactValue = ""
                        }
                    }
                }
                .padding(.bottom, 24)

                AuthInputSection(title: selectedMethod.fieldTitle) {
                    TextField(selectedMethod.placeholder, text: $contactValue)
                        .keyboardType(selectedMethod == .email ? .emailAddress : .phonePad)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }

                HStack(alignment: .top, spacing: 14) {
                    Image(systemName: "info.circle")
                        .font(.system(size: 28))
                        .foregroundColor(Color(red: 0.53, green: 0.60, blue: 0.72))

                    Text("A verification code will be sent to your \(selectedMethod.deliveryText). Please check and enter the code in the next step.")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                        .lineSpacing(4)
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray6))
                .cornerRadius(18)
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                )
                .padding(.bottom, 24)

                Button {
                    onSendCode(selectedMethod, contactValue)
                } label: {
                    Text("Send Verification Code")
                }
                .authPrimaryButton()
                .disabled(trimmedContactValue.isEmpty)
                .opacity(trimmedContactValue.isEmpty ? 0.55 : 1)
                .padding(.bottom, 28)

                Button("Back to Sign In") {
                    onBackToSignIn()
                }
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 24)
        }
        .navigationTitle("Forgot Password")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var trimmedContactValue: String {
        contactValue.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

private struct RecoveryMethodCard: View {
    let method: RecoveryMethod
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .stroke(isSelected ? authNavy : Color(.systemGray4), lineWidth: 3)
                    .frame(width: 34, height: 34)

                if isSelected {
                    Circle()
                        .fill(authNavy)
                        .frame(width: 16, height: 16)
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(method.title)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(isSelected ? authNavy : .primary)

                Text(method.subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 26)
        .frame(maxWidth: .infinity)
        .background(isSelected ? Color(red: 0.91, green: 0.96, blue: 0.99) : .white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isSelected ? authNavy : Color(.systemGray5), lineWidth: isSelected ? 1.5 : 1)
        )
    }
}

#Preview {
    NavigationStack {
        ForgotPasswordView(onSendCode: { _, _ in }, onBackToSignIn: {})
    }
}
