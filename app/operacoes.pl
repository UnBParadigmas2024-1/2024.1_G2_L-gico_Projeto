:- [cores].

recupera_ingredientes_faltantes(IngredientesDisponiveis, IngredientesFaltantesUnicos) :-
    % Cria uma lista das listas de ingredientes faltantes com o findall em IngredientesFaltantesList
    findall(
        IngredientesFalt,
        (
            selecionado(NomeReceita),
            receita(NomeReceita, IngredientesNecessarios),
            subtract(IngredientesNecessarios, IngredientesDisponiveis, IngredientesFalt)
        ),
        IngredientesFaltantesList
    ),
    % Achata a lista de listas e remove duplicatas usando setof
    setof(Ingrediente, ListaIngredientes^(
        member(ListaIngredientes, IngredientesFaltantesList),
        member(Ingrediente, ListaIngredientes)
    ), IngredientesFaltantesUnicos).

% Conta quantos elementos de uma lista estão presentes em outra lista
conta_ingredientes([], _, 0).
conta_ingredientes([H|T], Ingredientes, Contagem) :-
    member(H, Ingredientes), !,
    conta_ingredientes(T, Ingredientes, Contagem1),
    Contagem is Contagem1 + 1.
conta_ingredientes([_|T], Ingredientes, Contagem) :-
    conta_ingredientes(T, Ingredientes, Contagem).

% Calcula a porcentagem de ingredientes correspondentes
porcentagem_ingredientes(IngredientesDisponiveis, Receita, Porcentagem) :-
    receita(Receita, IngredientesReceita),
    conta_ingredientes(IngredientesReceita, IngredientesDisponiveis, Contagem),
    length(IngredientesReceita, TotalIngredientes),
    TotalIngredientes > 0, % Para evitar divisão por zero
    Porcentagem is (Contagem / TotalIngredientes) * 100.

% Verifica se uma receita pode ser feita com o percentual de ingredientes disponíveis
tem_ingredientes_suficientes(IngredientesDisponiveis, Receita, PorcentagemMinima) :-
    porcentagem_ingredientes(IngredientesDisponiveis, Receita, Porcentagem),
    Porcentagem >= PorcentagemMinima.

% Retorna uma lista de receitas que podem ser feitas com o percentual de ingredientes disponíveis
sugestoes_de_receitas(IngredientesDisponiveis, PorcentagemMinima, SugestoesDeReceitas) :-
    setof(NomeReceita, tem_ingredientes_suficientes(IngredientesDisponiveis, NomeReceita, PorcentagemMinima), SugestoesDeReceitas).

% Menu de interação para ver mais receitas
ver_mais_receitas(IngredientesDisponiveis) :-
    read(Opcao),
    mais_receitas(Opcao, IngredientesDisponiveis).
    
mais_receitas(sim, IngredientesDisponiveis) :-
    imprimir_cor(azul, 'Qual a porcentagem de ingredientes você já quer ter para as receitas que vamos sugerir? (0-100): '),
    read(PorcentagemJaDisponivel), nl, nl,
    sugestoes_de_receitas(IngredientesDisponiveis, PorcentagemJaDisponivel, ReceitasFaltam),
    imprimir_cor(laranja, 'Receitas que faltam ingredientes: '), nl, imprimir_receitas_incompletas(ReceitasFaltam, IngredientesDisponiveis), nl.
mais_receitas(nao, _) :-
    imprimir_cor(azul, 'Obrigado por usar o sistema de sugestão de receitas!'), nl, nl.
mais_receitas(_, IngredientesDisponiveis) :-
    imprimir_cor(vermelho, 'Opção inválida! Digite sim. ou nao. por favor!'), nl, nl, ver_mais_receitas(IngredientesDisponiveis).

% Coleta ingredientes do usuário até que ele digite uma string vazia
coletar_ingredientes(Ingredientes) :-
    % Solicita ao usuário que digite um ingrediente
    write('Digite um ingrediente: '),
    % Lê a entrada do usuário como um átomo
    read(Ingrediente),

    % Verifica se a entrada do usuário é fim
    ( Ingrediente = fim ->
        % Define a lista de ingredientes como vazia para parar a recursão
        nl,nl,Ingredientes = []
    ; 
        % Caso contrário, chama o predicado recursivamente para coletar mais ingredientes
        coletar_ingredientes(Restantes),
        % Verifica se o ingrediente é uma lista
        ( is_list(Ingrediente) ->
            % Adiciona os ingredientes da lista de forma individual à lista de ingredientes coletados
            append(Ingrediente, Restantes, Ingredientes)
        ; 
            % Adiciona o ingrediente atual à lista de ingredientes coletados na cabeça da lista
            Ingredientes = [Ingrediente | Restantes]
        )
    ).

