ขั้นตอนการติดตั้ง
ทำการติดตั้ง docker hub 

ทำการ pull docker postgres  สำหรับใช้เป็น   database ต้นทาง source โดยใช้คำสั่ง  docker pull postgres

ไปที่ terminal ชอง image postgres

ทำการ clone git repo https://github.com/thanyaboon-port/exam.git

จากนั้นใช้ คำสั่ง sh /exam/shell_script/create_postgres_table.sh เพื่อทำการสร้าง table และ import ของมูลจาก csv file 



ทำการ pull docker ของ mikelemikelo/cloudera-spark:latest สำหรับเพื่อใช้งาน  hdfs, apache hive และ apache sqoop โดยใช้คำสั่ง docker pull mikelemikelo/cloudera-spark:latest

ใช้คำสั่ง docker run --hostname=quickstart.cloudera --privileged=true -it -p 8888:8888 -p
8080:8080 -p 7180:7180 -p 88:88/udp -p 88:88 mikelemikelo/cloudera-spark:latest /usr/bin/docker-quickstart-light สำหรับรัน image ของ cloudera-spark:latest

ทำการรอจนกว่า container จะรัน Hadoop fundamental commands จนเสร็จสิ้น

ใช้คำสั่ง sudo /home/cloudera/cloudera-manager --express && service ntpd start เพื่อทำการใช้งาน Cloudera Manager

ใช้ Public / External IP ของ VM ในการเข้า Cloudera Manager ด้วย port 7180 โดย username = cloudera และ password = cloudera
จากนั้นทำการลบ Service ที่ไม่ได้ใช้งานออก เช่น Spark (Spark ของ CDH เป็น version 1.x.x ส่งผลให้ไม่สามารถใช้งาน spark session ได้ ให้ทำการลบ service ตรงนี้ออก แล้วใช้งาน Spark Local ที่ติดตั้งไว้ใน docker container)

จากนั้นให้ไปที่  terminal  ของ container และทำการ clone git repo https://github.com/thanyaboon-port/exam.git เพื่อทำการ download code ที่ใช้ในการทำ etl และ ingest data 

โดยใน git จะประกอบไปด้วยไฟล์ ดังนี้
Config.ini ใช้เก็บค่า config ต่างๆ ในการทำ etl
Etl.py ใช้สำหรับทำ etl จาก datalake (order_detail (dt), restaurant (dt)) ไปยัง datawarehouse (__order_detail_new__ และ __restaurant_detail_new__)
create_postgres.sh ใช้สำหรับสร้าง table ที่ postgres
etl_main.sh ใช้สำหรับควบคุม การทำ etl
shell_setup_hdfs.sh ใช้สำหรับสร้าง path บน hdfs

ทำการ upload code etl_main.sh ไปบน hdfs โดยใช้คำสั่ง hdfs dfs -put /path เพื่อที่จะได้สามารถตั้ง schedule รันไฟล์ shell แบบ daily 

จากนั้นให้ไปที่ hue server โดยใส่ ip ของเครื่องที่รัน image cloudera-spark โดยเลือก port 8888 ในกรณีที่ยังไม่ได้ start server ของ hue ให้ใช้คำสั่ง service hue start


ต่อมาให้ไปที่ Workflows > Editors > Workflows เพื่อทำการ set schedule สำหรับรัน shell script (etl_main.sh) เพื่อทำ etl แบบ daily โดยใช้ oozie

เมื่อเข้า workflows แล้วให้ไปที่ create > ทำการลาก shell มาวางใน workflow > เลือกไฟล์ etl_main.sh ตาม path ที่ upload file 

เมื่อทำการสร้าง workfolows ของ shell script เรียบร้อยแล้วให้ไปที่ coordinators เพื่อทำการสร้าง schedule ให้กับ workflows โดยเริ่มจาก coordinators > choose workflows > เลือก workflows จากขั้นตอนก่อนหน้า > How often? ให้เลือก every day และเลือกเวลาที่ต้องการรัน > save 

ในกรณีที่ต้องการทดสอบการรัน workflows ให้ไปที่ coordinators > เลือก worksflow ที่ต้องการ > submit > ทำการเลือกเวลา > submit









 
 





