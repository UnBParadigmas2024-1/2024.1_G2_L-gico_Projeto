% Importa a base de dados de supermercados e produtos
:- consult('supermercados.pl').
:- consult('economizar_com_produtos.pl').

% Função principal para executar a consulta
menu :-
    write('Escolha uma opção:'), nl,
    write('1 - Economizar com produtos mais baratos'), nl,
    write('2 - Consulta 2'), nl,
    write('3 - Consulta 3'), nl,
    read(Consulta),
    executar_consulta(Consulta).

% Executa a consulta com base na opção do usuário
executar_consulta(1) :-
    write('Executando consulta 1...'), nl,
    write('Digite a lista de produtos (como uma lista Prolog, por exemplo, [arroz, leite, feijao, abobora]): '), nl,
    read(ListaProdutos),
    economizar_com_produtos(ListaProdutos).

executar_consulta(2) :-
    write('Executando consulta 2...'), nl.

executar_consulta(3) :-
    write('Executando consulta 3...'), nl.

executar_consulta(_) :-
    write('Opção inválida!'), nl.

% Ler dados do arquivo e preencher a base de dados
carregar_pratos :-
    open('dados_pratos.txt', read, Str),
    ler_pratos(Str),
    close(Str).

ler_pratos(Str) :-
    read(Str, Term),
    ( Term == end_of_file ->
        true
    ; assertz(Term),
      ler_pratos(Str)
    ).

% Exemplo de consulta que mostra pratos e produtos necessários
consulta_prato(Prato) :-
    prato(Prato, Produtos),
    write('Para preparar '), write(Prato), write(' você precisará de: '), nl,
    listar_produtos(Produtos).

listar_produtos([]).
listar_produtos([H|T]) :-
    write('- '), write(H), nl,
    listar_produtos(T).

% Adicionar um novo prato
adicionar_prato(Prato, Produtos) :-
    assertz(prato(Prato, Produtos)),
    open('dados_pratos.txt', append, Str),
    write_term(Str, prato(Prato, Produtos), [fullstop(true), nl(true)]),
    close(Str).

% Listar todos os pratos da base de dados
listar_pratos :-
    findall(Prato, prato(Prato, _), Pratos),
    write('Pratos disponíveis:'), nl,
    listar_pratos_aux(Pratos).

listar_pratos_aux([]).
listar_pratos_aux([H|T]) :-
    write('- '), write(H), nl,
    listar_pratos_aux(T).

main:-
    [receitas],[operacoes],[cores],
    % Definir a lista de ingredientes disponíveis
    % IngredientesDisponiveis = ['ovos', 'sal', 'oleo', 'cebola', 'tomate', 'azeite'],
    % IngredientesDisponiveis = [ovos],

    % Coletar ingredientes do usuário
    imprimir_cor(azul, 'Bem-vindo ao sistema de sugestão de receitas!'), nl,
    writeln('Por favor, digite os ingredientes que você possui, um por vez.'), nl,
    imprimir_cor(cinza, 'Quando terminar, pressione '), imprimir_cor(vermelho, 'Enter'), imprimir_cor(cinza, '.'), nl, nl,
    coletar_ingredientes(IngredientesDisponiveis),
    writeln(IngredientesDisponiveis),
    
    % Consultar as receitas possíveis
    sugerir_receitas(IngredientesDisponiveis, ReceitasPossiveis),
    
    % Exibir as receitas possíveis
    imprimir_cor(verde, 'Receitas que podem ser feitas: '), nl, imprimir_receitas(ReceitasPossiveis), nl.
