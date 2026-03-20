import SwiftUI

struct SupportChatView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var message: String = ""

    private let navy = Color(red: 0.10, green: 0.30, blue: 0.42)

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        chatBubble("Hi! A care coordinator will be with you shortly.", isAgent: true)
                        chatBubble("While you wait, share your visit ID or question.", isAgent: true)
                    }
                    .padding(16)
                }

                messageBar
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

            Text("Live Chat")
                .font(.system(size: 18, weight: .semibold))

            Spacer()

            Text(" ")
                .frame(width: 42)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private var messageBar: some View {
        HStack(spacing: 8) {
            TextField("Type your message", text: $message)
                .textFieldStyle(.roundedBorder)

            Button(action: { message = "" }) {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(navy)
                    .cornerRadius(10)
            }
        }
        .padding(12)
        .background(Color(.systemBackground))
    }

    private func chatBubble(_ text: String, isAgent: Bool) -> some View {
        HStack {
            if isAgent { Spacer().frame(width: 0) } else { Spacer() }

            Text(text)
                .font(.system(size: 13))
                .foregroundColor(isAgent ? .primary : .white)
                .padding(12)
                .background(isAgent ? Color(.systemBackground) : navy)
                .cornerRadius(12)

            if isAgent { Spacer() } else { Spacer().frame(width: 0) }
        }
    }
}

#Preview {
    NavigationStack {
        SupportChatView()
    }
}
