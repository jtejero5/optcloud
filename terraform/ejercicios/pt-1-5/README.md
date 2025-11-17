Practica PT1.5 - Cloud Computing

Paso 1: Configuracion Inicial
Primero definiremos la variables en el variables.tf
las varibales que tenemos que definir son: region, project_name, instance_count, subnet_count, instance_type, instance_ami, create_s3_bucket, vpc_cidr y my_ip

Ahora tenemos que crear el fichero provider.tf donde utilizaremos la variable region

Paso 2: Redes y Subredes 

Creacion de una VPC con el CIDR definido (vpc_cidr)
Creacion de 2 subredes publicas y 2 subredes privadas utilizando count o for_each
Y assignamos un internet gateway para las subredes publicas

Paso 3: Instacias EC2

Creacion de un security group con las siguentes reglas:
Permitir HTTP puerto 80 desde cualquier IP
Permitir SSH puerto 22 solo desde la ip indicada
Bloquear ICMP externo

Paso 4: Bucket S3 condicional

Crear un backet S3 solo si la variable creare_s3_bucket es true, mediante una condicion dentro del codigo de terraform

Paso 5: Outputs

Que en outputs.tf se vean las ID y IP publicas y privadas de las instancias y el nombre del bucket S3 si se ha creado