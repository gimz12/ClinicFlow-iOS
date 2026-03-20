import SwiftUI

struct PrivacySecurityView: View {
    @Environment(\.dismiss) private var dismiss

    @AppStorage("privacy_biometricLogin") private var biometricLogin: Bool = true
    @AppStorage("privacy_sessionTimeout") private var sessionTimeout: Bool = true
    @AppStorage("privacy_dataSharing") private var dataSharing: Bool = false
    @AppStorage("privacy_personalizedRecommendations") private var personalizedRecommendations: Bool = true
    @AppStorage("privacy_activityLogs") private var activityLogs: Bool = true

    private let navy = Color(red: 0.10, green: 0.30, blue: 0.42)
    private let lightCard = Color(.systemBackground)

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        infoCard

                        sectionTitle("Security")
                        securitySection

                        sectionTitle("Privacy")
                        privacySection

                        sectionTitle("Data")
                        dataSection
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 28)
                }
            }
        }
    }

    private var header: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(navy)
            }

            Spacer()

            Text("Privacy & Security")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)

            Spacer()

            Image(systemName: "lock.shield")
                .font(.system(size: 16))
                .opacity(0)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private var infoCard: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(navy.opacity(0.12))
                    .frame(width: 52, height: 52)
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(navy)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Protect your account")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)
                Text("Manage login security and data sharing preferences.")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(16)
        .background(lightCard)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var securitySection: some View {
        VStack(spacing: 0) {
            toggleRow(
                title: "Face ID / Touch ID",
                subtitle: "Use biometrics for quick sign-in",
                isOn: $biometricLogin
            )
            .padding(16)

            Divider().padding(.leading, 16)

            toggleRow(
                title: "Session Timeout",
                subtitle: "Sign out after 15 minutes of inactivity",
                isOn: $sessionTimeout
            )
            .padding(16)

            Divider().padding(.leading, 16)

            actionRow(title: "Change Password", subtitle: "Update your account password")
                .padding(16)
        }
        .background(lightCard)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var privacySection: some View {
        VStack(spacing: 0) {
            toggleRow(
                title: "Data Sharing",
                subtitle: "Share anonymized analytics",
                isOn: $dataSharing
            )
            .padding(16)

            Divider().padding(.leading, 16)

            toggleRow(
                title: "Personalized Tips",
                subtitle: "Recommendations based on visit history",
                isOn: $personalizedRecommendations
            )
            .padding(16)
        }
        .background(lightCard)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var dataSection: some View {
        VStack(spacing: 0) {
            toggleRow(
                title: "Activity Logs",
                subtitle: "Keep a history of account activity",
                isOn: $activityLogs
            )
            .padding(16)

            Divider().padding(.leading, 16)

            actionRow(title: "Download My Data", subtitle: "Request a copy of your records")
                .padding(16)

            Divider().padding(.leading, 16)

            actionRow(title: "Delete Account", subtitle: "Permanently remove your profile")
                .padding(16)
        }
        .background(lightCard)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private func toggleRow(title: String, subtitle: String, isOn: Binding<Bool>) -> some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }

            Spacer()

            Toggle("", isOn: isOn)
                .labelsHidden()
        }
    }

    private func actionRow(title: String, subtitle: String) -> some View {
        Button(action: {}) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.secondary)
            }
        }
        .buttonStyle(.plain)
    }

    private func sectionTitle(_ text: String) -> some View {
        Text(text.uppercased())
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.secondary)
            .tracking(0.6)
            .padding(.horizontal, 2)
    }
}

#Preview {
    NavigationStack {
        PrivacySecurityView()
    }
}
