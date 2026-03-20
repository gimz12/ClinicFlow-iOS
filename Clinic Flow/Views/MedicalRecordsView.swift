import SwiftUI

struct MedicalRecordsView: View {
    @Environment(\.dismiss) private var dismiss

    private let navy = Color(red: 0.10, green: 0.30, blue: 0.42)

    private let records = [
        (title: "Visit Summaries", subtitle: "4 visits • Updated Feb 2026", icon: "doc.plaintext", tint: Color.blue),
        (title: "Diagnoses", subtitle: "3 active • Last updated Jan 2026", icon: "stethoscope", tint: Color.purple),
        (title: "Reports", subtitle: "8 files • Lab & imaging", icon: "doc.text.magnifyingglass", tint: Color.orange),
        (title: "Documents", subtitle: "Insurance & consent", icon: "folder", tint: Color.green)
    ]

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        summaryCard

                        VStack(spacing: 12) {
                            ForEach(records.indices, id: \.self) { index in
                                recordRow(records[index])
                            }
                        }

                        recentActivityCard
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

            Text("Medical Records")
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

    private var summaryCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Records Hub")
                .font(.system(size: 18, weight: .bold))
            Text("All your visit history, diagnoses, and shared documents in one place.")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
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

    private func recordRow(_ item: (title: String, subtitle: String, icon: String, tint: Color)) -> some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(item.tint.opacity(0.15))
                    .frame(width: 44, height: 44)
                Image(systemName: item.icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(item.tint)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.system(size: 16, weight: .semibold))
                Text(item.subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)
        }
        .padding(14)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var recentActivityCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recent Activity")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)

            VStack(spacing: 10) {
                activityRow(title: "Lab report added", detail: "Lipid Panel • Jan 15, 2026")
                activityRow(title: "Visit summary uploaded", detail: "Cardiology follow-up • Feb 28, 2026")
                activityRow(title: "Insurance card updated", detail: "BlueShield • Feb 02, 2026")
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

    private func activityRow(title: String, detail: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 15, weight: .semibold))
            Text(detail)
                .font(.system(size: 13))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    MedicalRecordsView()
}
