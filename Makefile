.PHONY: update-goldens

update-goldens:
	flutter test --update-goldens --tags=golden
