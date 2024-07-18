% Produtos e preços em cada supermercado
produto(mercado1, arroz, 5.00).
produto(mercado1, feijao, 4.00).
produto(mercado1, leite, 3.00).
produto(mercado1, cafe, 7.00).

produto(mercado2, arroz, 4.50).
produto(mercado2, feijao, 3.50).
produto(mercado2, leite, 3.50).
produto(mercado2, carne, 24.00).
produto(mercado2, pao, 5.50).

produto(mercado3, arroz, 4.50).
produto(mercado3, feijao, 4.50).
produto(mercado3, leite, 2.50).
produto(mercado3, carne, 26.00).
produto(mercado3, pao, 6.50).

produto(mercado4, arroz, 4.80).
produto(mercado4, feijao, 3.80).
produto(mercado4, leite, 3.20).
produto(mercado4, carne, 25.50).
produto(mercado4, pao, 6.20).

produto(mercado5, arroz, 4.30).
produto(mercado5, feijao, 3.30).
produto(mercado5, leite, 3.10).
produto(mercado5, carne, 24.50).
produto(mercado5, pao, 5.80).

produto(mercado6, arroz, 4.20).
produto(mercado6, feijao, 3.20).
produto(mercado6, leite, 3.40).
produto(mercado6, carne, 23.50).
produto(mercado6, pao, 5.70).

produto(mercado7, arroz, 4.20).
produto(mercado7, feijao, 3.70).
produto(mercado7, leite, 3.00).
produto(mercado7, carne, 25.00).
produto(mercado7, pao, 6.00).

produto(mercado8, arroz, 4.20).
produto(mercado8, feijao, 4.10).
produto(mercado8, leite, 2.90).
produto(mercado8, carne, 26.50).
produto(mercado8, pao, 6.30).

produto(mercado9, arroz, 4.60).
produto(mercado9, feijao, 3.60).
produto(mercado9, leite, 3.30).
produto(mercado9, carne, 24.80).
produto(mercado9, pao, 5.90).

produto(mercado10, arroz, 4.40).
produto(mercado10, feijao, 3.40).
produto(mercado10, leite, 3.20).
produto(mercado10, carne, 24.30).
produto(mercado10, pao, 5.60).
produto(mercado10, abobora, 6.00).

:- dynamic produto/3.

% Função para listar produtos de um mercado
listar_produtos_mercado :-
    write('Digite o nome do mercado: '), nl,
    read(Mercado),
    ( produto(Mercado, _, _) ->
        findall((Produto, Preco), produto(Mercado, Produto, Preco), ListaProdutos),
        imprimir_cor(azul, 'Produtos do mercado '), write(Mercado), nl,
        listar_produtos(ListaProdutos)
    ;
        write('Mercado não encontrado!'), nl
    ).

% Função auxiliar para imprimir a lista de produtos
listar_produtos([]).
listar_produtos([(Produto, Preco)|T]) :-
    write('- Produto: '), write(Produto), write(', Preço: '), write(Preco), nl,
    listar_produtos(T).


% Predicado auxiliar para verificar se um produto já está cadastrado em um mercado
produto_existe(Mercado, Produto) :-
    produto(Mercado, Produto, _).

% Função para cadastrar produtos
cadastrar_produto :-
    write('Digite o nome do mercado: '), nl,
    read(Mercado),
    write('Digite o nome do produto: '), nl,
    read(Produto),
    ( produto_existe(Mercado, Produto) ->
        write('Produto já cadastrado nesse mercado!'), nl
    ;
        write('Digite o preço do produto: '), nl,
        read(Preco),
        assertz(produto(Mercado, Produto, Preco)),
        write('Produto cadastrado com sucesso!'), nl
    ).

% Encontra o mercado mais barato para cada produto
encontrar_produtos_mais_baratos :-
    findall((Produto, Preco, Mercado), produto(Mercado, Produto, Preco), ListaProdutos),
    agrupar_por_produto(ListaProdutos, ProdutosAgrupados),
    encontrar_mais_baratos(ProdutosAgrupados, ProdutosMaisBaratos),
    mostrar_produtos_mais_baratos(ProdutosMaisBaratos).
        
% Agrupa produtos pelo seu nome
agrupar_por_produto(ListaProdutos, ProdutosAgrupados) :-
    setof(Produto, Preco^Mercado^member((Produto, Preco, Mercado), ListaProdutos), Produtos),
    agrupar(Produtos, ListaProdutos, ProdutosAgrupados).

agrupar([], _, []).
agrupar([Produto|RestoProdutos], ListaProdutos, [(Produto, Produtos)|Agrupados]) :-
    findall((Preco, Mercado), member((Produto, Preco, Mercado), ListaProdutos), Produtos),
    agrupar(RestoProdutos, ListaProdutos, Agrupados).

% Encontra o produto mais barato de cada grupo
encontrar_mais_baratos([], []).
encontrar_mais_baratos([(Produto, Produtos)|Resto], [(Produto, Preco, Mercado)|MaisBaratos]) :-
    sort(Produtos, [(Preco, Mercado)|_]),
    encontrar_mais_baratos(Resto, MaisBaratos).

% Mostra os produtos mais baratos
mostrar_produtos_mais_baratos([]).
mostrar_produtos_mais_baratos([(Produto, Preco, Mercado)|Resto]) :-
    format('Produto: ~w, Mercado: ~w, Preço: R$~2f~n', [Produto, Mercado, Preco]),
    listar_pratos_por_produto(Produto), nl,
    mostrar_produtos_mais_baratos(Resto).

% Calcula o preço total dos produtos de um prato
preco_total_prato(Prato, ProdutosMaisBaratos, PrecoTotal) :-
    prato(Prato, Ingredientes),
    findall(Preco, (member(Ingrediente, Ingredientes), member((Ingrediente, Preco, _), ProdutosMaisBaratos)), Precos),
    sum_list(Precos, PrecoTotal).

% Lista o preço total de cada prato
listar_precos_pratos(ProdutosMaisBaratos) :-
    findall(Prato, prato(Prato, _), Pratos),
    listar_precos_pratos_aux(Pratos, ProdutosMaisBaratos).

listar_precos_pratos_aux([], _).
listar_precos_pratos_aux([Prato|Restantes], ProdutosMaisBaratos) :-
    preco_total_prato(Prato, ProdutosMaisBaratos, PrecoTotal),
    format('Prato: ~w, Preço total: R$~2f~n', [Prato, PrecoTotal]),
    listar_precos_pratos_aux(Restantes, ProdutosMaisBaratos).

% Exemplo de consulta que mostra pratos e preços totais
consulta_precos_pratos :-
    carregar_pratos,
    findall((Produto, Preco, Mercado), produto(Mercado, Produto, Preco), ListaProdutos),
    agrupar_por_produto(ListaProdutos, ProdutosAgrupados),
    encontrar_mais_baratos(ProdutosAgrupados, ProdutosMaisBaratos),
    listar_precos_pratos(ProdutosMaisBaratos).

% Função para listar pratos dentro do orçamento
listar_pratos_no_orcamento(Orcamento, ProdutosMaisBaratos) :-
    findall((Prato, PrecoTotal), (prato(Prato, _), preco_total_prato(Prato, ProdutosMaisBaratos, PrecoTotal), PrecoTotal =< Orcamento), PratosPossiveis),
    format('Pratos possíveis com orçamento de R$~2f:~n', [Orcamento]),
    listar_pratos_possiveis(PratosPossiveis).

listar_pratos_possiveis([]).
listar_pratos_possiveis([(Prato, PrecoTotal)|Restantes]) :-
    format('Prato: ~w, Preço total: R$~2f~n', [Prato, PrecoTotal]),
    listar_pratos_possiveis(Restantes).

% Consulta exemplo para listar pratos dentro do orçamento
consulta_pratos_no_orcamento(Orcamento) :-
    encontrar_produtos_mais_baratos,
    shell('clear'),
    findall((Produto, Preco, Mercado), produto(Mercado, Produto, Preco), ListaProdutos),
    agrupar_por_produto(ListaProdutos, ProdutosAgrupados),
    encontrar_mais_baratos(ProdutosAgrupados, ProdutosMaisBaratos),
    listar_pratos_no_orcamento(Orcamento, ProdutosMaisBaratos).