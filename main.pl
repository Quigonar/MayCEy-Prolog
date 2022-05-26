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

% REVISA LA ENTRADA DE EMERGENCIA O SALUDO NORMAL
revisar_situacion(X):-primer_elemento(X,Z), es_saludo(X, Z), segunda_entrada_S(Y).
revisar_situacion(X):-primer_elemento(X,Z), es_emergencia(X, Z), segunda_entrada_E(Y).

es_saludo(Lista, Variable):-saludoB(Variable),!.
es_saludo(Lista, Variable):-eliminar_elemento_lista(Variable,Lista,NLista), pe(NLista, Z), es_saludo(NLista,Z).
es_saludo([], Variable):-write('No entendi su mensaje.'), nl, primer_entrada(X),!.

es_emergencia(Lista, Variable):-solicitud_emergenciaB(Variable),!.
es_emergencia([], ''):-write('No entendi su mensaje.'), nl, primer_entrada(X),!.
es_emergencia(Lista, Variable):-eliminar_elemento_lista(Variable,Lista,NLista), primer_elemento(NLista, Z), es_emergencia(NLista,Z).


% REVISA LA ENTRADA DE SOLICITUD DESPEGAR O ATERRIZAR
revisar_solicitud(X):-primer_elemento(X,Z), es_aterrizaje(X,Z), tercera_entrada_S(Y,1).
revisar_solicitud(X):-primer_elemento(X,Z), es_despegar(X,Z), tercera_entrada_S(Y,2).

es_aterrizaje(Lista, Variable):-aterrizar(Variable),!.
es_aterrizaje(Lista, Variable):-eliminar_elemento_lista(Variable,Lista,NLista), pe(NLista, Z), es_aterrizaje(NLista,Z).
es_aterrizaje([], Variable):-write('No indico la solicitud correctamente.'), nl, segunda_entrada_S(X),!.

es_despegar(Lista, Variable):-despegar(Variable),!.
es_despegar([], ''):-write('No indico la solicitud correctamente.'), nl, segunda_entrada_S(X),!.
es_despegar(Lista, Variable):-eliminar_elemento_lista(Variable,Lista,NLista), primer_elemento(NLista, Z), es_despegar(NLista,Z).

% REVISA EL TIPO DE EMERGENCIA
revisar_emergencia(X):- primer_elemento(X,Z), es_tipoEmergencia(X,Z), tercera_entrada_E(Y).

es_tipoEmergencia(Lista,Variable):-emergencia(Variable),!.
es_tipoEmergencia([],''):-write('No indico la emergencia correctamente.'), nl, segunda_entrada_E(X),!.
es_tipoEmergencia(Lista,Variable):-eliminar_elemento_lista(Variable,Lista,NLista), primer_elemento(NLista, Z), es_tipoEmergencia(NLista,Z).


% REVISA LA IDENTIFICACION DEL AVION
revisar_id(X,Y):-primer_elemento(X,Z), es_matricula(X,Z,[],X,Y).
revisar_id2(X,Y,Matricula):-(Y==1;Y==2), primer_elemento(X,Z), es_aeronave(X,Z,Pista,Y), cuarta_entrada_S(W,Y,Matricula,Pista).
revisar_id2(X,Y,Matricula):-Y=='E', primer_elemento(X,Z), es_aeronave(X,Z,Pista,Y), asignar_pista(Matricula,Pista,Hora,Y).

es_matricula(Lista,Variable,Matricula,X,Y):-length(Matricula,4), revisar_id2(X,Y,Matricula),!.
es_matricula(Lista,Variable,Matricula,X,Y):-matriculaB(Variable), append(Matricula, [Variable], W), eliminar_elemento_lista(Variable,Lista,NLista), primer_elemento(NLista, Z), es_matricula(NLista,Z,W,X,Y).
es_matricula(Lista,Variable,Matricula,X,Y):-not(length(Lista,0)), not(matriculaB(Variable)), eliminar_elemento_lista(Variable,Lista,NLista), primer_elemento(NLista, Z), es_matricula(NLista,Z,Matricula,X,Y).
es_matricula([],'',Matricula,X,Y):-not(length(Matricula,4)), write('No indico la matricula correctamente, identifiquese de nuevo.'), nl, tercera_entrada_S(G,Y),!.

es_aeronave(Lista,Variable,Pista,Y):-aeronaves_dobles(Variable), eliminar_elemento_lista(Variable,Lista,NLista), primer_elemento(NLista, Z), atom_concat(Variable,Z,J), es_aeronave(NLista,J,Pista,Y).
es_aeronave(Lista,Variable,Pista,Y):-aeronaves_pequenas(Variable), Pista='P1',!.
es_aeronave(Lista,Variable,Pista,Y):-aeronaves_medianas(Variable), Pista='P2',!.
es_aeronave(Lista,Variable,Pista,Y):-aeronaves_grandes(Variable), Pista='P3',!.
es_aeronave(Lista,Variable,Pista,Y):-not(length(Lista,0)), eliminar_elemento_lista(Variable,Lista,NLista), primer_elemento(NLista, Z), es_aeronave(NLista,Z,Pista,Y).
es_aeronave([],'',_,Y):-write('No indico la aeronave correctamente, identifiquese de nuevo.'), nl, tercera_entrada_S(X,Y),!.

% REVISA LA HORA DE SALIDA
revisar_hora(X,Y,Matricula,Pista):-primer_elemento(X,Z), es_hora(X,Z,Y,Matricula,Pista,Hora), Pista=='P2', quinta_entrada_S(Q,Y,Matricula,Pista,Hora).
revisar_hora(X,Y,Matricula,Pista):-primer_elemento(X,Z), es_hora(X,Z,Y,Matricula,Pista,Hora), (Pista=='P1';Pista=='P3'), asignar_pista(Matricula,Pista,Hora,Y).

es_hora(Lista,Variable,Y,Matricula,Pista,Hora):-hora(Variable), Hora=Variable,!.
es_hora(Lista,Variable,Y,Matricula,Pista,Hora):-not(length(Lista,0)), eliminar_elemento_lista(Variable,Lista,NLista), pe(NLista, Z), es_hora(NLista,Z,Y,Matricula,Pista,Hora).
es_hora([],Variable,Y,Matricula,Pista,Hora):-write('No indico la hora correctamente'), nl, cuarta_entrada_S(X,Y,Matricula,Pista).

% REVISA LA DIRECCION DE SALIDA O LLEGADA
revisar_direccion(X,Y,L,T,W):-primer_elemento(X,Z), es_direccion(X,Z,Y,Matricula,Pista,Hora).

es_direccion(Lista,Variable,Y,Matricula,Pista,Hora):-Variable=='este', Y==1, Pista=='P2', asignar_pista(Matricula,'P2-1',Hora,Y),!.
es_direccion(Lista,Variable,Y,Matricula,Pista,Hora):-Variable=='oeste', Y==1, Pista=='P2', asignar_pista(Matricula,'P2-2',Hora,Y),!.
es_direccion(Lista,Variable,Y,Matricula,Pista,Hora):-Y==1, Pista=='P1', asignar_pista(Matricula,'P1',Hora,Y,Y),!.
es_direccion(Lista,Variable,Y,Matricula,Pista,Hora):-Y==1, Pista=='P3', asignar_pista(Matricula,'P3',Hora,Y),!.
es_direccion(Lista,Variable,Y,Matricula,Pista,Hora):-Variable=='este', Y==2, asignar_pista(Matricula,'P2-1',Hora,Y),!.
es_direccion(Lista,Variable,Y,Matricula,Pista,Hora):-Variable=='oeste', Y==2, asignar_pista(Matricula,'P2-1',Hora,Y),!.
es_direccion(Lista,Variable,Y,Matricula,Pista,Hora):-not(length(Lista,0)), eliminar_elemento_lista(Variable,Lista,NLista), primer_elemento(NLista, Z), es_hora(NLista,Z,Y,Matricula,Pista,Hora).
es_direccion([],Variable,Y,Matricula,Pista,Hora):-write('No indico la direccion correctamente'), nl, Y==2, quinta_entrada_S(X,Y,Matricula,Pista,Hora),!.
es_direccion([],Variable,Y,Matricula,Pista,Hora):-write('No indico la direccion correctamente'), nl, Y==1, quinta_entrada_S(X,Y,Matricula,Pista,Hora),!.

check_direccion(Entrada,Pista):-primer_elemento(Entrada, Z), Z=='este', Pista = 'P2-1',!.
check_direccion(Entrada,Pista):-primer_elemento(Entrada, Z), Z=='oeste', Pista = 'P2-1',!.
check_direccion(Entrada,Pista):-primer_elemento(Entrada, Z), not(length(Entrada, 0)), eliminar_elemento_lista(Z, Entrada, NEntrada), check_direccion(NEntrada, Pista).
check_direccion(Entrada,Pista):-length(Entrada, 0), Pista = 1.

% SE ASIGNA LA PISTA CORRESPONDIENTE A LA SOLICITADA
asignar_pista(Matricula,Pista,Hora,Y):-Y==2, Pista=='P1', not(vuelosP1(_,Hora)), asserta(vuelosP1(Matricula,Hora)), write('Su pista asignada es la P1, a las '), write(Hora), write(', por una hora.'), nl, nl, sexta_entrada(L),!.
asignar_pista(Matricula,Pista,Hora,Y):-Y==2, Pista=='P2-1', not(vuelosP21(_,Hora)), asserta(vuelosP21(Matricula,Hora)), write('Su pista asignada es la P2-1, a las '), write(Hora), write(', por una hora.'), nl, nl, sexta_entrada(L),!.
asignar_pista(Matricula,Pista,Hora,Y):-Y==2, Pista=='P2-2', not(vuelosP22(_,Hora)), asserta(vuelosP22(Matricula,Hora)), write('Su pista asignada es la P2-2, a las '), write(Hora), write(', por una hora.'), nl, nl, sexta_entrada(L),!.
asignar_pista(Matricula,Pista,Hora,Y):-Y==2, Pista=='P3', not(vuelosP3(_,Hora)), asserta(vuelosP3(Matricula,Hora)), write('Su pista asignada es la P3, a las '), write(Hora), write(', por una hora.'), nl, nl, sexta_entrada(L),!.
asignar_pista(Matricula,Pista,Hora,Y):-Y==2, check_P1(Z), Z=='available', not(Hora==''), Pista=='P1', vuelosP1(_,Hora), asignar_horaP1_2(Hora, Hora, X), asserta(vuelosP1(Matricula,X)), write('Su pista asignada es la P1, a las '), write(X), write(', por una hora, ya que es la siguiente hora habil'), nl, nl, sexta_entrada(L),!.
asignar_pista(Matricula,Pista,Hora,Y):-Y==2, check_P1(Z), Z=='full', not(Hora==''), Pista=='P1', vuelosP1(_,Hora), asignar_pista_nueva(X), asignar_pista(Matricula, X, Hora,Y).
asignar_pista(Matricula,Pista,Hora,Y):-Y==2, check_P21(Z), Z=='available', not(Hora==''), Pista=='P2-1', vuelosP21(_,Hora), asignar_horaP2_1_2(Hora, Hora, X), asserta(vuelosP21(Matricula,X)), write('Su pista asignada es la P2-1, a las '), write(X), write(', por una hora, ya que es la siguiente hora habil'), nl, nl, sexta_entrada(L),!.
asignar_pista(Matricula,Pista,Hora,Y):-Y==2, check_P21(Z), Z=='full', not(Hora==''), Pista=='P2-1', vuelosP21(_,Hora), asignar_pista_nueva2(X), asignar_pista(Matricula, X, Hora,Y).
asignar_pista(Matricula,Pista,Hora,Y):-Y==2, check_P22(Z), Z=='available', not(Hora==''), Pista=='P2-2', vuelosP22(_,Hora), asignar_horaP2_2_2(Hora, Hora, X), asserta(vuelosP22(Matricula,X)), write('Su pista asignada es la P2-2, a las '), write(X), write(', por una hora, ya que es la siguiente hora habil'), nl, nl, sexta_entrada(L),!.
asignar_pista(Matricula,Pista,Hora,Y):-Y==2, check_P22(Z), Z=='full', not(Hora==''), Pista=='P2-2', vuelosP22(_,Hora), asignar_pista_nueva3(X), asignar_pista(Matricula, X, Hora,Y).
asignar_pista(Matricula,Pista,Hora,Y):-Y==2, Pista=='P3', vuelosP3(_,Hora), asignar_horaP3_2(Matricula, Pista, Hora, Hora, X), asserta(vuelosP3(Matricula,X)), write('Su pista asignada es la P3, a las '), write(X), write(', por una hora, ya que es la siguiente hora habil'), nl, nl, sexta_entrada(L),!.

asignar_pista(Matricula,Pista,Hora,Y):-Y==1, Pista=='P1', not(vuelosP1(_,Hora)), asserta(vuelosP1(Matricula,Hora)), write('Su pista asignada es la P1, por favor disminuya su velocidad para que logre aterrizar a las '), write(X), nl, nl, sexta_entrada(L),!.
asignar_pista(Matricula,Pista,Hora,Y):-Y==1, Pista=='P2-1', not(vuelosP21(_,Hora)), asserta(vuelosP21(Matricula,Hora)), write('Su pista asignada es la P2-1, por favor disminuya su velocidad para que logre aterrizar a las '), write(X), nl, nl, sexta_entrada(L),!.
asignar_pista(Matricula,Pista,Hora,Y):-Y==1, Pista=='P2-2', not(vuelosP22(_,Hora)), asserta(vuelosP22(Matricula,Hora)), write('Su pista asignada es la P2-2, por favor disminuya su velocidad para que logre aterrizar a las '), write(X), nl, nl, sexta_entrada(L),!.
asignar_pista(Matricula,Pista,Hora,Y):-Y==1, Pista=='P3', not(vuelosP3(_,Hora)), asserta(vuelosP3(Matricula,Hora)), write('Su pista asignada es la P3, por favor disminuya su velocidad para que logre aterrizar a las '), write(X), nl, nl, sexta_entrada(L),!.
asignar_pista(Matricula,Pista,Hora,Y):-Y==1, check_P1(Z), Z=='available', not(Hora==''), Pista=='P1', vuelosP1(_,Hora), asignar_horaP1_2(Hora, Hora, X), asserta(vuelosP1(Matricula,X)), write('Su pista asignada es la P1, por favor disminuya su velocidad para que logre aterrizar a las '), write(X), write(' ya que es la siguiente hora habil'), nl, nl, sexta_entrada(L),!.
asignar_pista(Matricula,Pista,Hora,Y):-Y==1, check_P1(Z), Z=='full', not(Hora==''), Pista=='P1', vuelosP1(_,Hora), asignar_pista_nueva(X), asignar_pista(Matricula, X, Hora,Y).
asignar_pista(Matricula,Pista,Hora,Y):-Y==1, check_P21(Z), Z=='available', not(Hora==''), Pista=='P2-1', vuelosP21(_,Hora), asignar_horaP2_1_2(Hora, Hora, X), asserta(vuelosP21(Matricula,X)), write('Su pista asignada es la P2-1, por favor disminuya su velocidad para que logre aterrizar a las '), write(X), write(' ya que es la siguiente hora habil'), nl, sexta_entrada(L),!.
asignar_pista(Matricula,Pista,Hora,Y):-Y==1, check_P21(Z), Z=='full', not(Hora==''), Pista=='P2-1', vuelosP21(_,Hora), asignar_pista_nueva2(X), asignar_pista(Matricula, X, Hora,Y).
asignar_pista(Matricula,Pista,Hora,Y):-Y==1, check_P22(Z), Z=='available', not(Hora==''), Pista=='P2-2', vuelosP22(_,Hora), asignar_horaP2_2_2(Hora, Hora, X), asserta(vuelosP22(Matricula,X)), write('Su pista asignada es la P2-2, por favor disminuya su velocidad para que logre aterrizar a las '), write(X), write(' ya que es la siguiente hora habil'), nl, sexta_entrada(L),!.
asignar_pista(Matricula,Pista,Hora,Y):-Y==1, check_P22(Z), Z=='full', not(Hora==''), Pista=='P2-2', vuelosP22(_,Hora), asignar_pista_nueva3(X), asignar_pista(Matricula, X, Hora,Y).
asignar_pista(Matricula,Pista,Hora,Y):-Y==1, Pista=='P3', vuelosP3(_,Hora), asignar_horaP3_2(Matricula, Pista, Hora, Hora, X), asserta(vuelosP3(Matricula,X)), write('Su pista asignada es la P3, por favor disminuya su velocidad para que logre aterrizar a las '), write(X), write(' ya que es la siguiente hora habil'), nl, nl,sexta_entrada(L),!.

asignar_pista(Matricula,Pista,Hora,Y):-Y=='E', Pista=='P1',  nl, write('Su pista asignada es la P1, equipo de ayuda enviado'), nl, nl, sexta_entrada(L),!.
asignar_pista(Matricula,Pista,Hora,Y):-Y=='E', Pista=='P2', nl, write('Su pista asignada es la P2-1, equipo de ayuda enviado'), nl, nl, sexta_entrada(L),!.
asignar_pista(Matricula,Pista,Hora,Y):-Y=='E', Pista=='P3', nl, write('Su pista asignada es la P3, equipo de ayuda enviado'), nl, nl, sexta_entrada(L),!.

% SE ASIGNA LA PRIMERA HORA DISPONIBLE
asignar_horaP1(Hora):-hora(X), not(vuelosP1(_,X)), Hora = X.
asignar_horaP2_1(Hora):-hora(X), not(vuelosP21(_,X)), Hora = X.
asignar_horaP2_2(Hora):-hora(X), not(vuelosP22(_,X)), Hora = X.
asignar_horaP3(Hora):-hora(X), not(vuelosP3(_,X)), Hora = X.

% SE ASIGNA LA HORA MAS CERCANA A LA DADA
asignar_horaP1_2(Hora, HoraC, Hora2):-horas_posibles(ListaHoras), asignar_siguienteH(Hora,ListaHoras,X), not(vuelosP1(_,X)), Hora2 = X,!.
asignar_horaP1_2(Hora, HoraC, Hora2):-horas_posibles(ListaHoras), asignar_siguienteH(Hora,ListaHoras,X), vuelosP1(_,X), asignar_horaP1_2(X, HoraC, Hora2).

asignar_horaP2_1_2(Hora, HoraC, Hora2):-horas_posibles(ListaHoras), asignar_siguienteH(Hora,ListaHoras,X), not(vuelosP21(_,X)), Hora2 = X,!.
asignar_horaP2_1_2(Hora, HoraC, Hora2):-horas_posibles(ListaHoras), asignar_siguienteH(Hora,ListaHoras,X), vuelosP1(_,X), asignar_horaP2_1_2(X, HoraC, Hora2).

asignar_horaP2_2_2(Hora, HoraC, Hora2):-horas_posibles(ListaHoras), asignar_siguienteH(Hora,ListaHoras,X), not(vuelosP22(_,X)), Hora2 = X,!.
asignar_horaP2_2_2(Hora, HoraC, Hora2):-horas_posibles(ListaHoras), asignar_siguienteH(Hora,ListaHoras,X), vuelosP1(_,X), asignar_horaP2_2_2(X, HoraC, Hora2).

asignar_horaP3_2(Hora, HoraC, Hora2):-horas_posibles(ListaHoras), asignar_siguienteH(Hora,ListaHoras,X), not(vuelosP3(_,X)), Hora2 = X,!.
asignar_horaP3_2(Hora, HoraC, Hora2):-horas_posibles(ListaHoras), asignar_siguienteH(Hora,ListaHoras,X), vuelosP1(_,X), asignar_horaP3_2(X, HoraC, Hora2).
asignar_horaP3_2(Matricula, Pista, Hora, HoraC, Hora2):-check_P3(Z), Z == 'full', write('La pista P3 esta llena, porfavor espere hasta nuevo aviso'), nl, sexta_entrada(X).

%SE ASIGNA UNA PISTA NUEVA EN EL CASO DE ESTAR LLENA
asignar_pista_nueva(PistaN):-write('La pista P1 esta llena, porfavor reindique su direccion.'), nl, analizar_entrada(X), check_direccion(X,Y), (Y=='P2-1' ; Y=='P2-2'), PistaN=Y,!.
asignar_pista_nueva(PistaN):-write('La pista P1 esta llena, porfavor reindique su direccion.'), nl, analizar_entrada(X), check_direccion(X,Y), Y==1, write('No se entendio la direccion dada.'), nl, asignar_pista_nueva(PistaN).

asignar_pista_nueva2(PistaN):-check_P22(X), X == 'available', write('La pista P2-1 esta llena.'), nl, PistaN = 'P2-2'.
asignar_pista_nueva2(PistaN):-check_P22(X), X == 'full', write('La pista P2-1 esta llena.'), nl, PistaN = 'P3'.

asignar_pista_nueva3(PistaN):-check_P21(X), X == 'available', write('La pista P2-2 esta llena.'), nl, PistaN = 'P2-1'.
asignar_pista_nueva3(PistaN):-check_P21(X), X == 'full', write('La pista P2-2 esta llena.'), nl,  PistaN = 'P3'.

%VERIFICA SI LA PISTA ESTA LLENA O NO
check_P1(X):-findall(Y, vuelosP1(_,Y),L), length(L, 24), X='full',!.
check_P1(X):-findall(Y, vuelosP1(_,Y),L), not(length(L, 24)), X='available',!.

check_P21(X):-findall(Y, vuelosP21(_,Y),L), length(L, 24), X='full',!.
check_P21(X):-findall(Y, vuelosP21(_,Y),L), not(length(L, 24)), X='available',!.

check_P22(X):-findall(Y, vuelosP22(_,Y),L), length(L, 24), X='full',!.
check_P22(X):-findall(Y, vuelosP22(_,Y),L), not(length(L, 24)), X='available',!.

check_P3(X):-findall(Y, vuelosP3(_,Y),L), length(L, 24), X='full',!.
check_P3(X):-findall(Y, vuelosP3(_,Y),L), not(length(L, 24)), X='available',!.

% ASIGNAR HORA LIBRE MAS CERCANA
asignar_siguienteH(Hora,ListaHoras,Hora2):- primer_elemento(ListaHoras, Y), Y == Hora, eliminar_elemento_lista(Hora,ListaHoras,NLista), primer_elemento(NLista,Hora2),!.
asignar_siguienteH(Hora,ListaHoras,Hora2):- primer_elemento(ListaHoras, Y), not(Y == Hora), not(Y == '23:00'), eliminar_elemento_lista(Y,ListaHoras,NLista), asignar_siguienteH(Hora, NLista, Hora2).
asignar_siguienteH(Hora,ListaHoras,Hora2):- primer_elemento(ListaHoras, Y), Y == Hora, Y == '23:00', Hora2 = '0:00',!.

% REVISA EL AGRADECIMIENTO
revisar_agradecimiento(X):- primer_elemento(X,Y), es_agradecimiento(X,Y,Answer), not(Answer='false'), resp_agradecimiento(), nl, nl, septima_entrada(L),!.

es_agradecimiento(Lista,Variable,Answer):- agradecimientoB(Variable), Answer = 'true',!.
es_agradecimiento(Lista,Variable,Answer):-not(length(Lista,0)), eliminar_elemento_lista(Variable,Lista,NLista), primer_elemento(NLista, Z), es_agradecimiento(NLista,Z,Answer).
es_agradecimiento([],Variable,Answer):-Variable == '', not(agradecimientoB(Variable)), nl, write('Porfavor termine la terminal despidiendose'), nl, Answer='false',!.

% REVISA LA DESPEDIDA
revisar_despedida(X):- primer_elemento(X,Y), es_despedida(X,Y,Answer), not(Answer='false'), nl, write('_________________________________'), nl, nl, primer_entrada(L),!.

es_despedida(Lista,Variable,Answer):-despedidaB(Variable), Answer = 'true',!.
es_despedida(Lista,Variable,Answer):-not(length(Lista,0)), eliminar_elemento_lista(Variable,Lista,NLista), primer_elemento(NLista, Z), es_despedida(NLista,Z,Answer).
es_despedida([],Variable,Answer):-Variable == '', not(despedidaB(Variable)), nl, write('Porfavor termine la terminal despidiendose'), nl, Answer='false',!.

revisar_cierre(X):- primer_elemento(X,Y), es_cierre(X,Y,Answer), not(Answer = 'false'), abort.

es_cierre(Lista,Variable,Answer):-cierre(Variable), Answer='true',!.
es_cierre(Lista,Variable,Answer):-not(length(Lista,0)), eliminar_elemento_lista(Variable,Lista,NLista), primer_elemento(NLista, Z), es_cierre(NLista,Z,Answer).
es_cierre([],Variable, Answer):-Variable == '', not(cierre(Variable)), Answer='false',!.

analizar_entrada(X):- my_read(X), oracion(X,[]),!.

primer_entrada(X):-analizar_entrada(X), not(revisar_cierre(X)), revisar_situacion(X),!.

segunda_entrada_S(X):-resp_saludo(), nl, analizar_entrada(X), not(revisar_cierre(X)), revisar_solicitud(X),!.
segunda_entrada_E(X):-resp_solicitud_emergencia(), nl, analizar_entrada(X), not(revisar_cierre(X)), revisar_emergencia(X),!.

tercera_entrada_S(X,Y):-resp_solicitud(), nl, analizar_entrada(X), not(revisar_cierre(X)), revisar_id(X,Y),!.
tercera_entrada_E(X):-resp_solicitud(), nl, analizar_entrada(X), not(revisar_cierre(X)), revisar_id(X,'E'),!.

cuarta_entrada_S(X,Y,Matricula,Pista):- Y==2, resp_hora(), nl, analizar_entrada(X), not(revisar_cierre(X)), revisar_hora(X,Y,Matricula,Pista),!.
cuarta_entrada_S(X,Y,Matricula,Pista):- Y==1, resp_hora2(), nl, analizar_entrada(X), not(revisar_cierre(X)), revisar_hora(X,Y,Matricula,Pista),!.

quinta_entrada_S(X,Y,Matricula,Pista,Hora):- Y==2, resp_direccion(), nl, analizar_entrada(X), not(revisar_cierre(X)), revisar_direccion(X,Y,Matricula,Pista,Hora),!.
quinta_entrada_S(X,Y,Matricula,Pista,Hora):- Y==1, resp_direccion2(), nl, analizar_entrada(X), not(revisar_cierre(X)), revisar_direccion(X,Y,Matricula,Pista,Hora),!.

sexta_entrada(X):- analizar_entrada(X), not(revisar_cierre(X)), revisar_agradecimiento(X).
sexta_entrada(X):- analizar_entrada(X), not(revisar_cierre(X)), revisar_despedida(X).

septima_entrada(X):- analizar_entrada(X), not(revisar_cierre(X)), revisar_despedida(X).

maycey():-
        primer_entrada(X).

limpiar_pistas():-
        retractall(vuelosP1(_,_)), 
        retractall(vuelosP21(_,_)),
        retractall(vuelosP22(_,_)),
        retractall(vuelosP3(_,_)).

llenar_pistaP1():-
        asserta(vuelosP1('alpha bravo charlie delta','0:00')),
        asserta(vuelosP1('alpha bravo charlie delta','1:00')),
        asserta(vuelosP1('alpha bravo charlie delta','2:00')),
        asserta(vuelosP1('alpha bravo charlie delta','3:00')),
        asserta(vuelosP1('alpha bravo charlie delta','4:00')),
        asserta(vuelosP1('alpha bravo charlie delta','5:00')),
        asserta(vuelosP1('alpha bravo charlie delta','6:00')),
        asserta(vuelosP1('alpha bravo charlie delta','7:00')),
        asserta(vuelosP1('alpha bravo charlie delta','8:00')),
        asserta(vuelosP1('alpha bravo charlie delta','9:00')),
        asserta(vuelosP1('alpha bravo charlie delta','10:00')),
        asserta(vuelosP1('alpha bravo charlie delta','11:00')),
        asserta(vuelosP1('alpha bravo charlie delta','12:00')),
        asserta(vuelosP1('alpha bravo charlie delta','13:00')),
        asserta(vuelosP1('alpha bravo charlie delta','14:00')),
        asserta(vuelosP1('alpha bravo charlie delta','15:00')),
        asserta(vuelosP1('alpha bravo charlie delta','16:00')),
        asserta(vuelosP1('alpha bravo charlie delta','17:00')),
        asserta(vuelosP1('alpha bravo charlie delta','18:00')),
        asserta(vuelosP1('alpha bravo charlie delta','19:00')),
        asserta(vuelosP1('alpha bravo charlie delta','20:00')),
        asserta(vuelosP1('alpha bravo charlie delta','21:00')),
        asserta(vuelosP1('alpha bravo charlie delta','22:00')),
        asserta(vuelosP1('alpha bravo charlie delta','23:00')).

llenar_pistaP21():-
        asserta(vuelosP21('alpha bravo charlie delta','0:00')),
        asserta(vuelosP21('alpha bravo charlie delta','1:00')),
        asserta(vuelosP21('alpha bravo charlie delta','2:00')),
        asserta(vuelosP21('alpha bravo charlie delta','3:00')),
        asserta(vuelosP21('alpha bravo charlie delta','4:00')),
        asserta(vuelosP21('alpha bravo charlie delta','5:00')),
        asserta(vuelosP21('alpha bravo charlie delta','6:00')),
        asserta(vuelosP21('alpha bravo charlie delta','7:00')),
        asserta(vuelosP21('alpha bravo charlie delta','8:00')),
        asserta(vuelosP21('alpha bravo charlie delta','9:00')),
        asserta(vuelosP21('alpha bravo charlie delta','10:00')),
        asserta(vuelosP21('alpha bravo charlie delta','11:00')),
        asserta(vuelosP21('alpha bravo charlie delta','12:00')),
        asserta(vuelosP21('alpha bravo charlie delta','13:00')),
        asserta(vuelosP21('alpha bravo charlie delta','14:00')),
        asserta(vuelosP21('alpha bravo charlie delta','15:00')),
        asserta(vuelosP21('alpha bravo charlie delta','16:00')),
        asserta(vuelosP21('alpha bravo charlie delta','17:00')),
        asserta(vuelosP21('alpha bravo charlie delta','18:00')),
        asserta(vuelosP21('alpha bravo charlie delta','19:00')),
        asserta(vuelosP21('alpha bravo charlie delta','20:00')),
        asserta(vuelosP21('alpha bravo charlie delta','21:00')),
        asserta(vuelosP21('alpha bravo charlie delta','22:00')),
        asserta(vuelosP21('alpha bravo charlie delta','23:00')).

llenar_pistaP22():-
        asserta(vuelosP22('alpha bravo charlie delta','0:00')),
        asserta(vuelosP22('alpha bravo charlie delta','1:00')),
        asserta(vuelosP22('alpha bravo charlie delta','2:00')),
        asserta(vuelosP22('alpha bravo charlie delta','3:00')),
        asserta(vuelosP22('alpha bravo charlie delta','4:00')),
        asserta(vuelosP22('alpha bravo charlie delta','5:00')),
        asserta(vuelosP22('alpha bravo charlie delta','6:00')),
        asserta(vuelosP22('alpha bravo charlie delta','7:00')),
        asserta(vuelosP22('alpha bravo charlie delta','8:00')),
        asserta(vuelosP22('alpha bravo charlie delta','9:00')),
        asserta(vuelosP22('alpha bravo charlie delta','10:00')),
        asserta(vuelosP22('alpha bravo charlie delta','11:00')),
        asserta(vuelosP22('alpha bravo charlie delta','12:00')),
        asserta(vuelosP22('alpha bravo charlie delta','13:00')),
        asserta(vuelosP22('alpha bravo charlie delta','14:00')),
        asserta(vuelosP22('alpha bravo charlie delta','15:00')),
        asserta(vuelosP22('alpha bravo charlie delta','16:00')),
        asserta(vuelosP22('alpha bravo charlie delta','17:00')),
        asserta(vuelosP22('alpha bravo charlie delta','18:00')),
        asserta(vuelosP22('alpha bravo charlie delta','19:00')),
        asserta(vuelosP22('alpha bravo charlie delta','20:00')),
        asserta(vuelosP22('alpha bravo charlie delta','21:00')),
        asserta(vuelosP22('alpha bravo charlie delta','22:00')),
        asserta(vuelosP22('alpha bravo charlie delta','23:00')).

llenar_pistaP3():-
        asserta(vuelosP3('alpha bravo charlie delta','0:00')),
        asserta(vuelosP3('alpha bravo charlie delta','1:00')),
        asserta(vuelosP3('alpha bravo charlie delta','2:00')),
        asserta(vuelosP3('alpha bravo charlie delta','3:00')),
        asserta(vuelosP3('alpha bravo charlie delta','4:00')),
        asserta(vuelosP3('alpha bravo charlie delta','5:00')),
        asserta(vuelosP3('alpha bravo charlie delta','6:00')),
        asserta(vuelosP3('alpha bravo charlie delta','7:00')),
        asserta(vuelosP3('alpha bravo charlie delta','8:00')),
        asserta(vuelosP3('alpha bravo charlie delta','9:00')),
        asserta(vuelosP3('alpha bravo charlie delta','10:00')),
        asserta(vuelosP3('alpha bravo charlie delta','11:00')),
        asserta(vuelosP3('alpha bravo charlie delta','12:00')),
        asserta(vuelosP3('alpha bravo charlie delta','13:00')),
        asserta(vuelosP3('alpha bravo charlie delta','14:00')),
        asserta(vuelosP3('alpha bravo charlie delta','15:00')),
        asserta(vuelosP3('alpha bravo charlie delta','16:00')),
        asserta(vuelosP3('alpha bravo charlie delta','17:00')),
        asserta(vuelosP3('alpha bravo charlie delta','18:00')),
        asserta(vuelosP3('alpha bravo charlie delta','19:00')),
        asserta(vuelosP3('alpha bravo charlie delta','20:00')),
        asserta(vuelosP3('alpha bravo charlie delta','21:00')),
        asserta(vuelosP3('alpha bravo charlie delta','22:00')),
        asserta(vuelosP3('alpha bravo charlie delta','23:00')).