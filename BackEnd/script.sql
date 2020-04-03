drop table Usuario;
drop table Guardado;
drop table Dieta;
drop table Entrada;
drop table Comentario;
drop table PlatoMenu;
drop table Plato;
drop table PertenenciaPlato;
drop table Ingrediente;
 
create table Usuario(
	nombre					char(40) not null,
	nombreUsuario			char(20) not null,
	contraseña				char(20) not null,
	correo					char(20) not null,
	favorito				char(20),
	foreign key(favorito) references Dieta,
	primary key(nombreUsuario)
);


create table Guardado(
	nombreUsuario			char(20) not null,
	codigoDieta				char(20) not null,
	foreign key(nombreUsuario) references Usuario,
	foreign key(codigoDieta) references Dieta,
	primary key(nombreUsuario, codigoDieta)
);

create table Entrada(
	codigoEntrada			char(20) not null,
	titulo					char(50) not null,
	cuerpo					char(500),
	nombreUsuario			char(20) not null,
	fecha					date not null,
	foreign key(nombreUsuario) references Usuario,
	primary key(codigoEntrada)
);

create table Comentario(
	codigoComentario		char(20) not null,
	codigoPadre				char(20) not null,
	cuerpo					char(500) not null,
	nombreUsuario			char(20) not null,
	fecha					date not null,
	foreign key(codigoPadre) references Entrada,
	foreign key(nombreUsuario) references Usuario,
	primary key(codigoComentario)
);

create table PlatoMenu(
	codigoPlato				char(20) not null,
	codigoDieta				char(20) not null,
	diaSemana				date not null,
	momento					time not null,
	foreign key(codigoPlato) references Plato, 
	foreign key(codigoDieta) references Dieta,
	primary key(codigoPlato, codigoDieta)
);	

create table Plato(
	codigoPlato 			char(20) not null,,
	desayuno				boolean,
	kcal					real not null,
	glucidos 				boolean,
	aminoacidos				boolean,
	proteinas				boolean,
	hidratosDeCarbono		boolean,
	descripcion				char(500),
	vegano					boolean,
	vegetariano				boolean,
	frutosSecos				boolean,
	gluten					boolean,
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
	codigoIngrediente		char(20) not null,
	macromolecula			boolean,
	vegano 					boolean,
	vegetariano				boolean,
	frutosSecos         	boolean,
	gluten		         	boolean,
	primary key(codigoIngrediente)
);