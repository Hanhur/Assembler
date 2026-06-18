# ======================================================
# Makefile для main.asm
# ======================================================

NAME = main
MASM32 = C:\masm32

# Компилятор и линковщик
ML = $(MASM32)\bin\ml.exe
LINK = $(MASM32)\bin\polink.exe

# Флаги (добавлен /Zi для отладки)
ML_FLAGS = /c /coff /Cp /Zi
LINK_FLAGS = /SUBSYSTEM:WINDOWS /DEBUG

# Файлы
OBJ = $(NAME).obj
EXE = $(NAME).exe

# ---------- ЦЕЛИ ----------

# Сборка по умолчанию
all: $(EXE)

# Линковка
$(EXE): $(OBJ)
	@echo Linking...
	$(LINK) $(LINK_FLAGS) /OUT:$(EXE) $(OBJ)
	@echo Done! File: $(EXE)

# Компиляция
$(OBJ): $(NAME).asm
	@echo Assembling...
	$(ML) $(ML_FLAGS) /Fo$(OBJ) $(NAME).asm

# Очистка
clean:
	@echo Cleaning...
	-if exist $(OBJ) del $(OBJ)
	-if exist $(EXE) del $(EXE)
	-if exist *.pdb del *.pdb
	@echo Ready.

# Запуск
run: $(EXE)
	@echo Launching the program...
	$(EXE)

# Полная пересборка
rebuild: clean all

# ---------- ЗАЩИТА ----------
.PHONY: all clean run rebuild