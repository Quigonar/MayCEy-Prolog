% INPUT DE USUARIO
% puntos cardinales
direccion("norte", "sur", "este", "oeste").

% letras de matricula
matricula(["alpha", "bravo", "charlie", "delta", "echo", "foxtrot",
"golf", "hotel", "india", "juliet", "kilo", "lima", "mike", "november", "oscar",
"papa", "quebec", "romeo", "sierra", "tango", "uniform", "victor", "whiskey", "xray", "yankee", "zulu"]).

% mensajes de saludo
saludo(["hola", "buenas", "buenos dias", "buenas tardes", "buenas noches"]).

% mensajes de emergencia
solicitud_emergencia(["mayday, mayday", "mayday mayday", "emergencia", "7500"]).

% tipos de emergencias
emergencia("perdida de motor").
emergencia("parto en medio vuelo").
emergencia("paro cardiaco de pasajero").
emergencia("secuestro").

% tipos de aeronaves
aeronaves_grandes(["boing 747", "airbus a340", "airbus a380"]).
aeronaves_medianas(["boing 717", "embraer 190", "airbus a220"]).
aeronaves_pequenas(["cessna", "beechcraft", "embraer phenom"]).

% condiciones de aterrizaje
condiciones_aterrizaje(["este a oeste", "oeste a este"]).

% tipos de agradecimiento
agradecimiento(["gracias", "gracias!", "muchas gracias", "muchas gracias!"]).

% mensajes de despedida
despedida(["adios", "chao", "hasta luego", "hasta pronto", "cambio y fuera"]).

% preguntas
pregunta()

% RESPUESTAS DE MAYCEY
% pistas
pista(["P1", "P2-1", "P2-2", "P3"]).

% respuesta de saludo
resp_saludo("Hola ¿en qué lo puedo ayudar?").

% respuesta de solicitud
resp_solicitud("Por favor identifiquese").

% respuesta falta matricula
resp_matricula("Me indica su matricula por favor.").

% respuesta falta aeronave
resp_aeronave("Me indica el tipo de aeronave por favor.").

% respuesta hora salida
resp_hora("Me indica la hora de salida por favor.").

% respuesta direccion salida
resp_direccion("Me indica la direccion de salida por favor.").

% respuesta aterrizaje
resp_atterizaje("Me indica la velocidad, distancia a la pista y direccion por favor.").

% respuesta de solicitud emergencia
resp_solicitud_emergencia("Buenas, por favor indique su emergencia.").

% respuesta de agradecimiento
resp_agradecimiento("Con mucho gusto.").

%
horario_pistaP1([]).

%Obtener primer elemento de una lista
primer_elemento([X|_], X).

igualdad(X,X).

miembro(Elem,[Elem|_]).
miembro(Elem, [_|Tail]):- miembro(Elem, Tail).

%analizador(X, Z):-solicitud(X), igualdad("solicitud", Z),!.
analizador([X|Y],Z):-write("hola"), verbo(X), verbo_identificado(Y,Z),!.
analizador([_|Y], Z):-analizador(Y,Z).
analizador([], Z):-igualdad(Z, "no entendi"),!.

verbo_identificado([X|_], Z):-(solicitud_a(X), igualdad("aterrizar", Z)); (solicitud_d(X), igualdad("despegar", Z)), !.
verbo_identificado([_|Y], Z):-verbo_identificado(Y, Z).

preguntaAux(Pregunta,K):-write(Pregunta),nl,read_line_to_codes(user_input, Codes), atom_codes(A, Codes), atom_string(A, String),
    split_string(String," ","",List),ultimo_elemento_lista(List,Last),eliminar_caracter_string(Last,".",NewLast),eliminar_elemento_lista(Last,List,NewList),
    convertir_string_lista(NewLast,LastList),append(NewList,LastList,NEWList),write(NEWList),analizador(NEWList,K).
