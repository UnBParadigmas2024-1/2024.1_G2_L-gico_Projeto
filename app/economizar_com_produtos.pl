% Encontra o mercado mais barato para cada produto, considerando a avaliação em caso de empate
encontrar_mercado_mais_barato(Produto, MelhorMercado, MelhorPreco) :-
    findall((Preco, Avaliacao, Mercado), (produto(Mercado, Produto, Preco), supermercado(Mercado, Avaliacao)), Lista),
    sort(Lista, [(MelhorPreco, _, MelhorMercado)|_]).

% Função para economizar com produtos mais baratos
economizar_com_produtos(ListaProdutos) :-
    economizar_com_produtos(ListaProdutos, [], [], 0).

economizar_com_produtos([], Comprados, Faltando, TotalGasto) :-
    % printar apenas Comprados, Faltando e TotalGasto
   write('Comprados: '), write(Comprados), nl,
   write('Faltando: '), write(Faltando), nl,
   write('Total gasto: '), write(TotalGasto), nl.
    
economizar_com_produtos([Produto|Restantes], Comprados, Faltando, TotalGasto) :-
    ( encontrar_mercado_mais_barato(Produto, Mercado, Preco) ->
        ( member((Mercado, Produtos, Custo), Comprados) ->
            NovoCusto is Custo + Preco,
            select((Mercado, Produtos, Custo), Comprados, (Mercado, [Produto|Produtos], NovoCusto), NovoComprados)
        ;
            NovoCusto is Preco,
            NovoComprados = [(Mercado, [Produto], NovoCusto)|Comprados]
        ),
        NovoFaltando = Faltando,
        NovoTotalGasto is TotalGasto + Preco
    ;
        NovoComprados = Comprados,
        NovoFaltando = [Produto|Faltando],
        NovoTotalGasto is TotalGasto
    ),
    economizar_com_produtos(Restantes, NovoComprados, NovoFaltando, NovoTotalGasto).
