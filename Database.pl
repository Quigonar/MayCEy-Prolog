% INPUT DE USUARIO
% puntos cardinales
direccion("norte", "sur", "este", "oeste").

% letras de matricula
matricula(["alpha", "bravo", "charlie", "delta", "echo", "foxtrot", 
"golf", "hotel", "india", "juliet", "kilo", "lima", "mike", "november", "oscar", 
"papa", "quebec", "romeo", "sierra", "tango", "uniform", "victor", "whiskey", "xray", "yankee", "zulu"]).

% verbos
verbo(["solicito", "quiero", "deseo"]).

% solicitud
solicitud(["aterrizar", "despegar"]).

% mensajes de saludo
saludo(["hola maycey!", "hola maycey", "buenas", "buenos dias", "buenas tardes", "buenas noches"]).

% mensajes de emergencia
solicitud_emergencia(["mayday, mayday", "mayday mayday", "emergencia", "7500"]).

% tipos de emergencias
emergencia(["perdida de motor", "parto en medio vuelo", "paro cardiaco de pasajero", "secuestro"]).

% tipos de aeronaves
aeronaves_grandes(["boing 747", "airbus a340", "airbus a380"]).
aeronaves_medianas(["boing 717", "embraer 190", "airbus a220"]).
aeronaves_pequeñas(["cessna", "beechcraft", "embraer phenom"]).

% condiciones de aterrizaje
condiciones_aterrizaje([]).

% tipos de agradecimiento
agradecimiento(["gracias", "gracias!", "muchas gracias", "muchas gracias!"]).

% mensajes de despedida
despedida(["adios", "chao", "hasta luego", "hasta pronto", "cambio y fuera"]).

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
resp_condiciones_aterrizaje
resp_atterizaje("Me indica la velocidad, distancia a la pista y direccion por favor.").

% respuesta de solicitud emergencia
resp_solicitud_emergencia("Buenas, por favor indique su emergencia.").

% respuesta de agradecimiento
resp_agradecimiento("Con mucho gusto.").

% 
