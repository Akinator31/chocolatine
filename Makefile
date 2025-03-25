##
## EPITECH PROJECT, 2025
## Makefile
## File description:
## Makefile for my_world project
##

SRC	=	main.c

OBJ =	$(SRC:.c=.o)

NAME = a.out

CC	=	clang

all:	$(NAME)

$(NAME):	$(OBJ)
	$(CC) -o $(NAME) $(OBJ)

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME)

re: fclean all
