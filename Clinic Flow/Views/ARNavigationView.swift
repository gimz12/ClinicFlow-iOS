import SwiftUI

struct ARNavigationView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var arEnabled: Bool = true

    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                VStack(spacing: 16) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemGray5))
                            .frame(height: 220)
                        VStack(spacing: 8) {
                            Image(systemName: "arkit")
                                .font(.system(size: 36, weight: .semibold))
                                .foregroundColor(navy)
                            Text("AR Preview")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.secondary)
                        }
                    }

                    Toggle("Enable AR Navigation", isOn: $arEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: navy))

                    Text("Point your camera forward to see directional arrows overlaid on the hallway.")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)

                    Spacer()
                }
                .padding(16)
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

            Text("AR Navigation")
                .font(.system(size: 18, weight: .semibold))

            Spacer()

            Text(" ")
                .frame(width: 42)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }
}

#Preview {
    NavigationStack {
        ARNavigationView()
    }
}
