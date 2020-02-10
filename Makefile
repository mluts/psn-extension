ELM_MAKE = $(if $(optimize),elm make --optimize,elm make)

menu_js_optimized: optimize = true

default: menu_js

release: menu_js_optimized manifest.json psn-icon*
	web-ext build -i package-lock.json Makefile 'elm/elm-stuff' 'elm/elm.json' 'elm/src'

run: menu_js
	web-ext run

menu_js: elm/menu.js

menu_js_optimized: elm/menu.js

elm/menu.js: $(wildcard elm/src/**.elm) elm/elm.json
	cd elm && $(ELM_MAKE) src/Main.elm --output=menu.js

clean:
	rm -f elm/menu.js
	rm -f web-ext-artifacts/*.zip

.PHONY: clean
