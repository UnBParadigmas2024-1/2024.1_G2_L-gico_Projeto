% Importa a base de dados de supermercados e produtos
:- consult('supermercados.pl').
:- consult('produtos.pl').
:- consult('economizar_com_produtos.pl').

:- consult('pratos.pl').
:- consult('cores.pl').
:- consult('receitas.pl').
:- consult('operacoes.pl').

limpar_terminal :-
    write('\e[2J').

% Função principal para executar a consulta
menu :-
    limpar_terminal,
    imprimir_cor(amarelo, '===== MENU ====='), nl,
    write('Escolha uma opção:'), nl,
    imprimir_cor(azul, '[1]'), write(' - Economizar com produtos mais baratos'), nl,
    imprimir_cor(azul, '[2]'), write(' - Sugestão de receitas com os ingredientes da sua casa'), nl,
    imprimir_cor(azul, '[3]'), write(' - Cadastrar ou remover receita'), nl,
    imprimir_cor(azul, '[4]'), write(' - Ver lista de pratos'), nl,
    read(Consulta), limpar_terminal,
    executar_consulta(Consulta).

% Executa a consulta com base na opção do usuário
executar_consulta(1) :-
    write('Executando consulta 1...'), nl,
    write('Digite a lista de produtos (como uma lista Prolog, por exemplo, [arroz, leite, feijao, abobora]): '), nl,
    read(ListaProdutos),
    % Testar a função principal
    economizar_com_produtos(ListaProdutos).

executar_consulta(2) :-
    write('Executando consulta 2...'), nl,
    [receitas],[operacoes],

    imprimir_cor(azul, 'Bem-vindo ao sistema de sugestão de receitas!'), nl,
    writeln('Por favor, digite os ingredientes que você possui, um. por. vez. ou [varios, por, vez] em uma lista.'), nl,
    imprimir_cor(cinza, 'Quando terminar, digite '), imprimir_cor(vermelho, 'fim.'), imprimir_cor(cinza, '.'), nl, nl,

    coletar_ingredientes(IngredientesDisponiveis),nl,
    imprimir_cor(ciano, 'Seus ingredientes: '), writeln(IngredientesDisponiveis),
    
    % Consultar as receitas possíveis
    (
        sugerir_receitas(IngredientesDisponiveis, ReceitasPossiveis) ->
        % Exibir as receitas possíveis
        imprimir_cor(verde, 'Receitas que podem ser feitas: '), nl, imprimir_receitas(ReceitasPossiveis), nl
    ;
        % Exibir mensagem de erro
        imprimir_cor(vermelho, 'Não foi possível encontrar receitas com os ingredientes disponíveis.'), nl, nl,
        imprimir_cor(azul, 'Você deseja ver receitas possíveis que faltam ingredientes? (sim./nao.): '), ver_mais_receitas(IngredientesDisponiveis)
    ).


executar_consulta(3) :-
    write('Executando consulta 3...'), nl,
    listar_receitas,
    write('Você deseja adicionar ou remover uma receita? (adicionar/remover): '), nl,
    read(Operacao),
    gerenciar_receitas(Operacao).

% executar_consulta(3) :-
%    write('Executando consulta 3 - Cadastrar novo prato...'), nl,
%    cadastrar_novo_prato.

executar_consulta(4) :-
    write('Executando consulta 4 - Ver lista de pratos...'), nl,
    listar_receitas.

executar_consulta(_) :-
    imprimir_cor(vermelho, 'Opção inválida!'), nl, nl, menu.