:- [cores].

% Imprime uma lista de receitas, cada uma em uma linha separada
imprimir_receitas([]).
imprimir_receitas([H|T]) :-
    write('- '), writeln(H),
    imprimir_receitas(T).


