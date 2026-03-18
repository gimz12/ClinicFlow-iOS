import SwiftUI

struct VerifyRecoveryCodeView: View {
    let method: RecoveryMethod
    let destination: String
    let onVerify: () -> Void

    @State private var code = ""
    @State private var secondsRemaining = 272
    @State private var timer: Timer?
    @FocusState private var isCodeFieldFocused: Bool

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                AuthHeaderIcon(symbolName: "doc.text", tint: Color(red: 0.29, green: 0.36, blue: 0.47))
                    .padding(.top, 52)
                    .padding(.bottom, 32)

                VStack(spacing: 12) {
                    Text("Enter Code")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primary)

                    Text("We've sent a 6-digit code to your \(method.deliveryText)")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 16)

                Text(destination)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(authNavy)
                    .padding(.bottom, 40)

                Text("VERIFICATION CODE")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.primary)
                    .tracking(0.5)
                    .padding(.bottom, 16)

                ZStack {
                    TextField("", text: $code)
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .foregroundColor(.clear)
                        .accentColor(.clear)
                        .frame(width: 1, height: 1)
                        .focused($isCodeFieldFocused)
                        .onChange(of: code) { _, newValue in
                            let filtered = newValue.filter(\.isNumber)
                            code = String(filtered.prefix(6))
                        }

                    HStack(spacing: 14) {
                        ForEach(0..<6, id: \.self) { index in
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(.systemGray5), lineWidth: 1.5)
                                .frame(maxWidth: .infinity)
                                .frame(height: 76)
                                .overlay {
                                    Text(digit(at: index))
                                        .font(.system(size: 28, weight: .semibold))
                                        .foregroundColor(.primary)
                                }
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isCodeFieldFocused = true
                    }
                }
                .padding(.bottom, 28)

                VStack(spacing: 14) {
                    Text("Didn't receive the code?")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)

                    Button("Resend Code") {
                        secondsRemaining = 272
                        startTimer()
                    }
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(authNavy)
                }
                .padding(.bottom, 42)

                HStack {
                    Text("CODE EXPIRES IN:")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.primary)
                        .tracking(0.5)

                    Spacer()

                    HStack(spacing: 12) {
                        TimerChip(value: formattedMinutes)
                        Text(":")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color(red: 0.61, green: 0.70, blue: 0.80))
                        TimerChip(value: formattedSeconds)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 26)
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                )
                .padding(.bottom, 32)

                Button {
                    onVerify()
                } label: {
                    Text("Verify Code")
                }
                .authPrimaryButton()
                .disabled(code.count != 6)
                .opacity(code.count == 6 ? 1 : 0.55)
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 24)
        }
        .navigationTitle("Verify Code")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            isCodeFieldFocused = true
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }

    private var formattedMinutes: String {
        String(format: "%d", secondsRemaining / 60)
    }

    private var formattedSeconds: String {
        String(format: "%02d", secondsRemaining % 60)
    }

    private func digit(at index: Int) -> String {
        guard index < code.count else { return "" }
        let character = code[code.index(code.startIndex, offsetBy: index)]
        return String(character)
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

private struct TimerChip: View {
    let value: String

    var body: some View {
        Text(value)
            .font(.system(size: 22, weight: .bold))
            .foregroundColor(.white)
            .frame(width: 62, height: 58)
            .background(authNavy)
            .cornerRadius(12)
    }
}

#Preview {
    NavigationStack {
        VerifyRecoveryCodeView(method: .email, destination: "john@example.com", onVerify: {})
    }
}
