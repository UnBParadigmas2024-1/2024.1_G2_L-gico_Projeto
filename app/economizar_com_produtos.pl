% Encontra o mercado mais barato para cada produto, considerando a avaliação em caso de empate
encontrar_mercado_mais_barato(Produto, MelhorMercado, MelhorPreco) :-
    findall((Preco, Avaliacao, Mercado), (produto(Mercado, Produto, Preco), supermercado(Mercado, Avaliacao)), Lista),
    sort(Lista, [(MelhorPreco, _, MelhorMercado)|_]).

% Função para economizar com produtos mais baratos
economizar_com_produtos(ListaProdutos) :-
    economizar_com_produtos(ListaProdutos, [], [], 0).

economizar_com_produtos([], Comprados, Faltando, TotalGasto) :-
    mostrar_resultados(Comprados),
    write(TotalGasto), nl,
    (Faltando \= [] -> write('Os mercados estão sem estoque para os seguintes itens: '), write(Faltando), nl ; true).
    
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

% Executa a consulta e mostra os resultados
mostrar_resultados([]) :-
    write('Total gasto: R$').
mostrar_resultados([(_, [], _)|Restante]) :-
    mostrar_resultados(Restante).
mostrar_resultados([(Mercado, Produtos, _)|Restante]) :-
    write('Vá até o '), write(Mercado), write(' e compre os seguintes itens: '), write(Produtos), nl,
    mostrar_resultados(Restante).