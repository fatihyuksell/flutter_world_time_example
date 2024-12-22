get:
	flutter pub get

clean:
	flutter clean

clean-get:
	$(MAKE) clean
	$(MAKE) get

cg:
	$(MAKE) clean-get

outdated:
	flutter pub outdated

gen:
	flutter pub run build_runner build --delete-conflicting-outputs