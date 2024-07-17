:- dynamic bebida/2.

bebida(caipirinha, [cachaca, limao, acucar, gelo]).
bebida(cuba_libre, [rum, limao, refrigerante_de_cola, gelo]).

listar_bebidas :-
    write('Lista de bebidas cadastradas:'), nl,
    findall(NomeBebida, bebida(NomeBebida, _), Lista),
    imprimir_lista(Lista).

imprimir_lista([]).
imprimir_lista([H|T]) :-
    write(H), nl,
    imprimir_lista(T).