% Define o código de escape ANSI para cada cor
cor_codigo(vermelho, "\e[31m").
cor_codigo(verde, "\e[32m").
cor_codigo(amarelo, "\e[33m").
cor_codigo(azul, "\e[34m").
cor_codigo(magenta, "\e[35m").
cor_codigo(ciano, "\e[36m").
cor_codigo(branco, "\e[37m").
cor_codigo(cinza, "\e[90m").
cor_codigo(preto, "\e[30m").
cor_codigo(laranja, "\e[38;5;208m").
cor_codigo(rosa, "\e[38;5;206m").
cor_codigo(roxo, "\e[38;5;93m").
cor_codigo(violeta, "\e[38;5;135m").
cor_codigo(verde_claro, "\e[38;5;83m").
cor_codigo(azul_claro, "\e[38;5;117m").
cor_codigo(reset, "\e[0m").
cor_codigo(negrito, "\e[1m").
cor_codigo(italico, "\e[3m").
cor_codigo(sublinhado, "\e[4m").

% Imprime um texto em uma cor específica
imprimir_cor(Cor, Texto) :-
    cor_codigo(Cor, CodigoCor),
    cor_codigo(reset, CodigoReset),
    write(CodigoCor), write(Texto), write(CodigoReset).
