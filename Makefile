# Travel Planner Flutter App Makefile
# Provides convenient commands for development, testing, and deployment

.PHONY: help clean get build test analyze format generate runner dev prod android ios web

# Default target
help:
	@echo "Travel Planner Flutter App - Available Commands:"
	@echo ""
	@echo "Development:"
	@echo "  dev         - Run app in development mode with hot reload"
	@echo "  get         - Install dependencies (flutter pub get)"
	@echo "  upgrade     - Upgrade dependencies to latest versions"
	@echo ""
	@echo "Code Quality:"
	@echo "  analyze     - Run static analysis (flutter analyze)"
	@echo "  format      - Format code (dart format .)"
	@echo "  fix         - Apply automated fixes (dart fix --apply)"
	@echo ""
	@echo "Code Generation:"
	@echo "  generate    - Run code generation (build_runner build)"
	@echo "  runner      - Run build_runner with watch mode"
	@echo "  clean-gen   - Clean generated files before regenerating"
	@echo ""
	@echo "Testing:"
	@echo "  test        - Run all tests"
	@echo "  test-watch  - Run tests in watch mode"
	@echo "  coverage    - Run tests with coverage"
	@echo ""
	@echo "Build & Run:"
	@echo "  build       - Build for release"
	@echo "  build-debug - Build for debugging"
	@echo "  apk         - Build Android APK"
	@echo "  aab         - Build Android App Bundle"
	@echo "  ios         - Build iOS app"
	@echo "  web         - Build web app"
	@echo ""
	@echo "Utilities:"
	@echo "  clean       - Clean build artifacts"
	@echo "  doctor      - Run flutter doctor"
	@echo "  tree        - Show dependency tree"

# Development
get:
	flutter pub get

upgrade:
	flutter pub upgrade

dev:
	flutter run

# Code Quality
analyze:
	flutter analyze

format:
	dart format .

fix:
	dart fix --apply

# Code Generation
generate:
	dart run build_runner build --delete-conflicting-outputs

runner:
	dart run build_runner watch --delete-conflicting-outputs

clean-gen:
	dart run build_runner clean
	dart run build_runner build --delete-conflicting-outputs

# Testing
test:
	flutter test

test-watch:
	flutter test --watch

coverage:
	flutter test --coverage
	genhtml coverage/lcov.info -o coverage/html

# Build & Run
build:
	flutter build apk --release
	flutter build web --release

build-debug:
	flutter build apk --debug
	flutter build web --debug

apk:
	flutter build apk --release

aab:
	flutter build appbundle --release

ios:
	flutter build ios --release

web:
	flutter build web --release

# Utilities
clean:
	flutter clean
	flutter pub get

doctor:
	flutter doctor

tree:
	flutter pub deps --style=tree
