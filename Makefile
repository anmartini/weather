PLATFORM_IOS = iOS Simulator,name=iPhone 13

format:
	swift format \
		--ignore-unparsable-files \
		--in-place \
		--recursive \
		./Sources ./Tests ./App Package.swift \
		--configuration swift-format.json

generate:
	swiftgen

assets:
	swiftgen 
