get:
	fvm flutter pub get

clean:
	fvm flutter clean

clean-get:
	$(MAKE) clean
	$(MAKE) get

cg:
	$(MAKE) clean-get

outdated:
	fvm flutter pub outdated

gen:
	fvm flutter pub run build_runner build --delete-conflicting-outputs