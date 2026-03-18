import SwiftUI

struct OTPView: View {
    let phoneNumber: String
    var onSignUp: (() -> Void)? = nil

    @State private var otpCode: String = ""
    @State private var secondsRemaining: Int = 165
    @State private var timer: Timer? = nil
    @State private var navigateToDashboard: Bool = false
    @Environment(\.dismiss) private var dismiss

    var formattedTime: String {
        let minutes = secondsRemaining / 60
        let seconds = secondsRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Verify Phone Number")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primary)

                    Text("Enter the verification code sent to your phone")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                }
                .padding(.top, 32)
                .padding(.bottom, 28)

                // Code Sent To Card
                HStack(spacing: 16) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(red: 0.82, green: 0.90, blue: 0.95))
                            .frame(width: 52, height: 52)
                        Image(systemName: "iphone")
                            .font(.system(size: 22))
                            .foregroundColor(authNavy)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text("CODE SENT TO")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.secondary)
                            .tracking(0.5)
                        Text(phoneNumber)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.primary)
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray6))
                .cornerRadius(14)
                .padding(.bottom, 28)

                // Verification Code Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("VERIFICATION CODE")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.primary)
                        .tracking(0.5)

                    TextField("Enter 6-digit code", text: $otpCode)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .keyboardType(.numberPad)
                        .onChange(of: otpCode) { _, newValue in
                            if newValue.count > 6 {
                                otpCode = String(newValue.prefix(6))
                            }
                        }

                    HStack {
                        Text("Code expires in \(formattedTime)")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                        Spacer()
                        Button("Resend Code") {
                            secondsRemaining = 165
                            startTimer()
                        }
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(authNavy)
                    }
                    .padding(.top, 4)
                }
                .padding(.bottom, 28)

                // Verify & Continue Button
                Button {
                    navigateToDashboard = true
                } label: {
                        Text("Verify & Continue")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(authNavy)
                            .cornerRadius(14)
                }
                .padding(.bottom, 24)

                // Footer Links
                VStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Text("Don't have an account?")
                            .foregroundColor(.secondary)
                        Button("Sign Up") {
                            onSignUp?()
                        }
                            .fontWeight(.semibold)
                            .foregroundColor(authNavy)
                    }
                    .font(.system(size: 15))

                    HStack(spacing: 4) {
                        Text("Need assistance?")
                            .foregroundColor(.secondary)
                        Button("Contact reception") {}
                            .fontWeight(.semibold)
                            .foregroundColor(authNavy)
                    }
                    .font(.system(size: 15))
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 8)
            }
            .padding(.horizontal, 24)
        }
        .navigationTitle("Verify OTP")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToDashboard) {
            DashboardView()
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
        .onAppear { startTimer() }
        .onDisappear { timer?.invalidate() }
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if secondsRemaining > 0 {
                secondsRemaining -= 1
            } else {
                timer?.invalidate()
            }
        }
    }
}

#Preview {
    NavigationStack {
        OTPView(phoneNumber: "+1 (555) 123-4567")
    }
}
