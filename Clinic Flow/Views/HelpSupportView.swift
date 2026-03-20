import SwiftUI

struct HelpSupportView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showQueueStatus: Bool = false

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
                        supportHeroCard

                        sectionTitle("Contact Options")
                        contactOptionsRow

                        sectionTitle("Frequently Asked Questions")
                        faqSection

                        sectionTitle("Visit Support")
                        visitSupportCard
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 28)
                }
            }
        }
        .navigationDestination(isPresented: $showQueueStatus) {
            QueueStatusView()
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

            Text("Help & Support")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)

            Spacer()

            Image(systemName: "questionmark.circle")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(navy)
                .opacity(0)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private var supportHeroCard: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(navy.opacity(0.12))
                    .frame(width: 52, height: 52)
                Image(systemName: "headphones")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(navy)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Need help with your visit?")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)
                Text("Our care team can assist with appointments, billing, and navigation.")
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

    private var contactOptionsRow: some View {
        HStack(spacing: 12) {
            contactOptionCard(
                title: "Call",
                subtitle: "24/7",
                icon: "phone.fill",
                tint: .green
            )

            contactOptionCard(
                title: "Live Chat",
                subtitle: "2 min",
                icon: "message.fill",
                tint: .blue
            )

            contactOptionCard(
                title: "Email",
                subtitle: "Within 1 hr",
                icon: "envelope.fill",
                tint: .orange
            )
        }
    }

    private var faqSection: some View {
        VStack(spacing: 0) {
            faqRow("How do I reschedule an appointment?")
            Divider().padding(.leading, 16)
            faqRow("Where can I view my billing history?")
            Divider().padding(.leading, 16)
            faqRow("How do I update my personal details?")
            Divider().padding(.leading, 16)
            faqRow("How do I get directions to my room?")
        }
        .padding(.vertical, 4)
        .background(lightCard)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var visitSupportCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Current Visit")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.primary)
                    Text("Visit ID: V-2024-0206")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }

                Spacer()

                Button("View Queue") {
                    showQueueStatus = true
                }
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(navy)
            }

            HStack(spacing: 12) {
                detailChip(icon: "clock.fill", text: "Check-in 9:30 AM")
                detailChip(icon: "mappin.and.ellipse", text: "Room A-201")
            }
        }
        .padding(16)
        .background(lightCard)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private func contactOptionCard(title: String, subtitle: String, icon: String, tint: Color) -> some View {
        Button(action: {}) {
            VStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(tint.opacity(0.12))
                        .frame(width: 46, height: 46)
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(tint)
                }

                Text(title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.primary)

                Text(subtitle)
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(lightCard)
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color(.systemGray5), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }

    private func faqRow(_ title: String) -> some View {
        Button(action: {}) {
            HStack {
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.primary)
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

    private func detailChip(icon: String, text: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(navy)
            Text(text)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(navy)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(navy.opacity(0.08))
        .cornerRadius(10)
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
        HelpSupportView()
    }
}
