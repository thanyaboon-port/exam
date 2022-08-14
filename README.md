ขั้นตอนการติดตั้ง
ทำการติดตั้ง docker hub 

ทำการ pull docker postgres  สำหรับใช้เป็น   database ต้นทาง source โดยใช้คำสั่ง  docker pull postgres

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



 
 





