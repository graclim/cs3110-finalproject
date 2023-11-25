# # Makefile

# # Define compiler
# OCAMLC=ocamlfind ocamlc
# OCAMLFLAGS=-package yojson,ounit2 -linkpkg -g

# # Define source and test directories
# SRC_DIR=src
# TEST_DIR=test

# # Define source and test files
# SOURCES=$(SRC_DIR)/courses.ml $(SRC_DIR)/interface.ml $(SRC_DIR)/scheduler.ml $(SRC_DIR)/users.ml
# TESTS=$(TEST_DIR)/main.ml

# # Define your test executable name
# TEST_EXECUTABLE=test_scheduler

# # Default target
# all: test

# # Compile the source files
# $(SRC_DIR)/%.cmo: $(SRC_DIR)/%.ml
# 	$(OCAMLC) -c $(OCAMLFLAGS) -o $@ $<

# # Compile the test file and create the executable
# $(TEST_EXECUTABLE): $(SOURCES:.ml=.cmo) $(TESTS)
# 	$(OCAMLC) -o $(TEST_EXECUTABLE) $(OCAMLFLAGS) $(SOURCES:.ml=.cmo) $(TESTS)

# # Run tests
# test: $(TEST_EXECUTABLE)
# 	./$(TEST_EXECUTABLE)

# # Clean up
# clean:
# 	rm -f $(SRC_DIR)/*.cmo $(SRC_DIR)/*.cmi $(TEST_DIR)/*.cmo $(TEST_DIR)/*.cmi $(TEST_EXECUTABLE)

# .PHONY: all clean test

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
