:- use_module(library(lists)).
:- [cores].
:- consult('bebidas.pl').
:- consult('supermercados.pl').
:- consult('produtos.pl').
:- consult('economizar_com_produtos.pl').
:- consult('ingredientes.pl').
:- consult('pratos.pl').
:- consult('cores.pl').
:- consult('receitas.pl').
:- consult('operacoes.pl').
:- consult('operacoes_bebidas.pl').

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
    imprimir_cor(azul, '[5]'), write(' - Exportar receitas para um arquivo'), nl,
    imprimir_cor(azul, '[6]'), write(' - Carregar receitas de um arquivo'), nl,
    imprimir_cor(azul, '[7]'), write(' - Listar produtos de um mercado'), nl,
    imprimir_cor(azul, '[8]'), write(' - Cadastrar produtos em mercados'), nl,
    imprimir_cor(azul, '[9]'), write(' - Carregar ingredientes de um arquivo'), nl,
    imprimir_cor(azul, '[10]'), write(' - Cadastrar ingrediente'), nl,
    imprimir_cor(azul, '[11]'), write(' - Listar ingredientes cadastrados'), nl,
    imprimir_cor(azul, '[12]'), write(' - Ver recomendações de pratos com base no meu tipo de dieta e sabor favorito'), nl,
    imprimir_cor(azul, '[13]'), write(' - Cadastrar nova bebida'), nl,
    imprimir_cor(azul, '[14]'), write(' - Ver lista de bebidas'), nl,
    imprimir_cor(azul, '[15]'), write(' - Sugerir bebidas com ingredientes disponíveis'), nl,
    imprimir_cor(azul, '[16]'), write(' - Listar produtos mais baratos e os pratos possíveis'), nl,
    imprimir_cor(azul, '[17]'), write(' - Listar menor preço possível para cada prato'), nl,
    imprimir_cor(azul, '[18]'), write(' - Consultar possíveis por orçamento disponível'), nl,

    read(Consulta), limpar_terminal,
    executar_consulta(Consulta).

% Executa a consulta com base na opção do usuário
executar_consulta(1) :-
    write('Executando consulta 1...'), nl,
    write('Digite a lista de produtos (como uma lista Prolog, por exemplo, [arroz, leite, feijao, abobora]): '), nl,
    read(ListaProdutos),
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

executar_consulta(4) :-
    write('Executando consulta 4 - Ver lista de pratos...'), nl,
    listar_receitas.

executar_consulta(5) :-
    write('Executando consulta 5...'), nl,
    exportar_receitas_para_arquivo.

executar_consulta(6) :-
    write('Executando consulta 6...'), nl,
    carregar_receitas_de_arquivo.

executar_consulta(7) :-
    write('Executando consulta 7...'), nl,
    listar_produtos_mercado.

executar_consulta(8) :-
    write('Executando consulta 8...'), nl,
    cadastrar_produto.

executar_consulta(9) :-
    write('Executando consulta 9...'), nl,
    carregar_ingredientes.

executar_consulta(10) :-
    write('Executando consulta 10...'), nl,
    cadastrar_ingrediente.

executar_consulta(11) :-
    write('Executando consulta 11...'), nl,
    listar_ingredientes.

executar_consulta(12) :-
    write('Executando consulta 12...'), nl,
    ler_e_chamar_recomendacao.

executar_consulta(13) :-
    write('Executando consulta 13...'), nl,
    gerenciar_bebidas(1).

executar_consulta(14) :-
    write('Executando consulta 14...'), nl,
    gerenciar_bebidas(2).

executar_consulta(15) :-
    write('Executando consulta 15...'), nl,
    gerenciar_bebidas(3).

executar_consulta(16) :-
    write('Executando consulta 16...'), nl,
    encontrar_produtos_mais_baratos.

executar_consulta(17) :-
    write('Executando consulta 17...'), nl,
    consulta_precos_pratos.

executar_consulta(18) :-
    write('Executando consulta 18...'), nl,
    write('Digite o seu orçamento disponível: '), nl,
    read(Orcamento),
    consulta_pratos_no_orcamento(Orcamento).

executar_consulta(_) :-
    imprimir_cor(vermelho, 'Opção inválida!'), nl, nl,
    menu.
