import SwiftUI

// MARK: - Models

struct Appointment: Identifiable {
    let id = UUID()
    let month: String
    let day: Int
    let dayName: String
    let title: String
    let time: String
    let doctor: String
    let location: String
}

struct ScheduleItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let status: ScheduleStatus
}

enum ScheduleStatus {
    case completed, inProgress, pending
    var color: Color {
        switch self {
        case .completed: return .green
        case .inProgress: return .orange
        case .pending: return Color(.systemGray4)
        }
    }
    var icon: String {
        switch self {
        case .completed: return "checkmark.circle.fill"
        case .inProgress: return "circle.fill"
        case .pending: return "circle"
        }
    }
}

struct Prescription: Identifiable {
    let id = UUID()
    let name: String
    let dosage: String
    let frequency: String
    let daysLeft: Int
    let supplyPercent: Double
    let instructions: String
    let color: Color
    let icon: String
}

struct LabResult: Identifiable {
    let id = UUID()
    let name: String
    let date: String
    let doctor: String
    let status: String
    let statusColor: Color
    let hasDownload: Bool
    let icon: String
    let iconColor: Color
}

private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)
// MARK: - DashboardView

struct DashboardView: View {
    @State private var selectedTab: Int = 0
    @State private var showQueueStatus: Bool = false
    @State private var showRoomNavigation: Bool = false

    let appointments: [Appointment] = [
        Appointment(month: "FEB", day: 28, dayName: "Thu",
                    title: "Follow-up Consultation",
                    time: "10:30 AM – 11:00 AM",
                    doctor: "Dr. Sarah Johnson",
                    location: "Cardiology Department"),
        Appointment(month: "MAR", day: 12, dayName: "Wed",
                    title: "Annual Health Checkup",
                    time: "8:00 AM – 10:00 AM",
                    doctor: "Dr. General Medicine",
                    location: "Room B-104")
    ]

    let scheduleItems: [ScheduleItem] = [
        ScheduleItem(title: "Registration", subtitle: "Completed at 9:13 AM", status: .completed),
        ScheduleItem(title: "Consultation", subtitle: "In progress • Room A-201", status: .inProgress),
        ScheduleItem(title: "Lab Tests", subtitle: "In progress • Counter B", status: .inProgress),
        ScheduleItem(title: "Pharmacy", subtitle: "Pending • Ground Floor", status: .pending)
    ]

    let prescriptions: [Prescription] = [
        Prescription(name: "Lisinopril", dosage: "10mg", frequency: "Once daily",
                     daysLeft: 13, supplyPercent: 0.65,
                     instructions: "Take: Every morning with food",
                     color: Color.purple, icon: "pills.fill"),
        Prescription(name: "Metformin", dosage: "500mg", frequency: "Twice daily",
                     daysLeft: 6, supplyPercent: 0.30,
                     instructions: "Take: Morning & evening with meals",
                     color: Color.orange, icon: "cross.vial.fill")
    ]

    let labResults: [LabResult] = [
        LabResult(name: "Complete Blood Count", date: "Jan 20, 2026", doctor: "Dr. Smith",
                  status: "Normal", statusColor: .green, hasDownload: false,
                  icon: "checkmark.circle.fill", iconColor: .green),
        LabResult(name: "Lipid Panel", date: "Jan 15, 2026", doctor: "Dr. Johnson",
                  status: "", statusColor: .clear, hasDownload: true,
                  icon: "arrow.down.circle.fill", iconColor: navy)
    ]

    var body: some View {
        TabView(selection: $selectedTab) {
            homeTab
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)

            RoomNavigationView()
                .tabItem {
                    Label("Navigate", systemImage: "location.fill")
                }
                .tag(1)

            QueueStatusView()
                .tabItem {
                    Label("Progress", systemImage: "chart.bar.fill")
                }
                .tag(2)

            Text("Profile")
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(3)
        }
        .tint(navy)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    // MARK: - Home Tab
    var homeTab: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                headerSection
                mainContent
            }
        }
        .ignoresSafeArea(edges: .top)
        .background(Color(.systemGroupedBackground))
        .navigationDestination(isPresented: $showQueueStatus) {
            QueueStatusView()
        }
        .navigationDestination(isPresented: $showRoomNavigation) {
            RoomNavigationView()
        }
        .overlay(alignment: .bottom) {
            // Bottom action bar (above tab bar)
            HStack(spacing: 32) {
                quickActionBarItem(icon: "mappin.and.ellipse", label: "Navigate")
                quickActionBarItem(icon: "bell.fill", label: "Alerts", badge: true)
                quickActionBarItem(icon: "person.fill", label: "Profile")
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 12)
            .background(.ultraThinMaterial)
            .opacity(0) // hidden — replaced by TabView tab bar
        }
    }

    // MARK: - Header
    var headerSection: some View {
        ZStack(alignment: .bottomLeading) {
            // Background gradient simulating the image
            LinearGradient(
                colors: [Color(red: 0.25, green: 0.45, blue: 0.55), Color(red: 0.10, green: 0.20, blue: 0.32)],
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            .frame(height: 220)
            .overlay(
                // silhouette overlay
                Color.black.opacity(0.25)
            )

            VStack(alignment: .leading, spacing: 4) {
                Text("Good Morning")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.85))

                Text("John Patient")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.white)

                Text("ID: #P-12345")
                    .font(.system(size: 13))
                    .foregroundColor(.white.opacity(0.75))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)

            // Notification Bell
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ZStack(alignment: .topTrailing) {
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 38, height: 38)
                            .overlay(
                                Image(systemName: "bell.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16))
                            )
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                            .offset(x: 2, y: -2)
                    }
                }
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            }
        }
        .frame(height: 220)
    }

    // MARK: - Main Content
    var mainContent: some View {
        VStack(spacing: 16) {
            statsBar
            medicalSummaryCard
            upcomingAppointmentsSection
            activeVisitCard
            todaysScheduleSection
            healthSummarySection
            activePrescriptionsSection
            recentLabResultsSection
            quickActionsSection
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 100)
    }

    // MARK: - Stats Bar
    var statsBar: some View {
        HStack {
            statItem(value: "5", label: "Visits")
            Divider().frame(height: 36)
            statItem(value: "2", label: "Active Rx")
            Divider().frame(height: 36)
            statItem(value: "8", label: "Reports")
        }
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }

    func statItem(value: String, label: String) -> some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(navy)
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Medical Summary
    var medicalSummaryCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Patient Since 2024")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                Spacer()
                Button("Records >") {}
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(navy)
            }

            Text("Medical Summary")
                .font(.system(size: 17, weight: .bold))

            VStack(alignment: .leading, spacing: 6) {
                summaryRow(text: "Last visit: Jan 15, 2026")
                summaryRow(text: "Department: Cardiology")
                summaryRow(text: "Total visits: 5 in last 6 months")
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }

    func summaryRow(text: String) -> some View {
        HStack(spacing: 6) {
            Circle().fill(navy).frame(width: 6, height: 6)
            Text(text).font(.system(size: 14)).foregroundColor(.primary)
        }
    }

    // MARK: - Upcoming Appointments
    var upcomingAppointmentsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Upcoming Appointments")
                    .font(.system(size: 17, weight: .bold))
                Spacer()
                Button("Book New") {}
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(navy)
            }

            ForEach(appointments) { appt in
                appointmentCard(appt)
            }
        }
    }

    func appointmentCard(_ appt: Appointment) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 14) {
                // Date badge
                VStack(spacing: 2) {
                    Text(appt.month)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(navy)
                    Text("\(appt.day)")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(navy)
                    Text(appt.dayName)
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                }
                .frame(width: 48, height: 64)
                .background(Color(red: 0.88, green: 0.93, blue: 0.97))
                .cornerRadius(10)

                VStack(alignment: .leading, spacing: 4) {
                    Text(appt.title)
                        .font(.system(size: 15, weight: .semibold))

                    HStack(spacing: 4) {
                        Image(systemName: "clock").font(.system(size: 12)).foregroundColor(.secondary)
                        Text(appt.time).font(.system(size: 13)).foregroundColor(.secondary)
                    }
                    HStack(spacing: 4) {
                        Image(systemName: "person").font(.system(size: 12)).foregroundColor(.secondary)
                        Text(appt.doctor).font(.system(size: 13)).foregroundColor(.secondary)
                    }
                    HStack(spacing: 4) {
                        Image(systemName: "mappin").font(.system(size: 12)).foregroundColor(.secondary)
                        Text(appt.location).font(.system(size: 13)).foregroundColor(.secondary)
                    }
                }
                Spacer()
            }

            HStack(spacing: 10) {
                Button("View Details") {}
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(navy)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(navy, lineWidth: 1))

                Button("Reschedule") {}
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.systemGray4), lineWidth: 1))
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }

    // MARK: - Active Visit Card
    var activeVisitCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                HStack(spacing: 6) {
                    Circle().fill(Color.green).frame(width: 8, height: 8)
                    Text("Active Visit")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.white.opacity(0.2))
                .cornerRadius(20)

                Spacer()

                Image(systemName: "square.stack.3d.up.fill")
                    .foregroundColor(.white.opacity(0.7))
            }

            Text("General Consultation")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)

            Text("Outpatient Department • Dr. Smith")
                .font(.system(size: 13))
                .foregroundColor(.white.opacity(0.75))

            HStack(spacing: 0) {
                activeStatItem(value: "A42", label: "Queue")
                Divider().frame(height: 40).background(Color.white.opacity(0.3))
                activeStatItem(value: "25m", label: "Wait")
                Divider().frame(height: 40).background(Color.white.opacity(0.3))
                activeStatItem(value: "3", label: "Ahead")
            }
            .background(Color.white.opacity(0.1))
            .cornerRadius(10)

            Button(action: {
                showQueueStatus = true
            }) {
                Text("View Queue Details")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(navy)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
        .padding(16)
        .background(navy)
        .cornerRadius(16)
        .shadow(color: navy.opacity(0.35), radius: 8, y: 4)
    }

    func activeStatItem(value: String, label: String) -> some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.75))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
    }

    // MARK: - Today's Schedule
    var todaysScheduleSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Today's Schedule")
                    .font(.system(size: 17, weight: .bold))
                Spacer()
                Button("View All") {}
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(navy)
            }

            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(scheduleItems.enumerated()), id: \.element.id) { index, item in
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(item.status.color.opacity(0.15))
                                .frame(width: 32, height: 32)
                            Image(systemName: item.status.icon)
                                .font(.system(size: 14))
                                .foregroundColor(item.status.color)
                        }

                        VStack(alignment: .leading, spacing: 2) {
                            Text(item.title)
                                .font(.system(size: 14, weight: .semibold))
                            Text(item.subtitle)
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        if item.status == .inProgress && item.title == "Consultation" {
                            Button(action: {
                                showRoomNavigation = true
                            }) {
                                Text("Navigate")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(navy)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.vertical, 10)

                    if index < scheduleItems.count - 1 {
                        Divider().padding(.leading, 44)
                    }
                }
            }
            .padding(16)
            .background(Color(.systemBackground))
            .cornerRadius(14)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
    }

    // MARK: - Health Summary
    var healthSummarySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Health Summary")
                .font(.system(size: 17, weight: .bold))

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                healthCard(title: "BLOOD PRESSURE", status: "Normal", statusColor: .green,
                           mainValue: "120/80", unit: "mmHg", icon: "heart.fill", iconColor: .red)
                healthCard(title: "HEART RATE", status: "Good", statusColor: .green,
                           mainValue: "72", unit: "bpm", icon: "waveform.path.ecg", iconColor: navy)
                healthCard(title: "BLOOD SUGAR", status: "Fasting", statusColor: .orange,
                           mainValue: "95", unit: "mg/dL", icon: "drop.fill", iconColor: .red)
                healthCard(title: "STEPS TODAY", status: "Active", statusColor: .green,
                           mainValue: "5,423", unit: "steps", icon: "figure.walk", iconColor: .green)
            }
        }
    }

    func healthCard(title: String, status: String, statusColor: Color,
                    mainValue: String, unit: String, icon: String, iconColor: Color) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.secondary)
                    .tracking(0.3)
                Spacer()
                Text(status)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(statusColor)
            }

            HStack(alignment: .bottom, spacing: 4) {
                Text(mainValue)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.primary)
                Text(unit)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .padding(.bottom, 3)
            }
        }
        .padding(14)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }

    // MARK: - Active Prescriptions
    var activePrescriptionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Active Prescriptions")
                    .font(.system(size: 17, weight: .bold))
                Spacer()
                Button("View All") {}
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(navy)
            }

            ForEach(prescriptions) { rx in
                prescriptionCard(rx)
            }
        }
    }

    func prescriptionCard(_ rx: Prescription) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(rx.color.opacity(0.15))
                        .frame(width: 42, height: 42)
                    Image(systemName: rx.icon)
                        .foregroundColor(rx.color)
                        .font(.system(size: 18))
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(rx.name)
                        .font(.system(size: 15, weight: .semibold))
                    Text("\(rx.dosage) • \(rx.frequency)")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }

                Spacer()

                Text("\(rx.daysLeft) days")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(rx.daysLeft <= 7 ? .red : navy)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background((rx.daysLeft <= 7 ? Color.red : navy).opacity(0.1))
                    .cornerRadius(8)
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Supply remaining")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(Int(rx.supplyPercent * 100))%")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.secondary)
                }
                ProgressView(value: rx.supplyPercent)
                    .tint(rx.supplyPercent < 0.35 ? .red : navy)
            }

            Text(rx.instructions)
                .font(.system(size: 13))
                .foregroundColor(.secondary)

            Button("Request Refill") {}
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(navy)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(navy, lineWidth: 1))
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }

    // MARK: - Recent Lab Results
    var recentLabResultsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Recent Lab Results")
                    .font(.system(size: 17, weight: .bold))
                Spacer()
                Button("View All") {}
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(navy)
            }

            VStack(spacing: 0) {
                ForEach(Array(labResults.enumerated()), id: \.element.id) { index, result in
                    HStack(spacing: 12) {
                        Image(systemName: result.icon)
                            .foregroundColor(result.iconColor)
                            .font(.system(size: 22))
                            .frame(width: 36)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(result.name)
                                .font(.system(size: 14, weight: .semibold))
                            HStack(spacing: 4) {
                                Text(result.date)
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                                Text("•")
                                    .foregroundColor(.secondary)
                                Text(result.doctor)
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                            }
                        }

                        Spacer()

                        if !result.status.isEmpty {
                            Text(result.status)
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(result.statusColor)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(result.statusColor.opacity(0.12))
                                .cornerRadius(8)
                        }

                        if result.hasDownload {
                            Button("Download") {}
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(navy)
                        }

                        Image(systemName: "chevron.right")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 12)

                    if index < labResults.count - 1 {
                        Divider()
                    }
                }
            }
            .padding(.horizontal, 16)
            .background(Color(.systemBackground))
            .cornerRadius(14)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
    }

    // MARK: - Quick Actions
    var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Actions")
                .font(.system(size: 17, weight: .bold))

            Button {
                // Start new visit
            } label: {
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(navy.opacity(0.12))
                            .frame(width: 36, height: 36)
                        Image(systemName: "plus")
                            .foregroundColor(navy)
                            .font(.system(size: 16, weight: .semibold))
                    }
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Start New Visit")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.primary)
                        Text("Check-in to department")
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                        .font(.system(size: 13))
                }
                .padding(16)
                .background(Color(.systemBackground))
                .cornerRadius(14)
                .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
            }
        }
    }

    // MARK: - Helper
    func quickActionBarItem(icon: String, label: String, badge: Bool = false) -> some View {
        VStack(spacing: 4) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: icon).font(.system(size: 20))
                if badge {
                    Circle().fill(Color.red).frame(width: 8, height: 8).offset(x: 4, y: -4)
                }
            }
            Text(label).font(.system(size: 10))
        }
        .foregroundColor(navy)
    }
}

#Preview {
    NavigationStack {
        DashboardView()
    }
}
