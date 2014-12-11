#!/usr/bin/ruby
# encoding: utf-8

=begin
	Script de Ruby, papelera
	Administración de Sistemas Operativos
	Isabel Quintero Sánchez
=end

PARAM1= ARGV[0] || ""
PARAM2= ARGV[1]
PARAM3= ARGV[2]

RUTA_HOME = `echo $HOME`;
RUTA_PAPELERA = "#{RUTA_HOME.chomp!}/.papelera";

if (File.exist?(RUTA_PAPELERA)==true)
	puts "La papelera existe"
else
	system ("mkdir " + RUTA_PAPELERA)
	system ("chmod 777 " + RUTA_PAPELERA)
	puts "Papelera creada."
end
	
if PARAM1 == "--help" then
	puts "Muestra la ayuda"
	puts "--info= Se mostrará informe del número de ficheros que hay en la papelera."
	puts "--clean= Elimina todo el contenido de la papelera de forma definitiva."
	puts "-r, fichero de destino= Recupera un fichero"
	puts "-i= Se mostrará un menú que permita entre vaciar papelera o mostrar estadisticas"
	puts "file= Nombre del fichero que queremos enviar a la papelera."
	
elsif PARAM1 == "-r" then 
	`mv #{RUTA_PAPELERA}/#{PARAM2} #{PARAM3}`
	puts "Archivo recuperado"
elsif PARAM1 == "--info" then
	puts "Número de archivos:"
	system("find #{RUTA_PAPELERA} -type  f | wc -l") #cuenta el número de archivos.
	puts "Número de directorios:"
	system("find #{RUTA_PAPELERA} -type  d | wc -l") #cuenta el número de directorios.
elsif PARAM1 == "--clean" then
	`rm -dfr #{RUTA_PAPELERA}`
	puts "Papelera limpia."
elsif PARAM1 == "-i" then
	puts "Elija si quiere usar 1: --info 2: --clean"
	valor = $stdin.gets.chomp!
	if valor == "1" then
		puts "Número de archivos:"
		system("find #{RUTA_PAPELERA} -type  f | wc -l")
		puts "Número de directorios:"
		system("find #{RUTA_PAPELERA} -type  d | wc -l")
	elsif valor == "2" then 
		puts "¿Estás seguro de eliminar los archivos?"
		valor = $stdin.gets.chomp!.upcase
		if valor == "SI"
			`rm -dfr #{RUTA_PAPELERA}`
			puts "Papelera limpia."
		else
			puts "Salir del programa."
			exit
		end
	else
		puts "Opción incorrecta."
	end
elsif PARAM1 == "" then
	puts "papelera.rb [ --help | -r file [destino] | --info | --clean | file ]"
else
	puts "Opción de mover archivo"
	`mv #{PARAM1} #{RUTA_PAPELERA}`
end
