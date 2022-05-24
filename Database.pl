:- dynamic vuelosP1/2.
:- dynamic vuelosP21/2.
:- dynamic vuelosP22/2.
:- dynamic vuelosP3/2.

% tipos de emergencias
emergencia('perdida de motor').
emergencia('parto en medio vuelo').
emergencia('paro cardiaco de pasajero').
emergencia('secuestro').

% tipos de aeronaves
aeronaves_grandes('boing747').
aeronaves_grandes('airbusa340').
aeronaves_grandes('airbusa380').
aeronaves_medianas('boing717').
aeronaves_medianas('embraer190').
aeronaves_medianas('airbusa220').
aeronaves_pequenas('cessna').
aeronaves_pequenas('beechcraft').
aeronaves_pequenas('embraerphenom').

aeronaves_dobles('boing').
aeronaves_dobles('airbus').
aeronaves_dobles('embraer').


% pistas
pista('P1').
pista('P2-1').
pista('P2-2').
pista('P3').

condicion_aterrizaje('viento').
condicion_aterrizaje('peso').
condicion_aterrizaje('distancia').
condicion_aterrizaje('velocidad').

saludoB('hola').
saludoB('buenas').
saludoB('buenos').

solicitud_emergenciaB('mayday,').
solicitud_emergenciaB('mayday').
solicitud_emergenciaB('emergencia').
solicitud_emergenciaB('7500').

aterrizar('aterrizar').
despegar('despegar').

matriculaB('alpha').
matriculaB('bravo'). 
matriculaB('charlie').
matriculaB('delta').
matriculaB('echo').
matriculaB('foxtrot').
matriculaB('golf').
matriculaB('hotel').
matriculaB('india').
matriculaB('juliet').
matriculaB('kilo').
matriculaB('lima').
matriculaB('mike').
matriculaB('november').
matriculaB('oscar').
matriculaB('papa').
matriculaB('quebec').
matriculaB('romeo').
matriculaB('sierra').
matriculaB('tango').
matriculaB('uniform').
matriculaB('victor').
matriculaB('whiskey').
matriculaB('xray').
matriculaB('yankee').
matriculaB('zulu').

lista('hola').

hora('0:00').
hora('1:00').
hora('2:00').
hora('3:00').
hora('4:00').
hora('5:00').
hora('6:00').
hora('7:00').
hora('8:00').
hora('9:00').
hora('10:00').
hora('11:00').
hora('12:00').
hora('13:00').
hora('14:00').
hora('15:00').
hora('16:00').
hora('17:00').
hora('18:00').
hora('19:00').
hora('20:00').
hora('21:00').
hora('22:00').
hora('23:00').

% respuesta de saludo
resp_saludo():- nl, write('Hola ¿en que lo puedo ayudar?').

% respuesta de solicitud
resp_solicitud():- nl, write('Por favor identifiquese (minimo matricula y tipo de aeronave).').

% respuesta falta matricula
resp_matricula():- nl, write('Me indica su matricula por favor.').

% respuesta falta aeronave
resp_aeronave():- nl, write('Me indica el tipo de aeronave por favor.').

% respuesta hora salida
resp_hora():- nl, write('Me indica la hora de salida por favor.').

% respuesta direccion salida
resp_direccion():- nl, write('Me indica la direccion de salida por favor.').

% respuesta aterrizaje
resp_aterrizaje():- nl, write('Me indica la velocidad, distancia a la pista y direccion por favor.').

% respuesta de solicitud emergencia
resp_solicitud_emergencia():- nl, write('Buenas, por favor indique su emergencia.').

% respuesta de agradecimiento
resp_agradecimiento():- nl, write('Con mucho gusto.').