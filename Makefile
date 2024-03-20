build: clean
	soupault

index:
	soupault --index-only

clean:
	rm -rf build

serve: 
	python3 -m http.server --directory build
