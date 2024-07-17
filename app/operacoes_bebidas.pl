:- [cores].
:- consult('bebidas.pl').

% Cadastra uma nova bebida
adicionar_bebida :-
    write('Digite o nome da bebida: '), nl,
    read(NomeBebida),
    write('Digite a lista de ingredientes da bebida (por exemplo, [cachaça, limão, açúcar, gelo]): '), nl,
    read(ListaIngredientes),
    assertz(bebida(NomeBebida, ListaIngredientes)),
    write('Bebida cadastrada com sucesso!'), nl.

% Mostra a lista de todas as bebidas cadastradas
ver_bebidas :-
    write('Lista de bebidas cadastradas:'), nl,
    listar_bebidas.

% Sugere bebidas baseadas nos ingredientes disponíveis
sugere_bebidas(IngredientesDisponiveis) :-
    findall(NomeBebida, (
        bebida(NomeBebida, IngredientesNecessarios),
        subset(IngredientesNecessarios, IngredientesDisponiveis)
    ), Sugestoes),
    imprimir_lista(Sugestoes).

% Adiciona a bebida ao menu de operações
menu_bebidas :-
    write('Escolha uma opção:'), nl,
    write('[1] - Cadastrar nova bebida'), nl,
    write('[2] - Ver lista de bebidas'), nl,
    write('[3] - Sugerir bebidas com ingredientes disponíveis'), nl,
    read(Opcao),
    ( Opcao = 1 -> adicionar_bebida ;
      Opcao = 2 -> ver_bebidas ;
      Opcao = 3 -> (
          write('Digite a lista de ingredientes disponíveis (por exemplo, [cachaça, limão]): '), nl,
          read(ListaIngredientesDisponiveis),
          sugere_bebidas(ListaIngredientesDisponiveis)
      ) ;
      write('Opção inválida!'), nl,
      menu_bebidas
    ).
