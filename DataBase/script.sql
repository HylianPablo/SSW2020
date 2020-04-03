drop table if exists Usuario;
drop table if exists Guardado;
drop table if exists Dieta;
drop table if exists Entrada;
drop table if exists Comentario;
drop table if exists PlatoMenu;
drop table if exists Plato;
drop table if exists PertenenciaPlato;
drop table if exists Ingrediente;
 
create table Usuario(
	nombre					char(50) not null,
	nombreUsuario				char(20) not null,
	contrasena				char(20) not null,
	correo					char(40) not null,
	favorito				char(20),
	foreign key(favorito) references Dieta,
	primary key(nombreUsuario)
);


create table Guardado(
	nombreUsuario				char(20) not null,
	codigoDieta				char(20) not null,
	foreign key(nombreUsuario) references Usuario,
	foreign key(codigoDieta) references Dieta,
	primary key(nombreUsuario, codigoDieta)
);

create table Entrada(
	codigoEntrada				char(20) not null,
	titulo					char(50) not null,
	cuerpo					char(500),
	nombreUsuario				char(20) not null,
	fecha					date not null,
	foreign key(nombreUsuario) references Usuario,
	primary key(codigoEntrada)
);

create table Comentario(
	codigoComentario			char(20) not null,
	codigoPadre				char(20) not null,
	cuerpo					char(500) not null,
	nombreUsuario				char(20) not null,
	fecha					date not null,
	foreign key(codigoPadre) references Entrada,
	foreign key(nombreUsuario) references Usuario,
	primary key(codigoComentario)
);

create table PlatoMenu(
	codigoPlato				char(20) not null,
	codigoDieta				char(20) not null,
	diaSemana				char(20) not null,
	check (diaSemana in ('lunes','martes','miercoles','jueves','viernes','sabado','domingo')),
	momento					char(30) not null,
	check (momento in ('desayuno','comidaPrimero','comidaSegundo','cena')),
	foreign key(codigoPlato) references Plato, 
	foreign key(codigoDieta) references Dieta,
	primary key(codigoPlato, codigoDieta)
);	

create table Dieta(
	codigoDieta	char(20) not null,
	titulo		char(20) not null,
	descripcion	char(500) not null,
	primary key(codigoDieta)
);

create table Plato(
	codigoPlato 				char(20) not null,
	nombre					char(30) not null,
	descripcion				char(500),
	desayuno				boolean not null,
	vegano					boolean not null,
	vegetariano				boolean not null,
	frutosSecos				boolean not null,
	gluten					boolean not null,
	kcal					integer not null,
	glucidosSimples				integer not null,
	polisacaridos 				integer not null,
	aminoacidos				integer not null,
	proteinas				integer not null,
	hidratosDeCarbono			integer not null,
	primary key(codigoPlato)
);

create table PertenenciaPlato(
	codigoIngrediente		char(20) not null,
	codigoPlato 			char(20) not null,
	foreign key(codigoIngrediente) references Ingrediente,
	foreign key(codigoPlato) references Plato,
	primary key(codigoIngrediente, codigoPlato)
);

create table Ingrediente(
	codigoIngrediente			char(20) not null,
	nombre 					char(30) not null,
	vegano 					boolean	 not null,
	vegetariano				boolean  not null,
	frutosSecos         			boolean  not null,
	gluten		         		boolean  not null,
	primary key(codigoIngrediente)
);

insert into Usuario Values ('Pedro Sanz Lopez', 'pedsanz', '12345pedro','pedrosanzl@gmail.com','36587J');
insert into Usuario Values ('Marta Sanchez Rojo', 'martsanro', 'farola4','marta1912@gmail.com','93163K');
insert into Usuario Values ('Marcos Moya Gallo', 'marmoyaga', 'tirabuzon89','marcos.mg@yahoo.com','73803A');

insert into Guardado Values ('pedsanz','36587J');
insert into Guardado Values ('martsanro','93163K');
insert into Guardado Values ('marmoyaga','73803A');

insert into Entrada Values ('AKA78','Quiero comer bien','Quiero tener una alimentacion sana y no se cocinar','pedsanz','2020-04-03');
insert into Entrada Values ('JTG45','Quiero ser vegana',NULL,'martsanro','2020-03-23');
insert into Entrada Values ('DHB88','Receta de cupcakes','Esta receta me la enseño mi abuela. Lleva harina y huevos','marmoyaga','2020-03-08');

insert into Comentario Values ('65JH9','AKA78','Prueba a no comer bollos','marmoyaga','2020-04-05');
insert into Comentario Values ('90TR1','AKA78','El aguacate es un alimento muy sano, incluyelo en tus platos','marmoyaga','2020-04-06');
insert into Comentario Values ('39DV4','JTG45','No comas carne','pedsanz','2020-03-25');

insert into PlatoMenu Values ('6480FAHJ','RJUK1312','lunes','comidaPrimero');
insert into PlatoMenu Values ('2019WEMO','RJUK1312','lunes','comidaSegundo');
insert into PlatoMenu Values ('3109YRYU','ASDF9999','jueves','cena');

insert into Dieta Values ('ASDF9999','Dieta vegeteriana','Una dieta que no lleva animales, salvo ovolácteos');
insert into Dieta Values ('RJUK1312','Dieta mediterranea','Una dieta basada en la comida tradicional de la costa mediterranea');
insert into Dieta Values ('HIWH1370','Dieta de deportistas','Una dieta orientada a personas que realizan mucho deporte a diario');

insert into Plato Values ('3109YRYU','Garbanzos con espinacas','Garbanzos de la huerta cocinados con espinaca baby y aceite de oliva',FALSE,TRUE,TRUE,FALSE,FALSE,350,10,10,10,50,20);
insert into Plato Values ('2019WEMO','Pez espada','Pez espada con limón y romero, marinado con piñones',FALSE,FALSE,FALSE,TRUE,FALSE,280,10,20,30,20,20);
insert into Plato Values ('6480FAHJ','Macarrones a la bolonesa','Macarrones con carne picada, tomate y orégano',FALSE,FALSE,FALSE,FALSE,TRUE,400,10,10,10,10,60);

insert into PertenenciaPlato Values('98HJHE98','3109YRYU');
insert into PertenenciaPlato Values('56WKEP56','3109YRYU');
insert into PertenenciaPlato Values('21DHIU21','2019WEMO');

insert into Ingrediente Values('98HJHE98','Garbanzo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('56WKEP56','Espinaca',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('21DHIU21','Pez espada',FALSE,FALSE,FALSE,FALSE);
