:- use_module(library(lists)).

cadastrar_bebida :-
    write('Digite o nome da bebida: '),
    read(Nome),
    write('Digite a lista de ingredientes da bebida (por exemplo, [rum, limão, hortelã, açúcar, água_soda, gelo]): '),
    read(Ingredientes),
    assertz(bebida(Nome, Ingredientes)),
    write('Bebida cadastrada com sucesso!'), nl, nl.

imprimir_bebidas(ListaBebidas) :-
    ( ListaBebidas = [] ->
        imprimir_cor(vermelho, 'Nenhuma bebida cadastrada.'), nl
    ;   imprimir_bebidas_aux(ListaBebidas)
    ).

imprimir_bebidas_aux([]).
imprimir_bebidas_aux([H|T]) :-
    imprimir_cor(verde, H), nl,
    imprimir_bebidas_aux(T).

mostrar_lista_bebidas :-
    findall(Nome, bebida(Nome, _), ListaBebidas),
    imprimir_bebidas(ListaBebidas).

sugere_bebidas(IngredientesDisponiveis) :-
    findall(
        NomeBebida,
        (
            bebida(NomeBebida, IngredientesNecessarios),
            lists:subset(IngredientesNecessarios, IngredientesDisponiveis)
        ),
        BebidasPossiveis
    ),
    (   BebidasPossiveis = [] ->
        imprimir_cor(vermelho, 'Nenhuma bebida encontrada com os ingredientes disponíveis.'), nl
    ;   imprimir_sugestoes_bebidas(BebidasPossiveis)
    ).

imprimir_sugestoes_bebidas([]).
imprimir_sugestoes_bebidas([H|T]) :-
    imprimir_cor(verde, H), nl,
    imprimir_sugestoes_bebidas(T).

voltar_ao_menu :-
    write('Digite "menu." para voltar ao menu principal ou qualquer outra tecla para sair.'), nl,
    read(Opcao),
    ( Opcao = menu -> menu ; true ).

gerenciar_bebidas(1) :-
    cadastrar_bebida,
    voltar_ao_menu.

gerenciar_bebidas(2) :-
    mostrar_lista_bebidas,
    voltar_ao_menu.

gerenciar_bebidas(3) :-
    write('Digite a lista de ingredientes disponíveis (por exemplo, [rum, limão, hortelã, açúcar, água_soda, gelo]): '),
    read(IngredientesDisponiveis),
    sugere_bebidas(IngredientesDisponiveis),
    voltar_ao_menu.
