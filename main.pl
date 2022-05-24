:- ['BNF'].
:- ['Database'].

pe([X|_], X).

primer_elemento([X|_], X).
primer_elemento([],X):- X=''.

igualdad(X,X).

%Borrar un elemento de una lista
eliminar_elemento_lista(_, [], []).
eliminar_elemento_lista(Y, [Y|Xs], Zs):-
          eliminar_elemento_lista(Y, Xs, Zs), !.
eliminar_elemento_lista(X, [Y|Xs], [Y|Zs]):-
          eliminar_elemento_lista(X, Xs, Zs).

% REVISA LA ENTRADA DE EMERGENCIA O SALUDO
revisar_situacion(X):-primer_elemento(X,Z), es_saludo(X, Z), segunda_entrada_S(Y).
revisar_situacion(X):-primer_elemento(X,Z), es_emergencia(X, Z), segunda_entrada_E(Y).

es_saludo(Lista, Variable):-saludoB(Variable),!.
es_saludo(Lista, Variable):-eliminar_elemento_lista(Variable,Lista,NLista), primer_elemento(NLista, Z), es_saludo(NLista,Z).
es_saludo([], Variable):-write('No entedi su mensaje.'), nl, primer_entrada(X),!.

es_emergencia(Lista, Variable):-solicitud_emergenciaB(Variable),!.
es_emergencia(Lista, Variable):-eliminar_elemento_lista(Variable,Lista,NLista), primer_elemento(NLista, Z), es_emergencia(NLista,Z).
es_emergencia([], Variable):-write('No entedi su mensaje.'), nl, primer_entrada(X),!.

% REVISA LA ENTRADA DE SOLICITUD DESPEGAR O ATERRIZAR
revisar_solicitud(X):-primer_elemento(X,Z), es_aterrizaje(X,Z), tercera_entrada_S(Y,1).
revisar_solicitud(X):-primer_elemento(X,Z), es_despegar(X,Z), tercera_entrada_S(Y,2).

es_aterrizaje(Lista, Variable):-aterrizar(Variable),!.
es_aterrizaje(Lista, Variable):-eliminar_elemento_lista(Variable,Lista,NLista), pe(NLista, Z), es_aterrizaje(NLista,Z).
es_aterrizaje([], Variable):-write('No indico la solicitud correctamente.'), nl, segunda_entrada_S(X),!.

es_despegar(Lista, Variable):-despegar(Variable),!.
es_despegar(Lista, Variable):-eliminar_elemento_lista(Variable,Lista,NLista), pe(NLista, Z), es_despegar(NLista,Z).
es_despegar([], Variable):-write('No indico la solicitud correctamente.'), nl, segunda_entrada_S(X),!.

% REVISA LA IDENTIFICACION DEL AVION
revisar_id(X,Y):-pe(X,Z), es_matricula(X,Z,[],X,Y).
revisar_id2(X,Y,L):-pe(X,Z), es_aeronave(X,Z,T,Y), cuarta_entrada_S(W,Y,L,T).

es_matricula(Lista,Variable,L,X,Y):-length(L,4), revisar_id2(X,Y,L),!.
es_matricula(Lista,Variable,L,X,Y):-matriculaB(Variable), append(L, [Variable], W), eliminar_elemento_lista(Variable,Lista,NLista), primer_elemento(NLista, Z), es_matricula(NLista,Z,W,X,Y).
es_matricula(Lista,Variable,L,X,Y):-not(length(Lista,0)), not(matriculaB(Variable)), eliminar_elemento_lista(Variable,Lista,NLista), primer_elemento(NLista, Z), es_matricula(NLista,Z,L,X,Y).
es_matricula([],'',L,X,Y):-not(length(L,4)), write('No indico la matricula correctamente, identifiquese de nuevo.'), nl, tercera_entrada_S(G,Y),!.

es_aeronave(Lista,Variable,Pista,Y):-aeronaves_dobles(Variable), eliminar_elemento_lista(Variable,Lista,NLista), primer_elemento(NLista, Z), atom_concat(Variable,Z,J), es_aeronave(NLista,J,Pista,Y).
es_aeronave(Lista,Variable,Pista,Y):-aeronaves_pequenas(Variable), Pista='P1',!.
es_aeronave(Lista,Variable,Pista,Y):-aeronaves_medianas(Variable), Pista='P2',!.
es_aeronave(Lista,Variable,Pista,Y):-aeronaves_grandes(Variable), Pista='P3',!.
es_aeronave(Lista,Variable,Pista,Y):-not(length(Lista,0)), eliminar_elemento_lista(Variable,Lista,NLista), primer_elemento(NLista, Z), es_aeronave(NLista,Z,Pista,Y).
es_aeronave([],'',_,Y):-write('No indico la aeronave correctamente, identifiquese de nuevo.'), nl, tercera_entrada_S(X,Y),!.

% REVISA LA HORA DE SALIDA
revisar_hora(X,Y,L,T):-pe(X,Z), es_hora(X,Z,Y,L,T,W), T=='P2', quinta_entrada_S(Q,Y,L,T,W).
revisar_hora(X,Y,L,T):-pe(X,Z), es_hora(X,Z,Y,L,T,W), (T=='P1';T=='P3'), asignar_pista(L,T,W).

es_hora(Lista,Variable,Y,L,T,W):-hora(Z), W=Variable,!.
es_hora(Lista,Variable,Y,L,T,W):-eliminar_elemento_lista(Variable,Lista,NLista), pe(NLista, Z), es_hora(NLista,Z,Y,L,T,W).
es_hora([],Variable,Y,L,T,W):-write('No indico la hora correctamente'), cuarta_entrada_S(X,Y,L,T).

% REVISA LA DIRECCION DE SALIDA O LLEGADA
revisar_direccion(X,Y,L,T,W):-pe(X,Z), es_direccion(X,Z,Y,L,T,W).

es_direccion(Lista,Variable,Y,L,T,W):-Variable=='este', Y==1, T=='P2', asignar_pista(L,'P2-1',W),!.
es_direccion(Lista,Variable,Y,L,T,W):-Variable=='oeste', Y==1, T=='P2', asignar_pista(L,'P2-2',W),!.
es_direccion(Lista,Variable,Y,L,T,W):-Y==1, T=='P1', asignar_pista(L,'P1',W),!.
es_direccion(Lista,Variable,Y,L,T,W):-Y==1, T=='P3', asignar_pista(L,'P3',W),!.
es_direccion(Lista,Variable,Y,L,T,W):-Variable=='este', Y==2, asignar_pista(L,'P2-1',W),!.
es_direccion(Lista,Variable,Y,L,T,W):-Variable=='oeste', Y==2, asignar_pista(L,'P2-1',W),!.
es_direccion(Lista,Variable,Y,L,T,W):-not(length(Lista,0)), eliminar_elemento_lista(Variable,Lista,NLista), pe(NLista, Z), es_hora(NLista,Z,Y,L,T,W).
es_direccion([],Variable,Y,L,T,W):-write('No indico la direccion correctamente'), Y==2, quinta_entrada_S(X,Y,L,T,W),!.
es_direccion([],Variable,Y,L,T,W):-write('No indico la direccion correctamente'), Y==1, cuarta_entrada_S(X,Y,L,T),!.

% SE ASIGNA LA PISTA CORRESPONDIENTE A LA SOLICITADA
asignar_pista(Matricula,Pista,Hora):-Hora=='', Pista=='P1', asignar_horaP1(X), asserta(vuelosP1(Matricula,X)), write('Su pista asignada es la P1, por favor disminuya su velocidad para que logre aterrizar a las '), write(X), sexta_entrada(Y).
asignar_pista(Matricula,Pista,Hora):-Hora=='', Pista=='P2-1', asignar_horaP2_1(X), asserta(vuelosP21(Matricula,X)),write('Su pista asignada es la P2-1, por favor disminuya su velocidad para que logre aterrizar a las '), write(X), sexta_entrada(Y).
asignar_pista(Matricula,Pista,Hora):-Hora=='', Pista=='P2-2', asignar_horaP2_2(X), asserta(vuelosP22(Matricula,X)),write('Su pista asignada es la P2-2, por favor disminuya su velocidad para que logre aterrizar a las '), write(X), sexta_entrada(Y).
asignar_pista(Matricula,Pista,Hora):-Hora=='', Pista=='P3', asignar_horaP3(X), asserta(vuelosP3(Matricula,X)),write('Su pista asignada es la P3, por favor disminuya su velocidad para que logre aterrizar a las '), write(X), sexta_entrada(Y).
asignar_pista(Matricula,Pista,Hora):-not(Hora==''), Pista=='P1', not(vuelosP1(_,Hora)), asserta(vuelosP1(Matricula,Hora)), write('Su pista asignada es la P1, a las '), write(Hora), write(', por una hora.'), sexta_entrada(Y).
asignar_pista(Matricula,Pista,Hora):-not(Hora==''),Pista=='P2-1', not(vuelosP21(_,Hora)), asserta(vuelosP21(Matricula,Hora)), write('Su pista asignada es la P2-1, a las '), write(Hora), write(', por una hora.'), sexta_entrada(Y).
asignar_pista(Matricula,Pista,Hora):-not(Hora==''),Pista=='P2-2', not(vuelosP22(_,Hora)), asserta(vuelosP22(Matricula,Hora)), write('Su pista asignada es la P2-2, a las '), write(Hora), write(', por una hora.'), sexta_entrada(Y).
asignar_pista(Matricula,Pista,Hora):-not(Hora==''),Pista=='P3', not(vuelosP3(_,Hora)), asserta(vuelosP3(Matricula,Hora)), write('Su pista asignada es la P3, a las '), write(Hora), write(', por una hora.'), sexta_entrada(Y).

% SE ASIGNA LA PRIMERA HORA DISPONIBLE
asignar_horaP1(Hora):-hora(X), not(vuelosP1(_,X)), Hora = X.
asignar_horaP2_1(Hora):-hora(X), not(vuelosP21(_,X)), Hora = X.
asignar_horaP2_2(Hora):-hora(X), not(vuelosP22(_,X)), Hora = X.
asignar_horaP3(Hora):-hora(X), not(vuelosP3(_,X)), Hora = X.

analizar_entrada(X):- my_read(X), oracion(X,[]).

primer_entrada(X):-analizar_entrada(X), revisar_situacion(X).

segunda_entrada_S(X):- resp_saludo(), nl, analizar_entrada(X), revisar_solicitud(X).
segunda_entrada_E(X):- resp_solicitud_emergencia(), nl, analizar_entrada(X), revisar_emergencia(X).

tercera_entrada_S(X,Y):- resp_solicitud(), nl, analizar_entrada(X), revisar_id(X,Y).

cuarta_entrada_S(X,Y,L,T):- Y==2, resp_hora(), nl, analizar_entrada(X), revisar_hora(X,Y,L,T).
cuarta_entrada_S(X,Y,L,T):- Y==1, resp_aterrizaje(), nl, analizar_entrada(X), revisar_direccion(X,Y,L,T,'').

quinta_entrada_S(X,Y,L,T,W):- resp_direccion(), nl, analizar_entrada(X), revisar_direccion(X,Y,L,T,W).

sexta_entrada(X):- nl, write('muchas gracias.').

maycey():-
        primer_entrada(X).

erase():-
        retractall(vuelosP1(_,_)), 
        retractall(vuelosP21(_,_)),
        retractall(vuelosP22(_,_)),
        retractall(vuelosP3(_,_)).