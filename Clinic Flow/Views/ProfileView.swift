import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Profile")
                            .font(.system(size: 30, weight: .bold))
                        Text("Manage your personal details and account settings.")
                            .font(.system(size: 15))
                            .foregroundColor(.secondary)
                    }

                    VStack(spacing: 16) {
                        profileRow(title: "Patient Name", value: "John Patient")
                        profileRow(title: "Patient ID", value: "#P-12345")
                        profileRow(title: "Email", value: "john.patient@example.com")
                        profileRow(title: "Phone", value: "+1 (555) 123-4567")
                    }
                    .padding(20)
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                }
                .padding(20)
            }
            .background(Color(.systemGroupedBackground))
        }
    }

    private func profileRow(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.secondary)
            Text(value)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ProfileView()
}
