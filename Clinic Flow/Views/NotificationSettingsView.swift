import SwiftUI

struct NotificationSettingsView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var appointmentReminders: Bool = true
    @State private var labResultAlerts: Bool = true
    @State private var billingAlerts: Bool = true
    @State private var clinicUpdates: Bool = false
    @State private var marketingUpdates: Bool = false
    @State private var quietHours: Bool = false

    private let navy = Color(red: 0.10, green: 0.30, blue: 0.42)

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        settingsCard(title: "Core Alerts") {
                            toggleRow("Appointment reminders", isOn: $appointmentReminders)
                            toggleRow("Lab result alerts", isOn: $labResultAlerts)
                            toggleRow("Billing updates", isOn: $billingAlerts)
                        }

                        settingsCard(title: "Clinic Messages") {
                            toggleRow("Clinic updates", isOn: $clinicUpdates)
                            toggleRow("Marketing & newsletters", isOn: $marketingUpdates)
                        }

                        settingsCard(title: "Quiet Hours") {
                            toggleRow("Silence non-urgent notifications", isOn: $quietHours)
                            Text("Quiet hours are applied from 9:00 PM to 7:00 AM.")
                                .font(.system(size: 13))
                                .foregroundColor(.secondary)
                                .padding(.top, 4)
                        }
                    }
                    .padding(16)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
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

            Text("Notification Settings")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)

            Spacer()

            Button("Done") {
                dismiss()
            }
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(navy)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private func settingsCard<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
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

    private func toggleRow(_ title: String, isOn: Binding<Bool>) -> some View {
        Toggle(isOn: isOn) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
        }
        .toggleStyle(SwitchToggleStyle(tint: navy))
    }
}

#Preview {
    NotificationSettingsView()
}
