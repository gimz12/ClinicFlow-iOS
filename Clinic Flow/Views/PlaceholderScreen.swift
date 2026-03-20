import SwiftUI

struct PlaceholderScreen: View {
    @Environment(\.dismiss) private var dismiss
    let title: String
    var message: String = "This screen is coming soon."

    private let navy = Color(red: 0.10, green: 0.30, blue: 0.42)

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                Text(message)
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)

                Button("Back") {
                    dismiss()
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(navy)
                .cornerRadius(12)
            }
            .padding(24)
        }
    }
}

#Preview {
    NavigationStack {
        PlaceholderScreen(title: "Placeholder")
    }
}
