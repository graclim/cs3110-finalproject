.PHONY: test check

build:
	dune build

utop:
	OCAMLRUNPARAM=b dune utop src

test:
	OCAMLRUNPARAM=b dune exec test/main.exe

play:
	OCAMLRUNPARAM=b dune exec home/home.exe

zip:
	rm -f final.zip
	zip -r final.zip . -x@exclude.lst

clean:
	dune clean
	rm -f final.zip

docs:
	dune build @doc

open-docs:
	LIB="Course_scheduler"; \
	if [[ "$$OSTYPE" == "darwin"* ]]; then \
			open _build/default/_doc/_html/$$LIB/$$LIB/; \
	elif [[ "$$OSTYPE" == "linux-gnu"* ]]; then \
			if [[ -n "$$IS_WSL" || -n "$$WSL_DISTRO_NAME" ]]; then \
					DOCPATH=$$(wslpath -w ./_build/default/_doc/_html/$$LIB/$$LIB/); \
					explorer.exe $${DOCPATH} || true; \
			else \
					xdg-open _build/default/_doc/_html/$$LIB/$$LIB/index.html; \
			fi; \
	fi
