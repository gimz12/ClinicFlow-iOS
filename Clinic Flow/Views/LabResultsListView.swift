import SwiftUI

struct LabResultsListView: View {
    @Environment(\.dismiss) private var dismiss

    private let navy = Color(red: 0.10, green: 0.30, blue: 0.42)
    @State private var selectedResult: LabResult? = nil

    private var results: [LabResult] {
        [
            LabResult(name: "Complete Blood Count", date: "Jan 20, 2026", doctor: "Dr. Smith",
                      status: "Normal", statusColor: .green, hasDownload: false,
                      icon: "checkmark.circle.fill", iconColor: .green),
            LabResult(name: "Lipid Panel", date: "Jan 15, 2026", doctor: "Dr. Johnson",
                      status: "Ready", statusColor: navy, hasDownload: true,
                      icon: "arrow.down.circle.fill", iconColor: navy),
            LabResult(name: "Metabolic Panel", date: "Dec 04, 2025", doctor: "Dr. Lee",
                      status: "Normal", statusColor: .green, hasDownload: true,
                      icon: "doc.text.fill", iconColor: .green)
        ]
    }

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(results) { result in
                            resultRow(result)
                        }
                    }
                    .padding(16)
                }
            }
        }
        .navigationDestination(item: $selectedResult) { result in
            LabResultDetailView(result: result)
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

            Text("Lab Results")
                .font(.system(size: 18, weight: .semibold))

            Spacer()

            Text(" ")
                .frame(width: 42)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private func resultRow(_ result: LabResult) -> some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(result.iconColor.opacity(0.15))
                    .frame(width: 44, height: 44)
                Image(systemName: result.icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(result.iconColor)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(result.name)
                    .font(.system(size: 16, weight: .semibold))
                Text("\(result.date) • \(result.doctor)")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }

            Spacer()

            if result.hasDownload {
                Button(action: { selectedResult = result }) {
                    Image(systemName: "arrow.down.circle")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(navy)
                }
                .buttonStyle(.plain)
            } else {
                Text(result.status)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(result.statusColor)
            }
        }
        .padding(14)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            selectedResult = result
        }
    }
}

#Preview {
    LabResultsListView()
}
