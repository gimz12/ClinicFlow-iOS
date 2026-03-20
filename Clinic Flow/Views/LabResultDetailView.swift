import SwiftUI

struct LabResultDetailView: View {
    @Environment(\.dismiss) private var dismiss

    let result: LabResult

    private let navy = Color(red: 0.10, green: 0.30, blue: 0.42)

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        summaryCard
                        pdfPreviewCard
                        actionCard
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

            Text("Lab Result")
                .font(.system(size: 18, weight: .semibold))

            Spacer()

            Text(" ")
                .frame(width: 42)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private var summaryCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(result.name)
                .font(.system(size: 18, weight: .bold))
            Text("Ordered by \(result.doctor)")
                .font(.system(size: 13))
                .foregroundColor(.secondary)
            HStack {
                Text(result.date)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                Spacer()
                if !result.status.isEmpty {
                    Text(result.status)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(result.statusColor)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(result.statusColor.opacity(0.12))
                        .cornerRadius(8)
                }
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

    private var pdfPreviewCard: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray5))
                .frame(height: 220)
                .overlay(
                    VStack(spacing: 8) {
                        Image(systemName: "doc.richtext")
                            .font(.system(size: 32, weight: .semibold))
                            .foregroundColor(navy)
                        Text("PDF Preview")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.secondary)
                    }
                )

            Text("Full report available as PDF. Tap download to save or share.")
                .font(.system(size: 13))
                .foregroundColor(.secondary)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var actionCard: some View {
        VStack(spacing: 12) {
            Button(action: {}) {
                Text("Download PDF")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(navy)
                    .cornerRadius(14)
            }

            Button(action: {}) {
                Text("Share Report")
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
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }
}

#Preview {
    LabResultDetailView(result: LabResult(name: "Lipid Panel", date: "Jan 15, 2026", doctor: "Dr. Johnson", status: "Ready", statusColor: .green, hasDownload: true, icon: "arrow.down.circle.fill", iconColor: .green))
}
