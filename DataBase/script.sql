drop table if exists PertenenciaPlato;
drop table if exists Ingrediente;
drop table if exists PlatoMenu;
drop table if exists Plato;
drop table if exists Comentario;
drop table if exists Entrada;
drop table if exists Guardado;
drop table if exists Usuario;
drop table if exists Dieta;

create table Dieta(
	codigoDieta	char(20) not null,
	titulo		char(20) not null,
	descripcion	text not null,
	fecha		date not null,
	primary key(codigoDieta)
);

create table Usuario(
	nombre					char(50) not null,
	nombreUsuario				char(20) not null,
	contrasena				char(20) not null,
	correo					char(40) not null,
	favorito				char(20),
	foreign key(favorito) references Dieta(codigoDieta),
	primary key(nombreUsuario)
);


create table Guardado(
	nombreUsuario				char(20) not null,
	codigoDieta				char(20) not null,
	foreign key(nombreUsuario) references Usuario(nombreUsuario),
	foreign key(codigoDieta) references Dieta(codigoDieta),
	primary key(nombreUsuario, codigoDieta)
);

create table Entrada(
	codigoEntrada				char(20) not null,
	titulo					char(50) not null,
	cuerpo					text,
	nombreUsuario				char(20) not null,
	fecha					date not null,
	foreign key(nombreUsuario) references Usuario(nombreUsuario),
	primary key(codigoEntrada)
);

create table Comentario(
	codigoComentario			char(20) not null,
	codigoPadre				char(20) not null,
	cuerpo					text not null,
	nombreUsuario				char(20) not null,
	fecha					date not null,
	foreign key(codigoPadre) references Entrada(codigoEntrada),
	foreign key(nombreUsuario) references Usuario(nombreUsuario),
	primary key(codigoComentario)
);	

create table Plato(
	codigoPlato 				char(20) not null,
	nombre					char(30) not null,
	descripcion				text,
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

create table PlatoMenu(
	codigoPlato				char(20) not null,
	codigoDieta				char(20) not null,
	diaSemana				char(20) not null,
	check (diaSemana in ('lunes','martes','miercoles','jueves','viernes','sabado','domingo')),
	momento					char(30) not null,
	check (momento in ('desayuno','comidaPrimero','comidaSegundo','cena')),
	foreign key(codigoPlato) references Plato(codigoPlato), 
	foreign key(codigoDieta) references Dieta(codigoDieta),
	primary key(codigoPlato, codigoDieta)
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

create table PertenenciaPlato(
	codigoIngrediente		char(20) not null,
	codigoPlato 			char(20) not null,
	foreign key(codigoIngrediente) references Ingrediente(codigoIngrediente),
	foreign key(codigoPlato) references Plato(codigoPlato),
	primary key(codigoIngrediente, codigoPlato)
);

insert into Dieta Values ('00000000','Dieta vegeteriana','Una dieta que no lleva animales, salvo ovolácteos','2018-01-01');
insert into Dieta Values ('00000001','Dieta mediterranea','Una dieta basada en la comida tradicional de la costa mediterranea','2020-04-10');
insert into Dieta Values ('00000002','Dieta de deportistas','Una dieta orientada a personas que realizan mucho deporte a diario','2020-03-01');


insert into Usuario Values ('Pedro Sanz Lopez', 'pedsanz', '12345pedro','pedrosanzl@gmail.com','00000000');
insert into Usuario Values ('Marta Sanchez Rojo', 'martsanro', 'farola4','marta1912@gmail.com','00000001');
insert into Usuario Values ('Marcos Moya Gallo', 'marmoyaga', 'tirabuzon89','marcos.mg@yahoo.com','00000002');


insert into Guardado Values ('pedsanz','00000000');
insert into Guardado Values ('martsanro','00000001');
insert into Guardado Values ('marmoyaga','00000002');


insert into Entrada Values ('00000','Quiero comer bien','Quiero tener una alimentacion sana y no se cocinar','pedsanz','2020-04-03');
insert into Entrada Values ('00001','Quiero ser vegana',NULL,'martsanro','2020-03-23');
insert into Entrada Values ('00002','Receta de cupcakes','Esta receta me la enseño mi abuela. Lleva harina y huevos','marmoyaga','2020-03-08');


insert into Comentario Values ('00000','00000','Prueba a evitar demasiadas grasas saturadas y calorías vacias como las propocionadas por bebidas alcoholicas o la bolleria industrial','2020-04-05');
insert into Comentario Values ('00001','00000','El aguacate es un alimento muy sano, incluyelo en tus platos','marmoyaga','2020-04-06');
insert into Comentario Values ('00002','00001','No comas carne','pedsanz','2020-03-25');


insert into Plato Values ('00000000','Garbanzos con espinacas','Garbanzos de la huerta cocinados con espinaca y aceite de oliva',FALSE,TRUE,TRUE,FALSE,FALSE,350,10,10,10,50,20);
insert into Ingrediente Values('00000001','Espinaca',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000002','Garbanzo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000003','Aceite de oliva',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000004','Ajo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000005','Pimenton',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000006','Sal fina',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000001','00000000');
insert into PertenenciaPlato Values('00000002','00000000');
insert into PertenenciaPlato Values('00000003','00000000');
insert into PertenenciaPlato Values('00000004','00000000');
insert into PertenenciaPlato Values('00000005','00000000');
insert into PertenenciaPlato Values('00000006','00000000');


insert into Plato Values ('00000001','Pez espada','Pez espada con limón y romero, marinado con piñones',FALSE,FALSE,FALSE,TRUE,FALSE,280,10,20,30,20,20);
insert into Ingrediente Values('00000007','Pez espada',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000008','Limon',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000009','Romero',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000010','Piñones',TRUE,TRUE,TRUE,FALSE); 
insert into PertenenciaPlato Values('00000006','00000001');
insert into PertenenciaPlato Values('00000007','00000001');
insert into PertenenciaPlato Values('00000008','00000001');
insert into PertenenciaPlato Values('00000009','00000001');
insert into PertenenciaPlato Values('00000010','00000001');



insert into Plato Values ('00000002','Macarrones a la boloñesa','Macarrones con carne picada, tomate y oregano',FALSE,FALSE,FALSE,FALSE,TRUE,400,10,10,10,10,60);
insert into Ingrediente Values('00000011','Macarron',TRUE,TRUE,FALSE,TRUE);
insert into Ingrediente Values('00000012','Carne picada',FALSE,FALSE,FALSE,TRUE);
insert into Ingrediente Values('00000013','Tomate',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000014','Oregano',TRUE,TRUE,FALSE,TRUE);
insert into PertenenciaPlato Values('00000006','00000002');
insert into PertenenciaPlato Values('00000011','00000002');
insert into PertenenciaPlato Values('00000012','00000002');
insert into PertenenciaPlato Values('00000013','00000002');
insert into PertenenciaPlato Values('00000014','00000002');


insert into Plato Values ('00000003','Sopa de pescado','Sopa de merluza con cebolla, pimiento verde, pimiento rojo, laurel y ajo',FALSE,FALSE,FALSE,FALSE,FALSE,100,10,15,20,18,60);
insert into Ingrediente Values('00000015','Merluza',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000016','Cebolla',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000017','Pimiento verde',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000018','Pimiento rojo',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000004','00000003');
insert into PertenenciaPlato Values('00000028','00000003');
insert into PertenenciaPlato Values('00000015','00000003');
insert into PertenenciaPlato Values('00000016','00000003');
insert into PertenenciaPlato Values('00000017','00000003');
insert into PertenenciaPlato Values('00000018','00000003');


insert into Plato Values ('00000004','Filetes de pollo','Filetes de pollo al grill y tomate aliñado',FALSE,FALSE,FALSE,FALSE,FALSE,200,10,10,20,17,47);
insert into Ingrediente Values('00000019','Filete de pollo',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000004');
insert into PertenenciaPlato Values('00000013','00000004');
insert into PertenenciaPlato Values('00000019','00000004');


insert into Plato Values ('00000005','Cóctel de langostinos','Cóctel de langostinos con palitos de cangrejo',FALSE,FALSE,FALSE,FALSE,FALSE,80,13,18,28,10,60);
insert into Ingrediente Values('00000020','Langostinos',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000021','Palitos de cangrejo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000022','Pinia',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000023','Lechuga',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000024','Mayonesa',TRUE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000025','Vinagre',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000026','Pimienta negra',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000005');
insert into PertenenciaPlato Values('00000020','00000005');
insert into PertenenciaPlato Values('00000021','00000005');
insert into PertenenciaPlato Values('00000022','00000005');
insert into PertenenciaPlato Values('00000023','00000005');
insert into PertenenciaPlato Values('00000024','00000005');
insert into PertenenciaPlato Values('00000025','00000005');
insert into PertenenciaPlato Values('00000026','00000005');


insert into Plato Values ('00000006','Espaguetis a la carbonara','Espaguetis con salsa carbonara',FALSE,FALSE,FALSE,FALSE,TRUE,141,7,12,11,5,13);
insert into Ingrediente Values('00000027','Salsa carbonara',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000028','Agua',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000029','Nata',TRUE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000030','Queso',TRUE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000031','Espagueti',FALSE,FALSE,FALSE,TRUE);
insert into PertenenciaPlato Values('00000006','00000006');
insert into PertenenciaPlato Values('00000027','00000006');
insert into PertenenciaPlato Values('00000028','00000006');
insert into PertenenciaPlato Values('00000029','00000006');
insert into PertenenciaPlato Values('00000030','00000006');
insert into PertenenciaPlato Values('00000031','00000006');


insert into Plato Values ('00000007','Costillas','Costillas de cerdo a la barbacoa',FALSE,FALSE,FALSE,FALSE,FALSE,186,10,13,12,16,8);
insert into Ingrediente Values('00000032','Costillas de cerdo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000033','Almidon',FALSE,FALSE,FALSE,TRUE);
insert into Ingrediente Values('00000034','Zumo de limon',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000035','Salsa barbacoa',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000007');
insert into PertenenciaPlato Values('00000032','00000007');
insert into PertenenciaPlato Values('00000033','00000007');
insert into PertenenciaPlato Values('00000034','00000007');
insert into PertenenciaPlato Values('00000035','00000007');


insert into Plato Values ('00000008','Yogourt de frutas del bosque','Yogourt de frutas del bosque',TRUE,TRUE,TRUE,FALSE,TRUE,84,3,6,8,4,10);
insert into Ingrediente Values('00000036','Leche entera',TRUE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000037','Mora',TRUE, TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000038','Frambuesa',TRUE, TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000039','Arandanos',TRUE, TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000040','Azucar',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000033','00000008');
insert into PertenenciaPlato Values('00000036','00000008');
insert into PertenenciaPlato Values('00000037','00000008');
insert into PertenenciaPlato Values('00000038','00000008');
insert into PertenenciaPlato Values('00000039','00000008');
insert into PertenenciaPlato Values('00000040','00000008');


insert into Plato Values ('00000009','Melon con jamon','Melon con jamon',FALSE,FALSE,FALSE,FALSE,TRUE,237,13,17,18,30,1);
insert into Ingrediente Values('00000041','Melon',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000042','Jamon',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000041','00000009');
insert into PertenenciaPlato Values('00000042','00000009');


insert into Plato Values ('00000010','Baguettes de atun y bacon','Baguettes de atun y bacon',FALSE,FALSE,FALSE,FALSE,TRUE,275,11,12,10,14,30);
insert into Ingrediente Values('00000043','Pan',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000044','Atun',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000045','Bacon',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000010');
insert into PertenenciaPlato Values('00000043','00000010');
insert into PertenenciaPlato Values('00000044','00000010');
insert into PertenenciaPlato Values('00000045','00000010');

insert into Plato Values ('00000011','Lasania Boloniesa','Lasania Boloniesa con carne de cerdo',FALSE,FALSE,FALSE,FALSE,TRUE,148,7,15,17,7,15);
insert into Ingrediente Values('00000046','Harina',TRUE,TRUE,FALSE,TRUE);
insert into Ingrediente Values('00000065','Carne de cerdo',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000013','00000011');
insert into PertenenciaPlato Values('00000040','00000011');
insert into PertenenciaPlato Values('00000036','00000011');
insert into PertenenciaPlato Values('00000065','00000011');
insert into PertenenciaPlato Values('00000046','00000011');
insert into PertenenciaPlato Values('00000016','00000011');
insert into PertenenciaPlato Values('00000004','00000011');
insert into PertenenciaPlato Values('00000026','00000011');


insert into Plato Values ('00000012','Berza cocida','Berza cocida con aceite, ajo y pimenton',FALSE,TRUE,TRUE,FALSE,FALSE,63,2,8,5,5,11);
insert into Ingrediente Values('00000047','Berza',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000004','00000012');
insert into PertenenciaPlato Values('00000006','00000012');
insert into PertenenciaPlato Values('00000028','00000012');
insert into PertenenciaPlato Values('00000003','00000012');
insert into PertenenciaPlato Values('00000005','00000012');



insert into Plato Values ('00000013','Potaje de garbanzos','Potaje de garbanzos con verduras',FALSE,TRUE,TRUE,FALSE,FALSE,269,5,8,20,12,45);
insert into Ingrediente Values('00000048','Calabacin',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000005','00000013');
insert into PertenenciaPlato Values('00000004','00000013');
insert into PertenenciaPlato Values('00000048','00000013');
insert into PertenenciaPlato Values('00000002','00000013');
insert into PertenenciaPlato Values('00000016','00000013');
insert into PertenenciaPlato Values('00000017','00000013');
insert into PertenenciaPlato Values('00000013','00000013');
insert into PertenenciaPlato Values('00000003','00000013');


insert into Plato Values ('00000014','Menestra','Menestra de verduras',FALSE,TRUE,TRUE,FALSE,FALSE,141,7,8,5,6,12);
insert into Ingrediente Values('00000049','Judia',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000050','Guisante',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000051','Zanahoria',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000052','Col',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000053','Haba',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000054','Alcachofa',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000014');
insert into PertenenciaPlato Values('00000003','00000014');
insert into PertenenciaPlato Values('00000025','00000014');
insert into PertenenciaPlato Values('00000049','00000014');
insert into PertenenciaPlato Values('00000050','00000014');
insert into PertenenciaPlato Values('00000051','00000014');
insert into PertenenciaPlato Values('00000052','00000014');
insert into PertenenciaPlato Values('00000053','00000014');
insert into PertenenciaPlato Values('00000054','00000014');


insert into Plato Values ('00000015','Ensalada de endivias','Ensalada de endivias con manzana, queso azul cebolla y nueces',FALSE,TRUE,TRUE,TRUE,FALSE,20,1,3,5,2,12);
insert into Ingrediente Values('00000055','Endivia',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000056','Manzana',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000057','Nuez',TRUE,TRUE,TRUE,FALSE);
insert into Ingrediente Values('00000058','Queso azul',FALSE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000015');
insert into PertenenciaPlato Values('00000003','00000015');
insert into PertenenciaPlato Values('00000025','00000015');
insert into PertenenciaPlato Values('00000016','00000015');
insert into PertenenciaPlato Values('00000055','00000015');
insert into PertenenciaPlato Values('00000056','00000015');
insert into PertenenciaPlato Values('00000057','00000015');
insert into PertenenciaPlato Values('00000058','00000015');


insert into Plato Values ('00000016','Conejo guisado','Conejo guisado con patatas y cebolla',FALSE,FALSE,FALSE,FALSE,TRUE,179,10,3,5,27,0);
insert into Ingrediente Values('00000059','Conejo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000060','Patata',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000061','Laurel',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000016');
insert into PertenenciaPlato Values('00000003','00000016');
insert into PertenenciaPlato Values('00000004','00000016');
insert into PertenenciaPlato Values('00000046','00000016');
insert into PertenenciaPlato Values('00000017','00000016');
insert into PertenenciaPlato Values('00000026','00000016');
insert into PertenenciaPlato Values('00000059','00000016');
insert into PertenenciaPlato Values('00000060','00000016');
insert into PertenenciaPlato Values('00000061','00000016');


insert into Plato Values ('00000017','Guisantes con jamon','Guisantes con jamon con ajo, cebolla y perejil',FALSE,FALSE,FALSE,FALSE,FALSE,160,15,11,9,5,5);
insert into Ingrediente Values('00000062','Perejil',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000017');
insert into PertenenciaPlato Values('00000003','00000017');
insert into PertenenciaPlato Values('00000004','00000017');
insert into PertenenciaPlato Values('00000016','00000017');
insert into PertenenciaPlato Values('00000042','00000017');
insert into PertenenciaPlato Values('00000050','00000017');
insert into PertenenciaPlato Values('00000062','00000017');


insert into Plato Values ('00000018','Revuelto de setas','Revuelto de setas con huevos y ajo',FALSE,FALSE,TRUE,FALSE,FALSE,28,0,2,3,2,5);
insert into Ingrediente Values('00000063','Seta',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000064','Huevo',FALSE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000063','00000018');
insert into PertenenciaPlato Values('00000064','00000018');
insert into PertenenciaPlato Values('00000006','00000018');
insert into PertenenciaPlato Values('00000003','00000018');
insert into PertenenciaPlato Values('00000062','00000018');



insert into Plato Values ('00000019','Arroz frito','Arroz frito con zanahoria, puerro y cebolla',FALSE,TRUE,TRUE,FALSE,FALSE,228,12,8,3,7,43);
insert into Ingrediente Values('00000065','Arroz',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000066','Puerro',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000065','00000019');
insert into PertenenciaPlato Values('00000066','00000019');
insert into PertenenciaPlato Values('00000003','00000019');
insert into PertenenciaPlato Values('00000006','00000019');
insert into PertenenciaPlato Values('00000051','00000019');
insert into PertenenciaPlato Values('00000016','00000019');


insert into Plato Values ('00000020','Merluza al horno','Merluza al horno con cebolla, ajo, vino blanco, zumo de limon, pimenton y perejil',FALSE,FALSE,FALSE,FALSE,FALSE,130,3,10,11,23,2);
insert into Ingrediente Values('00000067','Vino blanco',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000068','Zumo de limon',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000067','00000020');
insert into PertenenciaPlato Values('00000068','00000020');
insert into PertenenciaPlato Values('00000015','00000020');
insert into PertenenciaPlato Values('00000016','00000020');
insert into PertenenciaPlato Values('00000004','00000020');
insert into PertenenciaPlato Values('00000003','00000020');
insert into PertenenciaPlato Values('00000005','00000020');
insert into PertenenciaPlato Values('00000062','00000020');


insert into Plato Values ('00000021','Ternera asada','Ternera asada con pimiento rojo, cebolla, ajo, zanahorias, brandy, tomillo y patatas',FALSE,FALSE,FALSE,FALSE,FALSE,154,3,8,7,32,0);
insert into Ingrediente Values('00000069','Brandy',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000070','Tomillo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000071','Ternera',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000069','00000021');
insert into PertenenciaPlato Values('00000070','00000021');
insert into PertenenciaPlato Values('00000071','00000021');
insert into PertenenciaPlato Values('00000018','00000021');
insert into PertenenciaPlato Values('00000016','00000021');
insert into PertenenciaPlato Values('00000004','00000021');
insert into PertenenciaPlato Values('00000051','00000021');
insert into PertenenciaPlato Values('00000060','00000021');
insert into PertenenciaPlato Values('00000006','00000021');


insert into Plato Values ('00000022','Pure de patata','Pure de patata con mantequilla y leche entera',FALSE,TRUE,TRUE,FALSE,TRUE,215,7,12,15,4,36);
insert into Ingrediente Values('00000072','Mantequilla',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000060','00000022');
insert into PertenenciaPlato Values('00000072','00000022');
insert into PertenenciaPlato Values('00000006','00000022');
insert into PertenenciaPlato Values('00000036','00000022');


insert into Plato Values ('00000023','Tortilla francesa','Tortilla francesa',FALSE,FALSE,TRUE,FALSE,FALSE,214,17,4,7,13,1);
insert into PertenenciaPlato Values('00000006','00000023');
insert into PertenenciaPlato Values('00000003','00000023');
insert into PertenenciaPlato Values('00000064','00000023');


insert into Plato Values ('00000024','Ensaladilla rusa','Ensaladilla rusa con patatas, zanahorias, huevos, aceitunas y atun',FALSE,FALSE,TRUE,FALSE,FALSE,122,11,2,5,1,7);
insert into Ingrediente Values('00000073','Aceituna',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000024');
insert into PertenenciaPlato Values('00000062','00000024');
insert into PertenenciaPlato Values('00000060','00000024');
insert into PertenenciaPlato Values('00000051','00000024');
insert into PertenenciaPlato Values('00000064','00000024');
insert into PertenenciaPlato Values('00000050','00000024');
insert into PertenenciaPlato Values('00000073','00000024');
insert into PertenenciaPlato Values('00000003','00000024');
insert into PertenenciaPlato Values('00000024','00000024');
insert into PertenenciaPlato Values('00000044','00000024');


insert into Plato Values ('00000025','Lentejas','Lentejas con chorizo, cebolla, patatas, zanahorias, ajo y aceite',FALSE,FALSE,TRUE,FALSE,FALSE,122,11,2,5,1,7);
insert into Ingrediente Values('00000074','Chorizo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000075','Lenteja',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000025');
insert into PertenenciaPlato Values('00000074','00000025');
insert into PertenenciaPlato Values('00000075','00000025');
insert into PertenenciaPlato Values('00000026','00000025');
insert into PertenenciaPlato Values('00000005','00000025');
insert into PertenenciaPlato Values('00000004','00000025');
insert into PertenenciaPlato Values('00000016','00000025');
insert into PertenenciaPlato Values('00000003','00000025');


insert into Plato Values ('00000026','Filete de ternera','Filete de ternera a la plancha',FALSE,FALSE,FALSE,FALSE,FALSE,159,4,12,15,27,0);
insert into Ingrediente Values('00000076','Filete de ternera',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000076','00000026');
insert into PertenenciaPlato Values('00000006','00000026');
insert into PertenenciaPlato Values('00000003','00000026');


insert into Plato Values ('00000027','Lenguado al horno','Lenguado al horno con harina, limon, pimienta blanca y perejil',FALSE,FALSE,FALSE,FALSE,FALSE,112,2,10,10,21,0);
insert into Ingrediente Values('00000077','Pimienta blanca',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000078','Lenguado',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000077','00000027');
insert into PertenenciaPlato Values('00000078','00000027');
insert into PertenenciaPlato Values('00000008','00000027');
insert into PertenenciaPlato Values('00000003','00000027');
insert into PertenenciaPlato Values('00000006','00000027');
insert into PertenenciaPlato Values('00000062','00000027');


insert into Plato Values ('00000028','Tortilla de patata','Tortilla de patata con cebolla',FALSE,FALSE,FALSE,FALSE,FALSE,112,2,10,10,21,0);
insert into PertenenciaPlato Values('00000006','00000028');
insert into PertenenciaPlato Values('00000060','00000028');
insert into PertenenciaPlato Values('00000016','00000028');
insert into PertenenciaPlato Values('00000003','00000028');


insert into Plato Values ('00000029','Crema calabacin','Crema calabacin con patatas, cebolla y ajo',FALSE,TRUE,TRUE,FALSE,FALSE,34,3,2,1,1,2);
insert into PertenenciaPlato Values('00000006','00000029');
insert into PertenenciaPlato Values('00000003','00000029');
insert into PertenenciaPlato Values('00000016','00000029');
insert into PertenenciaPlato Values('00000060','00000029');
insert into PertenenciaPlato Values('00000004','00000029');
insert into PertenenciaPlato Values('00000048','00000029');


insert into Plato Values ('00000030','Paella de marisco','Paella de marisco con arroz, rape, gambas y mejillones',FALSE,FALSE,FALSE,FALSE,FALSE,379,13,12,11,23,40);
insert into Ingrediente Values('00000079','Rape',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000080','Gamba',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000081','Mejillon',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000082','Marisco',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000079','00000030');
insert into PertenenciaPlato Values('00000080','00000030');
insert into PertenenciaPlato Values('00000081','00000030');
insert into PertenenciaPlato Values('00000082','00000030');
insert into PertenenciaPlato Values('00000065','00000030');
insert into PertenenciaPlato Values('00000020','00000030');
insert into PertenenciaPlato Values('00000051','00000030');
insert into PertenenciaPlato Values('00000028','00000030');
insert into PertenenciaPlato Values('00000015','00000030');
insert into PertenenciaPlato Values('00000006','00000030');
insert into PertenenciaPlato Values('00000062','00000030');
insert into PertenenciaPlato Values('00000017','00000030');
insert into PertenenciaPlato Values('00000018','00000030');


insert into Plato Values ('00000031','Solomillo de cerdo','Solomillo de cerdo con arroz',FALSE,FALSE,FALSE,FALSE,FALSE,158,8,12,8,22,0);
insert into Ingrediente Values('00000083','Solomillo de cerdo',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000065','00000031');
insert into PertenenciaPlato Values('00000083','00000031');
insert into PertenenciaPlato Values('00000016','00000031');
insert into PertenenciaPlato Values('00000017','00000031');
insert into PertenenciaPlato Values('00000018','00000031');
insert into PertenenciaPlato Values('00000004','00000031');
insert into PertenenciaPlato Values('00000013','00000031');
insert into PertenenciaPlato Values('00000006','00000031');
insert into PertenenciaPlato Values('00000003','00000031');
insert into PertenenciaPlato Values('00000026','00000031');
insert into PertenenciaPlato Values('00000067','00000031');
insert into PertenenciaPlato Values('00000061','00000031');


insert into Plato Values ('00000032','Gazpacho','Gazpacho con pimiento verde y pepino',FALSE,TRUE,TRUE,FALSE,FALSE,85,74,11,8,7,19);
insert into Ingrediente Values('00000084','Pepino',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000013','00000032');
insert into PertenenciaPlato Values('00000017','00000032');
insert into PertenenciaPlato Values('00000084','00000032');
insert into PertenenciaPlato Values('00000016','00000032');
insert into PertenenciaPlato Values('00000004','00000032');
insert into PertenenciaPlato Values('00000003','00000032');
insert into PertenenciaPlato Values('00000006','00000032');
insert into PertenenciaPlato Values('00000028','00000032');
insert into PertenenciaPlato Values('00000025','00000032');


insert into Plato Values ('00000033','Berenjenas en escabeche','Berenjenas en escabeche',FALSE,TRUE,TRUE,FALSE,FALSE,49,1,2,3,1,10);
insert into Ingrediente Values('00000085','Berenjena',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000086','Sal gruesa',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000085','00000033');
insert into PertenenciaPlato Values('00000025','00000033');
insert into PertenenciaPlato Values('00000003','00000033');
insert into PertenenciaPlato Values('00000006','00000033');
insert into PertenenciaPlato Values('00000061','00000033');
insert into PertenenciaPlato Values('00000014','00000033');


insert into Plato Values ('00000034','Lubina al horno','Lubina al horno con patatas y cebolla',FALSE,FALSE,FALSE,FALSE,FALSE,98,3,10,13,19,0);
insert into Ingrediente Values('00000087','Lubina',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000087','00000034');
insert into PertenenciaPlato Values('00000060','00000034');
insert into PertenenciaPlato Values('00000016','00000034');
insert into PertenenciaPlato Values('00000003','00000034');
insert into PertenenciaPlato Values('00000006','00000034');


insert into Plato Values ('00000035','Espaguetis de calabacin','Espaguetis de calabacin con gambas',FALSE,FALSE,FALSE,FALSE,FALSE,176,7,11,12,21,6);
insert into PertenenciaPlato Values('00000031','00000035');
insert into PertenenciaPlato Values('00000048','00000035');
insert into PertenenciaPlato Values('00000080','00000035');
insert into PertenenciaPlato Values('00000004','00000035');
insert into PertenenciaPlato Values('00000003','00000035');
insert into PertenenciaPlato Values('00000006','00000035');
insert into PertenenciaPlato Values('00000062','00000035');


insert into Plato Values ('00000036','Ensalada mixta','Ensalada mixta con esparragos, aceitunas, huevos y atun',FALSE,FALSE,TRUE,FALSE,FALSE,180,16,8,8,5,7);
insert into Ingrediente Values('00000088','Esparrago',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000003','00000036');
insert into PertenenciaPlato Values('00000088','00000036');
insert into PertenenciaPlato Values('00000006','00000036');
insert into PertenenciaPlato Values('00000023','00000036');
insert into PertenenciaPlato Values('00000060','00000036');
insert into PertenenciaPlato Values('00000013','00000036');
insert into PertenenciaPlato Values('00000073','00000036');
insert into PertenenciaPlato Values('00000064','00000036');
insert into PertenenciaPlato Values('00000044','00000036');
insert into PertenenciaPlato Values('00000025','00000036');


insert into Plato Values ('00000037','Hamburguesa de espinacas','Hamburguesa de espinacas',FALSE,FALSE,FALSE,FALSE,TRUE,226,23,12,14,7,22);
insert into PertenenciaPlato Values('00000043','00000037');
insert into PertenenciaPlato Values('00000001','00000037');
insert into PertenenciaPlato Values('00000023','00000037');
insert into PertenenciaPlato Values('00000013','00000037');
insert into PertenenciaPlato Values('00000016','00000037');
insert into PertenenciaPlato Values('00000030','00000037');


insert into Plato Values ('00000038','Esparragos trigueros a la plancha','',FALSE,TRUE,TRUE,FALSE,FALSE,21,0,0,1,2,2);
insert into PertenenciaPlato Values('00000003','00000038');
insert into PertenenciaPlato Values('00000006','00000038');
insert into PertenenciaPlato Values('00000088','00000038');


insert into Plato Values ('00000039','Codillo de cerdo asado','',FALSE,FALSE,FALSE,FALSE,FALSE,199,13,9,11,17,3);
insert into Ingrediente Values('00000089','Codillo de cerdo',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000039');
insert into PertenenciaPlato Values('00000089','00000039');
insert into PertenenciaPlato Values('00000028','00000039');


insert into Plato Values ('00000040','Ensalada Cesar','Ensalada Cesar con queso, pan y pechuga',FALSE,FALSE,FALSE,FALSE,TRUE,116,10,6,4,8,10);
insert into Ingrediente Values('00000090','Salsa Cesar',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000091','Pechuga de pollo',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000040');
insert into PertenenciaPlato Values('00000090','00000040');
insert into PertenenciaPlato Values('00000091','00000040');
insert into PertenenciaPlato Values('00000043','00000040');
insert into PertenenciaPlato Values('00000030','00000040');


insert into Plato Values ('00000041','Sopa de pollo','Sopa de pollo con puerro y zanahoria',FALSE,FALSE,FALSE,FALSE,FALSE,11,0,1,0,1,0);
insert into Ingrediente Values('00000092','Pollo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000093','Fideo',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000051','00000041');
insert into PertenenciaPlato Values('00000092','00000041');
insert into PertenenciaPlato Values('00000066','00000041');
insert into PertenenciaPlato Values('00000051','00000041');
insert into PertenenciaPlato Values('00000016','00000041');
insert into PertenenciaPlato Values('00000062','00000041');
insert into PertenenciaPlato Values('00000006','00000041');
insert into PertenenciaPlato Values('00000093','00000041');


insert into Plato Values ('00000042','Albondigas con tomate','',FALSE,FALSE,FALSE,FALSE,TRUE,169,12,7,8,8,6);
insert into PertenenciaPlato Values('00000012','00000042');
insert into PertenenciaPlato Values('00000013','00000042');
insert into PertenenciaPlato Values('00000004','00000042');
insert into PertenenciaPlato Values('00000062','00000042');
insert into PertenenciaPlato Values('00000077','00000042');
insert into PertenenciaPlato Values('00000046','00000042');
insert into PertenenciaPlato Values('00000016','00000042');
insert into PertenenciaPlato Values('00000067','00000042');


insert into Plato Values ('00000043','Fabada','Fabada con chorizo, panceta y moriclla',FALSE,FALSE,FALSE,FALSE,FALSE,142,9,14,11,7,8);
insert into Ingrediente Values('00000093','Alubia',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000094','Panceta',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000095','Tocino',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000096','Morcilla',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000093','00000043');
insert into PertenenciaPlato Values('00000094','00000043');
insert into PertenenciaPlato Values('00000074','00000043');
insert into PertenenciaPlato Values('00000095','00000043');
insert into PertenenciaPlato Values('00000096','00000043');
insert into PertenenciaPlato Values('00000005','00000043');
insert into PertenenciaPlato Values('00000006','00000043');
insert into PertenenciaPlato Values('00000004','00000043');
insert into PertenenciaPlato Values('00000016','00000043');


insert into Plato Values ('00000044','Espirales con tomate','Espirales con tomate con pisto',FALSE,TRUE,TRUE,FALSE,FALSE,344,2,10,15,12,67);
insert into Ingrediente Values('00000097','Espiral',TRUE,TRUE,FALSE,TRUE);
insert into PertenenciaPlato Values('00000097','00000044');
insert into PertenenciaPlato Values('00000013','00000044');
insert into PertenenciaPlato Values('00000017','00000044');
insert into PertenenciaPlato Values('00000018','00000044');
insert into PertenenciaPlato Values('00000060','00000044');
insert into PertenenciaPlato Values('00000016','00000044');
insert into PertenenciaPlato Values('00000004','00000044');
insert into PertenenciaPlato Values('00000003','00000044');
insert into PertenenciaPlato Values('00000006','00000044');


insert into Plato Values ('00000045','Huevo frito con tomate','',FALSE,TRUE,TRUE,FALSE,FALSE,344,2,10,15,12,67);
insert into PertenenciaPlato Values('00000064','00000045');
insert into PertenenciaPlato Values('00000013','00000045');
insert into PertenenciaPlato Values('00000006','00000045');
insert into PertenenciaPlato Values('00000003','00000045');


insert into Plato Values ('00000046','Patatas con carne','Patatas con carne picada, cebolla y pimiento',FALSE,FALSE,FALSE,FALSE,FALSE,60,2,1,2,4,7);
insert into PertenenciaPlato Values('00000012','00000046');
insert into PertenenciaPlato Values('00000016','00000046');
insert into PertenenciaPlato Values('00000018','00000046');
insert into PertenenciaPlato Values('00000003','00000046');
insert into PertenenciaPlato Values('00000006','00000046');
insert into PertenenciaPlato Values('00000004','00000046');
insert into PertenenciaPlato Values('00000062','00000046');
insert into PertenenciaPlato Values('00000026','00000046');


insert into Plato Values ('00000047','Salmon al horno','Patatas con carne picada, cebolla y pimiento',FALSE,FALSE,FALSE,FALSE,FALSE,227,16,15,14,22,0);
insert into Ingrediente Values('00000098','Salmon',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000098','00000047');
insert into PertenenciaPlato Values('00000060','00000047');
insert into PertenenciaPlato Values('00000017','00000047');
insert into PertenenciaPlato Values('00000013','00000047');
insert into PertenenciaPlato Values('00000098','00000047');
insert into PertenenciaPlato Values('00000016','00000047');
insert into PertenenciaPlato Values('00000067','00000047');
insert into PertenenciaPlato Values('00000026','00000047');
insert into PertenenciaPlato Values('00000006','00000047');


insert into Plato Values ('00000048','Escalivada de verduras','Escalivada de verduras',FALSE,TRUE,TRUE,FALSE,FALSE,68,5,0,1,1,3);
insert into PertenenciaPlato Values('00000085','00000048');
insert into PertenenciaPlato Values('00000018','00000048');
insert into PertenenciaPlato Values('00000016','00000048');
insert into PertenenciaPlato Values('00000013','00000048');
insert into PertenenciaPlato Values('00000003','00000048');
insert into PertenenciaPlato Values('00000004','00000048');
insert into PertenenciaPlato Values('00000006','00000048');


insert into Plato Values ('00000049','Arroz con sepia','Arroz con sepia con pisto y cebolla',FALSE,FALSE,FALSE,FALSE,FALSE,101,2,9,11,4,17);
insert into Ingrediente Values('00000099','Sepia',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000065','00000049');
insert into PertenenciaPlato Values('00000015','00000049');
insert into PertenenciaPlato Values('00000028','00000049');
insert into PertenenciaPlato Values('00000099','00000049');
insert into PertenenciaPlato Values('00000017','00000049');
insert into PertenenciaPlato Values('00000018','00000049');
insert into PertenenciaPlato Values('00000016','00000049');
insert into PertenenciaPlato Values('00000006','00000049');
insert into PertenenciaPlato Values('00000004','00000049');


insert into Plato Values ('00000050','Filete de lomo al ajillo','',FALSE,FALSE,FALSE,FALSE,FALSE,117,4,9,8,20,1);
insert into Ingrediente Values('00000100','Filete de lomo de cerdo',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000100','00000050');
insert into PertenenciaPlato Values('00000004','00000050');
insert into PertenenciaPlato Values('00000061','00000050');
insert into PertenenciaPlato Values('00000028','00000050');
insert into PertenenciaPlato Values('00000062','00000050');
insert into PertenenciaPlato Values('00000006','00000050');
insert into PertenenciaPlato Values('00000026','00000050');
insert into PertenenciaPlato Values('00000006','00000050');
insert into PertenenciaPlato Values('00000067','00000050');


insert into Plato Values ('00000051','Merluza en salsa verde','Merluza en rodajas con salsa verde',FALSE,FALSE,FALSE,FALSE,TRUE,133,8,14,10,15,1);
insert into Ingrediente Values('00000101','Salsa verde',TRUE,TRUE,FALSE,TRUE);
insert into PertenenciaPlato Values('00000101','00000051');
insert into PertenenciaPlato Values('00000015','00000051');
insert into PertenenciaPlato Values('00000016','00000051');
insert into PertenenciaPlato Values('00000004','00000051');
insert into PertenenciaPlato Values('00000067','00000051');


insert into Plato Values ('00000052','Filete de pavo','Filete de pavo a la plancha',FALSE,FALSE,FALSE,FALSE,FALSE,145,2,15,12,29,0);
insert into Ingrediente Values('00000102','Filete de pavo',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000102','00000052');
insert into PertenenciaPlato Values('00000003','00000052');
insert into PertenenciaPlato Values('00000006','00000052');
insert into PertenenciaPlato Values('00000026','00000052');


insert into Plato Values ('00000053','Sopa de verduras','Sopa de verduras con tomate',FALSE,TRUE,TRUE,FALSE,FALSE,59,1,3,12,2,10);
insert into Ingrediente Values('00000103','Repollo',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000103','00000053');
insert into PertenenciaPlato Values('00000013','00000053');
insert into PertenenciaPlato Values('00000016','00000053');
insert into PertenenciaPlato Values('00000066','00000053');
insert into PertenenciaPlato Values('00000003','00000053');
insert into PertenenciaPlato Values('00000005','00000053');
insert into PertenenciaPlato Values('00000006','00000053');
insert into PertenenciaPlato Values('00000062','00000053');
insert into PertenenciaPlato Values('00000026','00000053');


insert into Plato Values ('00000054','Bacalao con tomate','Bacalao fresco o desalatado con tomate',FALSE,FALSE,FALSE,FALSE,FALSE,240,1,1,0,1,1);
insert into Ingrediente Values('00000103','Bacalao',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000103','00000054');
insert into PertenenciaPlato Values('00000016','00000054');
insert into PertenenciaPlato Values('00000004','00000054');
insert into PertenenciaPlato Values('00000013','00000054');
insert into PertenenciaPlato Values('00000006','00000054');
insert into PertenenciaPlato Values('00000003','00000054');


insert into Plato Values ('00000055','Negrito rebozado','Negrito fileteado rebozado con huevos y pan',FALSE,FALSE,FALSE,FALSE,TRUE,240,1,1,0,1,1);
insert into Ingrediente Values('00000104','Negrito',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000043','00000055');
insert into PertenenciaPlato Values('00000064','00000055');
insert into PertenenciaPlato Values('00000004','00000055');
insert into PertenenciaPlato Values('00000062','00000055');
insert into PertenenciaPlato Values('00000003','00000055');
insert into PertenenciaPlato Values('00000006','00000055');
insert into PertenenciaPlato Values('00000104','00000055');

insert into Plato Values ('00000056','Rape al horno','Rape al horno con patatas y cebolla',FALSE,FALSE,FALSE,FALSE,FALSE,240,1,1,0,1,1);
insert into PertenenciaPlato Values('00000079','00000056');
insert into PertenenciaPlato Values('00000060','00000056');
insert into PertenenciaPlato Values('00000016','00000056');
insert into PertenenciaPlato Values('00000003','00000056');
insert into PertenenciaPlato Values('00000025','00000056');
insert into PertenenciaPlato Values('00000006','00000056');
insert into PertenenciaPlato Values('00000062','00000056');


insert into Plato Values ('00000057','Pure de verduras','Pure de verduras con cebolla, calabacin, cebolla, acelgas,...',FALSE,TRUE,TRUE,FALSE,FALSE,81,3,10,12,2,13);
insert into Ingrediente Values('00000105','Acelga',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000066','00000057');
insert into PertenenciaPlato Values('00000016','00000057');
insert into PertenenciaPlato Values('00000048','00000057');
insert into PertenenciaPlato Values('00000051','00000057');
insert into PertenenciaPlato Values('00000105','00000057');
insert into PertenenciaPlato Values('00000060','00000057');
insert into PertenenciaPlato Values('00000067','00000057');
insert into PertenenciaPlato Values('00000003','00000057');
insert into PertenenciaPlato Values('00000006','00000057');


insert into Plato Values ('00000058','Guisantes con jamon','Guisantes con jamon en tacos',FALSE,FALSE,FALSE,FALSE,FALSE,81,3,10,12,2,13);
insert into PertenenciaPlato Values('00000050','00000058');
insert into PertenenciaPlato Values('00000042','00000058');
insert into PertenenciaPlato Values('00000016','00000058');
insert into PertenenciaPlato Values('00000042','00000058');
insert into PertenenciaPlato Values('00000004','00000058');
insert into PertenenciaPlato Values('00000003','00000058');
insert into PertenenciaPlato Values('00000006','00000058');
insert into PertenenciaPlato Values('00000013','00000058');
insert into PertenenciaPlato Values('00000026','00000058');


insert into Plato Values ('00000059','Ensalada de alubias','Ensalada de alubias cocidas con pimiento asado',FALSE,TRUE,TRUE,FALSE,FALSE,81,3,10,12,2,13);
insert into Ingrediente Values('00000106','Pepinillo',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000093','00000059');
insert into PertenenciaPlato Values('00000016','00000059');
insert into PertenenciaPlato Values('00000017','00000059');
insert into PertenenciaPlato Values('00000018','00000059');
insert into PertenenciaPlato Values('00000106','00000059');
insert into PertenenciaPlato Values('00000013','00000059');
insert into PertenenciaPlato Values('00000044','00000059');
insert into PertenenciaPlato Values('00000003','00000059');
insert into PertenenciaPlato Values('00000025','00000059');
insert into PertenenciaPlato Values('00000006','00000059');


insert into Plato Values ('00000060','Ensalada de escabeche','Ensalada de escabeche con aceitunas, huevos cocidos y chicharro',FALSE,FALSE,FALSE,FALSE,FALSE,81,3,10,12,2,13);
insert into Ingrediente Values('00000107','Chicharro',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000073','00000060');
insert into PertenenciaPlato Values('00000064','00000060');
insert into PertenenciaPlato Values('00000016','00000060');
insert into PertenenciaPlato Values('00000013','00000060');
insert into PertenenciaPlato Values('00000060','00000060');
insert into PertenenciaPlato Values('00000107','00000060');
insert into PertenenciaPlato Values('00000005','00000060');
insert into PertenenciaPlato Values('00000003','00000060');
insert into PertenenciaPlato Values('00000025','00000060');
insert into PertenenciaPlato Values('00000006','00000060');






