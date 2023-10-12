;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    functions.el                                       :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: smonroe <smonroe@student.42.fr>            +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2018/10/08 21:39:29 by smonroe           #+#    #+#              ;
;    Updated: 2020/03/31 11:19:49 by smonroe          ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;All of my custom function

;Prevent anger and resentment towards emacs' tab key functionality
(defun tabber ()
	"Tab key override since smart indentation is dumb"
	(interactive)
	(insert "  ")
)
;(global-set-key (kbd "TAB") 'tabber)

;Fix clear in eshell
(defun eshell/clear ()
	(let ((eshell-buffer-maximum-lines 0))
		   (eshell-truncate-buffer))
)

;as top of file junk insert
(defun asm-header ()
	"Insert basic assembly junk"
	(interactive)
	(insert ".section .data\n\n")
	(insert ".section .text\n\n")
	(insert ".globl _start\n\n")
	(insert "_start:\n")
)
;(global-set-key (kbd "C-c a") 'asm-header)

;as function declaration and stack management junk insert
(defun	asm-func (name)
	"Insert standard x_86 assembly function stuff"
	(interactive "sFunction name: ")
	(insert	".type\t"name", @function\n\n")
	(insert	name":\n")
	(insert	"\tpushl\t%ebp\t\t\t#save base pointer on stack\n")
	(insert "\tmovl\t%esp, %ebp\t\t#save stack pointer in base\n")
	(insert "\n_end:\n\tmovl\t%ebp, %esp\t\t#restore stack pointer from base\n")
	(insert "\tpopl\t%ebp\t\t\t#restore base pointer from stack\n")
	(insert "\tret\t\t\t\t\t\t#return eax to caller\n")
)
;(global-set-key (kbd "C-c f") 'asm-func)

;Makefile autogen
(defun mymakefile ()
	"Makefile Insertion"
	(interactive)
	(insert "NAME = \n\n")
	(insert "SRC = \n\n")
	(insert "CC = gcc -Wall -Werror -Wextra\n\n")
	(insert "all: $(NAME)\n\n")
	(insert "$(NAME):\n\t$(CC) $(SRC) -o $(NAME)\n\n")
	(insert "clean:\n\t/bin/rm -rf *~ \\#*\\# a.out *.swp *.gch\n\n")
	(insert "fclean: clean\n\t/bin/rm -rf $(NAME)\n\n")
	(insert "re: fclean all\n\n")
	(insert "fsan:\n\t$(CC) $(SRC) -o $(NAME) -g -fsanitize=address\n\n")
)
;(global-set-key (kbd "C-c m") 'mymakefile)

;Coplien form for c++ class files
(defun hpp (name)
 	"Add Coplien form to .hpp for C++ class painlessly"
	(interactive "sClass name: ")
	(insert "\n#ifndef "(upcase name)"_H\n# define "(upcase name)"_H\n")
	(insert "# include <iostream>\n# include <string>\n# include <vector>\n\n")
	(insert "class "name" {\n\npublic:\n")
	(insert "\t"name"( void );\n")
	(insert "\t"name"( "name" const & );\n")
	(insert "\t~"name"( void );\n")
	(insert "\t"name"& operator=( "name" const & );\n")
	(insert "\nprivate:\n\n};\n\n#endif\n")
)

(defun cpp (name)
 	"Add Coplien form to .cpp for C++ class painlessly"
	(interactive "sClass name: ")
	(insert "\n#include \""name".hpp\"\n\n")
	(insert name"::"name"( void ) { }\n")
	(insert name"::"name"( "name" const & cpy) { *this = cpy; }\n")
	(insert name"::~"name"( void ) { }\n")
	(insert name"& "name"::operator=( "name" const & equ) { return *this; }\n")
)

(defun class (name)
 	"Default Coplien Form"
	(interactive "s: ")
	(if (equal (file-name-extension(buffer-file-name)) "hpp")
		(hpp name))
	(if (equal (file-name-extension(buffer-file-name)) "cpp")
		(cpp name))
)
;(global-set-key (kbd "C-c c") 'class)

;Coplien form for nested exceptions in classes
(defun hppexc (name nest)
 	"Add Coplien form to .hpp for C++ class painlessly"
	(interactive "sClass name: \nsNested in: ")
	(insert "\tclass EXC_"name" : public std::exception {\n\tpublic:\n")
	(insert "\t\tEXC_"name"( void );\n")
	(insert "\t\tEXC_"name"( EXC_"name" const & );\n")
	(insert "\t\t~EXC_"name"( void ) throw();\n")
	(insert "\t\tEXC_"name"& operator=( EXC_"name" const & );\n")
	(insert "\t\tvirtual const char* what() const throw();\n")
	(insert "\t};\n")
)

(defun cppexc (name nest)
 	"Add Coplien form to .cpp for C++ class painlessly"
	(interactive "sClass name: \nsNested in: ")
	(insert nest"::EXC_"name"::EXC_"name"( void ) { }\n")
	(insert nest"::EXC_"name"::EXC_"name"( EXC_"name" const & cp) { *this = cp; }\n")
	(insert nest"::EXC_"name"::~EXC_"name"( void ) throw() { }\n")
	(insert nest"::EXC_"name"& "nest"::EXC_"name"::operator=( EXC_"name" const &) { return *this; }\n")
	(insert "const char* "nest"::EXC_"name"::what( void ) const throw() {\n\treturn \"ERR_MSG\";\n}\n")
)

(defun eclass (name nest)
	"Exception Coplien Form"
	(interactive "sException Name: \nsNested in class: ")
	(if (equal (file-name-extension(buffer-file-name)) "hpp")
		(hppexc name nest))
	(if (equal (file-name-extension(buffer-file-name)) "cpp")
		(cppexc name nest))
)
;(global-set-key (kbd "C-c e") 'eclass)
