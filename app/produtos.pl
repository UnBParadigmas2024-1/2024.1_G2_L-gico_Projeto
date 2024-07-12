listar_produtos([]).
listar_produtos([H|T]) :-
    write('- '), write(H), nl,
    listar_produtos(T).

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

produto(mercado3, arroz, 5.50).
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

produto(mercado7, arroz, 4.70).
produto(mercado7, feijao, 3.70).
produto(mercado7, leite, 3.00).
produto(mercado7, carne, 25.00).
produto(mercado7, pao, 6.00).

produto(mercado8, arroz, 5.10).
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