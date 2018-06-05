				/*SUBCONSULTAS*/

/*Obtener los jugadores que pesan más que la media de peso de todos los jugadores españoles.*/
 select nombre, peso from jugadores group by nombre having peso>(select avg(peso) from jugadores where procedencia='Spain');

/*Obtener los puntos por partido de Pau Gasol en toda su carrera.*/ 
  select temporada, puntos_por_partido from estadisticas where jugador=(select codigo from jugadores where nombre='Pau Gasol');

Obtener los puntos por partido de los jugadores de los Cavaliers en la temporada 2007/2008.
  select jugador, puntos_por_partido from estadisticas where jugador in (select codigo from jugadores where nombre_equipo='Cavaliers') and temporada='07/08';

Obtener el número de jugadores que tiene cada equipo de la Conferencia Oeste.
  select  nombre_equipo,  count(codigo) as nº_jugadores from jugadores where nombre_equipo in (select nombre from equipos where conferencia='west') group by nombre_equipo;

Obtener la máxima media de puntos de Lebron James en su carrera.
  select temporada, max(puntos_por_partido) from estadisticas where jugador=(select codigo from jugadores where nombre='Lebron James');

Obtener la media de asistencias por partido de José Calderón en la temporada 2007/2008.
  select asistencias_por_partido from estadisticas where jugador=(select codigo from jugadores where nombre='Jose Calderon') and temporada='07/08';

Obtener la media de puntos por partido de Lebron James en las temporadas del 2003/2004 al 2005/2006.
  select temporada, puntos_por_partido from estadisticas where jugador in (select codigo from jugadores where nombre='Lebron James') and temporada='03/04' or temporada='04/05' or temporada='05/06' group by temporada;

Obtener la media de rebotes de los jugadores de la Conferencia Este.
  select jugador, avg(rebotes_por_partido) from estadisticas where jugador in (select codigo from jugadores where nombre_equipo in (select nombre from equipos where conferencia='east')) group by jugador;

Obtener los rebotes por partido de los jugadores de los equipos de la ciudad de Los Ángeles en la temporada 2007/2008.
  select jugador, rebotes_por_partido from estadisticas where jugador in (select codigo from jugadores where nombre_equipo in (select nombre from equipos where ciudad='Los Angeles')) and temporada='07/08';

Obtener el máximo reboteador de los Suns en la temporada 2007/2008.
  select nombre from jugadores where codigo=(select jugador from estadisticas where jugador in (select codigo from jugadores where nombre_equipo='Suns') and temporada='07/08' order by rebotes_por_partido desc limit 1);

Obtener el número de jugadores que tiene cada equipo de la división NorthWest.
  select  nombre_equipo, count(codigo) as nº_jugadores from jugadores where nombre_equipo in (select nombre from equipos where division='NorthWest' group by nombre) group by nombre_equipo;

Obtener la temporada con más puntos por partido de Kobe Bryant.
  select  temporada, puntos_por_partido from estadisticas where jugador=(select codigo from jugadores where nombre='Kobe Bryant') order by puntos_por_partido desc limit 1;

Obtener la ciudad con el equipo cuya media de altura de los jugadores sea la más baja.
  select nombre, ciudad from equipos where nombre=(select nombre_equipo from jugadores group by nombre_equipo order by avg(altura) limit 1);

Obtener los jugadores y los puntos por partido de los Timberwolves en la temporada 2003/2004.
  select jugador, puntos_por_partido from estadisticas where jugador in (select codigo from jugadores where nombre_equipo='Timberwolves') and temporada='03/04';

Obtener el nombre y peso de los jugadores de la NBA que hayan hecho una media de más de 25 puntos por partido en alguna temporada.
  select nombre, peso from jugadores where codigo in (select jugador from estadisticas where puntos_por_partido>25);

Obtener las asistencias por partido y los tapones por partido de los jugadores de los Miami Heat en la temporada 2005/2006.

Obtener el nombre, la altura y el peso de los jugadores que juegan en la ciudad de Los Ángeles y que sean españoles.
  select nombre, altura, peso from jugadores where procedencia like 'Spain' and nombre_equipo in (select nombre from equipos where ciudad='Los Angeles');


				/*MULTITABLA*/

/*Obtener el número total de jugadores de cada división.*/
  select division, count(codigo) from equipos inner join jugadores on nombre_equipo=equipos.nombre group by division;

/*Obtener el nombre, equipo y la media de puntos de todas las temporadas de los jugadores españoles de la NBA.*/
  select nombre, nombre_equipo, avg(puntos_por_partido) from estadisticas inner join jugadores on jugador=codigo where procedencia like 'Spain' group by nombre;

/*Obtener el nombre de los jugadores, el nombre del equipo al que pertenecen y la ciudad de aquellos que han realizado algún tapón en la temporada 2003/2004.*/
  select jugadores.nombre, nombre_equipo, ciudad from jugadores inner join equipos on nombre_equipo=equipos.nombre where codigo in (select jugador from estadisticas where tapones_por_partido>0 and temporada='03/04');
  
