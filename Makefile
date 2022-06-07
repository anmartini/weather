PLATFORM_IOS = iOS Simulator,name=iPhone 13

format:
	swift format \
		--ignore-unparsable-files \
		--in-place \
		--recursive \
		./Sources ./Tests ./App Package.swift \
		--configuration swift-format.json

test:
	@xcodebuild test \
		-project App/weathER.xcodeproj \
		-scheme weathER \
		-destination platform="$(PLATFORM_IOS)"

generate:
	swiftgen

assets:
	swiftgen 
