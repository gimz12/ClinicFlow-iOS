import SwiftUI

struct AppNotificationItem: Identifiable {
    let id = UUID()
    let title: String
    let timeAgo: String
    let message: String
    var isUnread: Bool
}

struct NotificationsView: View {
    @Binding var hasUnreadNotifications: Bool
    @Environment(\.dismiss) private var dismiss

    @State private var notifications: [AppNotificationItem] = [
        AppNotificationItem(
            title: "Queue Update",
            timeAgo: "2 min ago",
            message: "Your queue number C18 is now 3rd in line. Estimated wait time: 45 minutes.",
            isUnread: true
        ),
        AppNotificationItem(
            title: "Direction Reminder",
            timeAgo: "15 min ago",
            message: "Please proceed to Room A-201 on the 2nd floor for your consultation.",
            isUnread: true
        ),
        AppNotificationItem(
            title: "Next Step Alert",
            timeAgo: "1 hour ago",
            message: "Lab tests scheduled next. Please fast for 8 hours before the test.",
            isUnread: false
        )
    ]

    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)
    private let borderColor = Color(red: 0.82, green: 0.87, blue: 0.93)

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                headerView

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 18) {
                        Text("TODAY")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(Color(red: 0.42, green: 0.49, blue: 0.60))
                            .padding(.top, 16)

                        VStack(spacing: 18) {
                            ForEach(notifications) { notification in
                                notificationCard(notification)
                            }
                        }
                    }
                    .padding(.horizontal, 18)
                    .padding(.bottom, 28)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear {
            syncUnreadState()
        }
    }

    private var headerView: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                    Text("Back")
                        .font(.system(size: 17, weight: .semibold))
                }
                .foregroundColor(navy)
            }

            Spacer()

            Text("Notifications")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(Color(red: 0.11, green: 0.16, blue: 0.25))

            Spacer()

            Button(action: markAllAsRead) {
                Text("Mark All")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(navy)
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
        .background(Color(.systemBackground))
        .overlay(alignment: .bottom) {
            Divider()
        }
    }

    private func notificationCard(_ notification: AppNotificationItem) -> some View {
        Button(action: {
            markAsRead(notification.id)
        }) {
            HStack(alignment: .top, spacing: 16) {
                RoundedRectangle(cornerRadius: 18)
                    .fill(notification.isUnread ? navy : Color(red: 0.93, green: 0.95, blue: 0.98))
                    .frame(width: 58, height: 58)
                    .overlay(
                        Image(systemName: "bell.badge")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(notification.isUnread ? .white : Color(red: 0.57, green: 0.64, blue: 0.75))
                    )

                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(notification.title)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color(red: 0.13, green: 0.18, blue: 0.28))

                            Text(notification.timeAgo)
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(Color(red: 0.42, green: 0.50, blue: 0.62))
                        }

                        Spacer()

                        if notification.isUnread {
                            Circle()
                                .fill(navy)
                                .frame(width: 11, height: 11)
                                .padding(.top, 6)
                        }
                    }

                    Text(notification.message)
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 0.31, green: 0.39, blue: 0.52))
                        .multilineTextAlignment(.leading)
                        .lineSpacing(4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(22)
            .background(Color(.systemBackground))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(borderColor, lineWidth: 1.2)
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.08), radius: 8, y: 3)
        }
        .buttonStyle(.plain)
    }

    private func markAsRead(_ id: UUID) {
        guard let index = notifications.firstIndex(where: { $0.id == id }) else {
            return
        }

        notifications[index].isUnread = false
        syncUnreadState()
    }

    private func markAllAsRead() {
        for index in notifications.indices {
            notifications[index].isUnread = false
        }
        syncUnreadState()
    }

    private func syncUnreadState() {
        hasUnreadNotifications = notifications.contains(where: \.isUnread)
    }
}

#Preview {
    NavigationStack {
        NotificationsView(hasUnreadNotifications: .constant(true))
    }
}
