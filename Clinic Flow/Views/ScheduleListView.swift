import SwiftUI

struct ScheduleListView: View {
    @Environment(\.dismiss) private var dismiss

    private let navy = Color(red: 0.10, green: 0.30, blue: 0.42)

    private let scheduleItems: [ScheduleItem] = [
        ScheduleItem(title: "Registration", subtitle: "Completed at 9:13 AM", status: .completed),
        ScheduleItem(title: "Consultation", subtitle: "In progress • Room A-201", status: .inProgress),
        ScheduleItem(title: "Lab Tests", subtitle: "In progress • Counter B", status: .inProgress),
        ScheduleItem(title: "Pharmacy", subtitle: "Pending • Ground Floor", status: .pending)
    ]

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(scheduleItems) { item in
                            scheduleRow(item)
                        }
                    }
                    .padding(16)
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

            Text("Today's Schedule")
                .font(.system(size: 18, weight: .semibold))

            Spacer()

            Text(" ")
                .frame(width: 42)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private func scheduleRow(_ item: ScheduleItem) -> some View {
        HStack(spacing: 12) {
            Image(systemName: item.status.icon)
                .foregroundColor(item.status.color)
                .font(.system(size: 16, weight: .semibold))

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.system(size: 16, weight: .semibold))
                Text(item.subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(14)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }
}

#Preview {
    ScheduleListView()
}
