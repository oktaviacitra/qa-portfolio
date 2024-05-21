import SwiftUI
import XCTest

final class OnboardingViews_UITest: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = [UITestingHelper.isTestingKey]
        app.launchEnvironment = [UITestingHelper.stressTestNumberKey: "10000"]
        
        app.launch()
    }
    
    override func tearDown()  {
        super.tearDown()
        app = nil
    }
    
    func evaluateDetail() throws {
        // Given
        let filenames = ["red", "green", "blue"]
        let titles = ["Reddie cake", "Greenie cake", "Blueie cake"]
        let descriptions = "small cake designed to serve one person, which may be baked in a small thin paper or aluminum cup"
        
        measure(metrics: [XCTCPUMetric(application: app),
                          XCTMemoryMetric(application: app)]) {
            
            ForEach(0 ..< titles.count, id: \.self) { i in
                // Then
                XCTAssert(app.staticTexts[titles[i]].exists)
                XCTAssert(app.staticTexts[descriptions].exists)
                
                // When
                app.buttons["Next"].tap()
            }
        }
    }
    
}

struct OnboardingViews: View {
    @AppStorage("id") var id = 0
    var filenames: [String]
    var shorTexts: [String]
    var longTexts: [String]
    
    var body: some View {
        ZStack {
            OnboardingView(filename: filenames[id],
                           shortText: shorTexts[id],
                           longText: longTexts[id],
                           size: filenames.count)
        }
    }
}

struct OnboardingView: View {
    var filename: String
    var shortText: String
    var longText: String
    var size: Int
    
    var body: some View {
        VStack {
            topSection
            
            Spacer()
            
            picture
            
            description
            
            nextButton
        }
        .padding()
    }
    
    var nextButton: some View {
        Button(action: {
            if id < size {
                id += 1
            } else {
                id = 0
            }
        }, label: {
            Text("Next").foregroundColor(Color.white)
        })
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 55)
        .background(Color(hue: 1.0, saturation: 0.688, brightness: 0.986))
        .cornerRadius(55/2)
    }
    
    var topSection: some View {
        HStack {
            title1
            Spacer()
            skipButton
        }
    }
    
    var description: some View {
        Text(longText)
            .font(.body)
            .fontWeight(.regular)
            .multilineTextAlignment(.center)
            .padding
    }
    
    var title2: some View {
        Text(shortText)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(Color(hue: 1.0, saturation: 0.688, brightness: 0.986))
            .kerning(1.2)
    }
    
    var picture: some View {
        Image(filename)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 300)
            .padding
    }
    
    
    var title1: some View {
        Text("Hello Foodies")
            .fontWeight(.semibold)
            .font(.title)
    }
    
    var skipButton: some View {
        Button(action: {},
               label:{
            Text("SKIP")
                .fontWeight(.semibold)
                .kerning(1.2)
                .foregroundColor(Color.black)
        })
    }
}
