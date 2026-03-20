import SwiftUI

struct EndVisitConfirmationView: View {
    @Environment(\.dismiss) private var dismiss

    var onConfirmSignOut: (() -> Void)? = nil

    private let navy = Color(red: 0.10, green: 0.30, blue: 0.42)

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                VStack(spacing: 16) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.system(size: 44, weight: .semibold))
                        .foregroundColor(navy)
                        .padding(.top, 24)

                    Text("End Visit & Logout")
                        .font(.system(size: 22, weight: .bold))

                    Text("We will sign you out and clear this visit session. You can sign back in anytime.")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)

                    VStack(spacing: 12) {
                        Button(action: confirmSignOut) {
                            Text("End Visit")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(navy)
                                .cornerRadius(14)
                        }

                        Button(action: { dismiss() }) {
                            Text("Cancel")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(navy)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Color(.systemBackground))
                                .cornerRadius(14)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color(.systemGray4), lineWidth: 1)
                                )
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 6)

                    Spacer()
                }
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

            Text("Confirm Logout")
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

    private func confirmSignOut() {
        if let onConfirmSignOut {
            onConfirmSignOut()
        } else {
            dismiss()
        }
    }
}

#Preview {
    EndVisitConfirmationView()
}
