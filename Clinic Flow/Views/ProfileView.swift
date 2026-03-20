import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    var onNavigateToDashboard: (() -> Void)? = nil

    @State private var showEditProfile: Bool = false
    @State private var showPaymentMethods: Bool = false
    @State private var showBillingHistory: Bool = false
    @State private var showHelpSupport: Bool = false
    @State private var showAccessibility: Bool = false
    @State private var showNotifications: Bool = false
    @State private var showLanguageRegion: Bool = false
    @State private var showPrivacySecurity: Bool = false

    private let navy = Color(red: 0.10, green: 0.30, blue: 0.42)
    private let lightCard = Color(.systemBackground)
    private let dividerColor = Color(.systemGray5)

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    header

                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 20) {
                            profileCard

                            sectionTitle("Quick Actions")
                            quickActionsSection

                            sectionTitle("Settings")
                            settingsSection

                            Text("Version 1.0.0")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity)
                                .padding(.top, 6)

                            logoutButton
                                .padding(.top, 8)
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        .padding(.bottom, 28)
                    }
                }
            }
            .navigationDestination(isPresented: $showEditProfile) {
                PlaceholderView(title: "Edit Profile")
            }
            .navigationDestination(isPresented: $showPaymentMethods) {
                PaymentMethodsView()
            }
            .navigationDestination(isPresented: $showBillingHistory) {
                BillingHistoryView()
            }
            .navigationDestination(isPresented: $showHelpSupport) {
                PlaceholderView(title: "Help & Support")
            }
            .navigationDestination(isPresented: $showAccessibility) {
                PlaceholderView(title: "Accessibility Settings")
            }
            .navigationDestination(isPresented: $showNotifications) {
                PlaceholderView(title: "Notifications")
            }
            .navigationDestination(isPresented: $showLanguageRegion) {
                PlaceholderView(title: "Language & Region")
            }
            .navigationDestination(isPresented: $showPrivacySecurity) {
                PlaceholderView(title: "Privacy & Security")
            }
        }
    }

    private var header: some View {
        HStack {
            Button(action: {
                if let callback = onNavigateToDashboard {
                    callback()
                } else {
                    dismiss()
                }
            }) {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(navy)
            }

            Spacer()

            Text("Profile")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)

            Spacer()

            Button("Edit") {
                showEditProfile = true
            }
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(navy)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private var profileCard: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(navy)
                        .frame(width: 64, height: 64)
                    Text("JP")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("John Patient")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.primary)
                    Text("Patient ID: #12345")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }

                Spacer()
            }

            Divider().background(dividerColor)

            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("VISIT ID")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.secondary)
                        .tracking(0.4)
                    Text("CHECK-IN TIME")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.secondary)
                        .tracking(0.4)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 6) {
                    Text("V-2024-0206")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    Text("9:30 AM")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                }
            }
        }
        .padding(20)
        .background(lightCard)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.06), radius: 4, y: 2)
    }

    private var quickActionsSection: some View {
        VStack(spacing: 12) {
            actionRow(
                title: "Payment Methods",
                icon: "creditcard",
                iconColor: .blue,
                iconBackground: Color.blue.opacity(0.1),
                action: { showPaymentMethods = true }
            )

            actionRow(
                title: "Billing History",
                icon: "calendar",
                iconColor: .orange,
                iconBackground: Color.orange.opacity(0.1),
                action: { showBillingHistory = true }
            )

            actionRow(
                title: "Help & Support",
                icon: "exclamationmark.circle",
                iconColor: .gray,
                iconBackground: Color(.systemGray6),
                action: { showHelpSupport = true }
            )

            actionRow(
                title: "Accessibility Settings",
                icon: "accessibility",
                iconColor: .gray,
                iconBackground: Color(.systemGray6),
                action: { showAccessibility = true }
            )
        }
    }

    private var settingsSection: some View {
        VStack(spacing: 0) {
            settingsRow(title: "Notifications", action: { showNotifications = true })
            Divider().padding(.leading, 16)
            settingsRow(title: "Language & Region", action: { showLanguageRegion = true })
            Divider().padding(.leading, 16)
            settingsRow(title: "Privacy & Security", action: { showPrivacySecurity = true })
        }
        .padding(.vertical, 4)
        .background(lightCard)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var logoutButton: some View {
        Button(action: {
            // End visit action
        }) {
            Text("End Visit & Logout")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color(.systemBackground))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
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

    private func actionRow(title: String, icon: String, iconColor: Color, iconBackground: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(iconBackground)
                        .frame(width: 44, height: 44)
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(iconColor)
                }

                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
            }
            .padding(16)
            .background(lightCard)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.systemGray5), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }

    private func settingsRow(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .buttonStyle(.plain)
    }
}

private struct PlaceholderView: View {
    @Environment(\.dismiss) private var dismiss
    let title: String

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            VStack(spacing: 16) {
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                Text("This screen is coming soon.")
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
                Button("Back") {
                    dismiss()
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color(red: 0.10, green: 0.30, blue: 0.42))
                .cornerRadius(12)
            }
            .padding(24)
        }
    }
}

#Preview {
    ProfileView()
}
