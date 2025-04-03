# ******************************* TOOL MACROS ******************************** #

CC              = cc
CFLAGS          = -Wall -Wextra -Werror
CPPFLAGS        = -I./includes
LDFLAGS         = -framework Cocoa
LDLIBS          =

# ******************************* PATH MACROS ******************************** #

OBJ_PATH := obj
SRC_PATH := src

# ******************************* FILE CONFIG ******************************** #

TARGET_NAME := software_renderer
ifeq ($(OS),Windows_NT)
	TARGET_NAME := $(addsuffix .exe,$(TARGET_NAME))
endif

# src files & obj files
SRC := $(foreach x, $(SRC_PATH), $(wildcard $(addprefix $(x)/*,.c*)))
OBJ := $(addprefix $(OBJ_PATH)/, $(addsuffix .o, $(notdir $(basename $(SRC)))))

# clean files list
CLEAN_LIST := $(TARGET) \
				$(OBJ)

# ****************************** BUILD TARGETS ******************************* #

$(TARGET): $(OBJ)
	$(CC) -o $@ $(OBJ) $(CFLAGS)

$(OBJ_PATH)/%.o: $(SRC_PATH)/%.c*
	$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ $<

# ****************************** BUILD RULES ********************************* #

default: make all

all: $(TARGET)
	@mkdir -p $(OBJ_PATH)

# ******************************** CLEANUP *********************************** #

clean:
	@echo CLEAN $(CLEAN_LIST)
	@rm -f $(CLEAN_LIST)

re:
	make clean
	make all

# ********************************* TESTS ************************************ #

test:
	./$(TARGET_NAME)/

# ******************************* PHONY RULES ******************************** #

.PHONY: all clean re test
