CC = clang
CFLAGS = -Wall -Wextra -Werror -pedantic -std=c23 -fsanitize=address

SRCS = $(wildcard src/*.c)
OBJS = $(patsubst src/%.c,build/%.o,$(SRCS))

SRC_DIR = src
OBJ_DIR = build
EXEC = kilo

$(EXEC): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

run: $(EXEC)
	./$(EXEC)

fmt:
	clang-format -style=LLVM -i $(SRCS)

clean:
	rm -rf $(OBJ_DIR) $(EXEC)

.PHONY: run fmt clean
