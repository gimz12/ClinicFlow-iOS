import SwiftUI

let authNavy = Color(red: 0.13, green: 0.27, blue: 0.40)

enum RecoveryMethod: String, CaseIterable, Hashable {
    case email
    case sms

    var title: String {
        switch self {
        case .email:
            return "Email"
        case .sms:
            return "SMS"
        }
    }

    var subtitle: String {
        switch self {
        case .email:
            return "Send code to your email"
        case .sms:
            return "Send code to your phone"
        }
    }

    var fieldTitle: String {
        switch self {
        case .email:
            return "EMAIL ADDRESS"
        case .sms:
            return "PHONE NUMBER"
        }
    }

    var placeholder: String {
        switch self {
        case .email:
            return "your.email@example.com"
        case .sms:
            return "+1 (555) 000-0000"
        }
    }

    var deliveryText: String {
        switch self {
        case .email:
            return "email"
        case .sms:
            return "phone"
        }
    }

    var iconName: String {
        switch self {
        case .email:
            return "envelope"
        case .sms:
            return "message"
        }
    }
}

enum AuthRoute: Hashable {
    case otp(phoneNumber: String)
    case signUp
    case forgotPassword
    case verifyRecoveryCode(method: RecoveryMethod, destination: String)
    case newPassword
}

struct LoginView: View {
    @State private var phoneNumber: String = ""
    @State private var path = NavigationPath()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome Back")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.primary)

                        Text("Sign in to continue your visit")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 32)
                    .padding(.bottom, 32)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("PHONE NUMBER")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.primary)
                            .tracking(0.5)

                        TextField("Enter your phone number", text: $phoneNumber)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .keyboardType(.phonePad)

                        Text("We'll send a verification code to your phone number")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                            .padding(.top, 4)
                    }
                    .padding(.bottom, 28)

                    Button {
                        guard !phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                            return
                        }
                        path.append(AuthRoute.otp(phoneNumber: phoneNumber))
                    } label: {
                        Text("Continue")
                    }
                    .authPrimaryButton()
                    .padding(.bottom, 16)

                    HStack {
                        Spacer()
                        Button("Forgot Password?") {
                            showForgotPassword()
                        }
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(authNavy)
                    }
                    .padding(.bottom, 32)

                    VStack(spacing: 16) {
                        HStack(spacing: 4) {
                            Text("Don't have an account?")
                                .foregroundColor(.secondary)
                            Button("Sign Up") {
                                showSignUp()
                            }
                            .fontWeight(.semibold)
                            .foregroundColor(authNavy)
                        }
                        .font(.system(size: 15))

                        HStack(spacing: 4) {
                            Text("Need assistance?")
                                .foregroundColor(.secondary)
                            Button("Contact reception") {
                            }
                            .fontWeight(.semibold)
                            .foregroundColor(authNavy)
                        }
                        .font(.system(size: 15))
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 24)
            }
            .navigationTitle("Sign In")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(for: AuthRoute.self) { route in
                switch route {
                case .otp(let phoneNumber):
                    OTPView(phoneNumber: phoneNumber) {
                        showSignUp()
                    }
                case .signUp:
                    SignUpView(
                        onCreateAccount: { registeredPhoneNumber in
                            path.append(AuthRoute.otp(phoneNumber: registeredPhoneNumber))
                        },
                        onSignIn: {
                            path = NavigationPath()
                        }
                    )
                case .forgotPassword:
                    ForgotPasswordView(
                        onSendCode: { method, destination in
                            path.append(
                                AuthRoute.verifyRecoveryCode(
                                    method: method,
                                    destination: destination
                                )
                            )
                        },
                        onBackToSignIn: {
                            path = NavigationPath()
                        }
                    )
                case .verifyRecoveryCode(let method, let destination):
                    VerifyRecoveryCodeView(
                        method: method,
                        destination: destination,
                        onVerify: {
                            path.append(AuthRoute.newPassword)
                        }
                    )
                case .newPassword:
                    NewPasswordView {
                        path = NavigationPath()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(authNavy)
                    }
                }
            }
        }
    }

    private func showSignUp() {
        path = NavigationPath()
        path.append(AuthRoute.signUp)
    }

    private func showForgotPassword() {
        path = NavigationPath()
        path.append(AuthRoute.forgotPassword)
    }
}

private struct AuthPrimaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17, weight: .semibold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(authNavy)
            .cornerRadius(14)
    }
}

extension View {
    func authPrimaryButton() -> some View {
        modifier(AuthPrimaryButtonModifier())
    }
}

#Preview {
    LoginView()
}
