BUILD_DIR := dist
TOOLS := $(wildcard */)
TOOLS := $(patsubst %/,%,$(TOOLS))

.PHONY: all clean

all: $(TOOLS)

$(TOOLS):
	@echo "Building $@ ..."
	@if [ -f "$@/build.sh" ]; then \
		cd $@ && sh build.sh; \
	elif [ -f "$@/main.go" ]; then \
		cd $@ && GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o ../$(BUILD_DIR)/$@ main.go; \
	else \
		echo "No build.sh or main.go found in $@, skipping"; \
	fi
	@touch .built_$@
	@echo "Done: $@"

clean:
	@echo "Cleaning build outputs..."
	@rm -rf $(BUILD_DIR) .built_*