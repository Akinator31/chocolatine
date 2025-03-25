##
## EPITECH PROJECT, 2025
## Makefile
## File description:
## Makefile for my_world project
##

SRC	=	main.c

TEST_SRC	=	tests/test.c

OBJ =	$(SRC:.c=.o)

OBJ_TEST	=	$(TEST_SRC:.c=.o)

NAME = a.out

TEST_NAME = tests_bin

CC	=	clang

all:	$(NAME)

$(NAME):	$(OBJ)
	$(CC) -o $(NAME) $(OBJ)

tests_run:	$(OBJ_TEST)
	$(CC) -o $(TEST_NAME) $(OBJ_TEST) -lcriterion
	./$(TEST_NAME)

clean:
	rm -f $(OBJ)
	rm -f $(OBJ_TEST)

fclean: clean
	rm -f $(NAME)
	rm -f $(TEST_NAME)

re: fclean all
