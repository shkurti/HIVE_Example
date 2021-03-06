set tez.queue.name=queue_name;
set hive.execution.engine=tex;
set hive.exec.parallel=true;
set hive.vectorized.execution.enabled=true;
set hive.vectorized.execution.reduce.enabled=true;
set hive.exec.dynamic.partition.mode=nonstrict;

DROP TABLE IF EXISTS hdfs_database.table_name;
CREATE TEMPORARY TABLE hdfs_database.table_name(
    member_id String,
    first_name String,
    last_name String
)

ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
TBLPROPERTIES("skip.header.line.count"="1");
LOAD DATA INPATH 'hdfs/path/folder/file_folder_name' INTO TABLE hdfs_database.table_name;


DROP TABLE IF EXISTS hdfs_database.table_name_2;
CREATE TEMPORARY TABLE hdfs_database.table_name_2
AS
SELECT DISTINCT
member_id,
firstt_name,
last_name
FROM hdfs_database.table_name
;


DROP TABLE IF EXISTS hdfs_database.final_table;
CREATE TABLE hdfs_database.final_table
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
AS
SELECT DISTINCT 
*
FROM hdfs_database.table_name_2
;
