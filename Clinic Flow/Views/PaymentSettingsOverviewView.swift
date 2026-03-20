import SwiftUI

struct PaymentSettingsOverviewView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var showPaymentMethods: Bool = false
    @State private var showBillingHistory: Bool = false

    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)
    private let lightBlue = Color(red: 0.88, green: 0.93, blue: 0.97)

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        summaryCard
                        nextDueCard

                        sectionTitle("Payment Settings")
                        settingsActions
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 28)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $showPaymentMethods) {
            PaymentMethodsView()
        }
        .navigationDestination(isPresented: $showBillingHistory) {
            BillingHistoryView()
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
                .foregroundColor(.primary)
            }

            Spacer()

            Text("Payment Settings")
                .font(.system(size: 17, weight: .semibold))

            Spacer()

            Text(" ")
                .frame(width: 42)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private var summaryCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Balance Overview")
                .font(.system(size: 16, weight: .semibold))
            Text("Current balance")
                .font(.system(size: 13))
                .foregroundColor(.secondary)

            HStack(alignment: .lastTextBaseline, spacing: 6) {
                Text("$72.50")
                    .font(.system(size: 28, weight: .bold))
                Text("due")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.secondary)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var nextDueCard: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(lightBlue)
                    .frame(width: 44, height: 44)
                Image(systemName: "calendar")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(navy)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Next Payment Due")
                    .font(.system(size: 14, weight: .semibold))
                Text("Mar 28, 2026 • $72.50")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var settingsActions: some View {
        VStack(spacing: 0) {
            settingsRow(title: "Payment Methods", subtitle: "Manage cards and defaults") {
                showPaymentMethods = true
            }
            Divider().padding(.leading, 16)
            settingsRow(title: "Billing History", subtitle: "View statements and invoices") {
                showBillingHistory = true
            }
        }
        .padding(.vertical, 4)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private func sectionTitle(_ text: String) -> some View {
        Text(text.uppercased())
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.secondary)
            .tracking(0.6)
            .padding(.horizontal, 2)
    }

    private func settingsRow(title: String, subtitle: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
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
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        PaymentSettingsOverviewView()
    }
}
