import SwiftUI

enum TabItem: String, CaseIterable {
    case animals
    case sales
    case statistics
    
    var iconOn: String {
        switch self {
        case .animals: return "animalOn"
        case .sales: return "salesOn"
        case .statistics: return "statisticOn"
        }
    }
    
    var iconOff: String {
        switch self {
        case .animals: return "animalOff"
        case .sales: return "salesOff"
        case .statistics: return "statisticOff"
        }
    }
}

struct BottomBar: View {
    @Binding var selectedTab: TabItem
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabItem.allCases, id: \.self) { tab in
                Button(action: {
                    selectedTab = tab
                }) {
                    Image(selectedTab == tab ? tab.iconOn : tab.iconOff)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight * 0.065)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(height: screenHeight * 0.08)
        .background(Color("color_3"))
    }
}

#Preview {
    BottomBar(selectedTab: .constant(.animals))
}
