ELM_MAKE = $(if $(optimize),elm make --optimize,elm make)

menu_js_optimized: optimize = true

default: menu_js

release: menu_js_optimized manifest.json
	web-ext build -i package-lock.json Makefile 'src/menu/elm-stuff' 'src/menu/elm.json' 'src/menu/src'

run: menu_js
	web-ext run

menu_js: src/menu/menu.js

menu_js_optimized: src/menu/menu.js

src/menu/menu.js: $(wildcard src/menu/src/**.elm) src/menu/elm.json
	cd src/menu && $(ELM_MAKE) src/Main.elm --output=menu.js

clean:
	rm src/menu/menu.js
	rm web-ext-artifacts/*.zip

.PHONY: clean
