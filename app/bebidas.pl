:- dynamic bebida/2.

bebida(caipirinha, [cachaca, limao, acucar, gelo]).
bebida(cuba_libre, [rum, limao, refrigerante_de_cola, gelo]).

% Adiciona uma nova bebida
cadastrar_bebida :-
    write('Digite o nome da bebida: '), nl,
    read(NomeBebida),
    write('Digite a lista de ingredientes da bebida (por exemplo, [cachaça, limão, açúcar, gelo]): '), nl,
    read(ListaIngredientes),
    assertz(bebida(NomeBebida, ListaIngredientes)),
    write('Bebida cadastrada com sucesso!'), nl.

% Lista todas as bebidas cadastradas
listar_bebidas :-
    write('Lista de bebidas cadastradas:'), nl,
    findall(NomeBebida, bebida(NomeBebida, _), Lista),
    imprimir_lista(Lista).

imprimir_lista([]).
imprimir_lista([H|T]) :-
    write(H), nl,
    imprimir_lista(T).
