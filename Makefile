.PHONY : all clean

doc:
	flutter pub global run dartdoc lib/
.PHONY : doc

clean:
	rm -Rf doc/api/*
