:- [cores].

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

