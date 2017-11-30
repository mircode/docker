select pt_user,pt_date,sum(pt_count) as pt_count from analysis_day where pt_date>='20150511' and pt_date<='20150901' and pt_user='taobao' group by pt_user,pt_date order by pt_date asc limit 100;

use dfs.tmp;
alter session set `store.format`='parquet';
create table month2015 partition by(pt_data) as select * from mongo.perftrace.`analysis_day` where pt_date='20150511';



# size
# du -h .
# du -h 0_0_1.parquet
# 12K     0_0_1.parquet
# path
select * from dfs.`/tmp/monthabc/0_0_1.parquet` limit 20;
# table
select * from dfs.tmp.`monthabc` limit 20;


create table dfs.tmp.`2017` partition by(pt_date) as select * from mongo.perftrace.`analysis_day` where pt_date='20150511';

create table dfs.tmp.`log/2016/01` partition by(pt_date) as select * from mongo.perftrace.`analysis_day` where pt_date>='20160101' and pt_date<'20160201';
create table dfs.tmp.`log/2016/02` partition by(pt_date) as select * from mongo.perftrace.`analysis_day` where pt_date>='20160201' and pt_date<'20160301';
create table dfs.tmp.`log/2016/03` partition by(pt_date) as select * from mongo.perftrace.`analysis_day` where pt_date>='20160301' and pt_date<'20160401';
create table dfs.tmp.`log/2016/04` partition by(pt_date) as select * from mongo.perftrace.`analysis_day` where pt_date>='20160401' and pt_date<'20160501';
create table dfs.tmp.`log/2016/05` partition by(pt_date) as select * from mongo.perftrace.`analysis_day` where pt_date>='20160520' and pt_date<'20160601';
create table dfs.tmp.`log/2016/06` partition by(pt_date) as select * from mongo.perftrace.`analysis_day` where pt_date>='20160601' and pt_date<'20160701';
create table dfs.tmp.`log/2016/07` partition by(pt_date) as select * from mongo.perftrace.`analysis_day` where pt_date>='20160701' and pt_date<'20160801';
create table dfs.tmp.`log/2016/08` partition by(pt_date) as select * from mongo.perftrace.`analysis_day` where pt_date>='20160801' and pt_date<'20160901';
create table dfs.tmp.`log/2016/09` partition by(pt_date) as select * from mongo.perftrace.`analysis_day` where pt_date>='20160901' and pt_date<'20161001';
create table dfs.tmp.`log/2016/10` partition by(pt_date) as select * from mongo.perftrace.`analysis_day` where pt_date>='20161001' and pt_date<'20161101';
create table dfs.tmp.`log/2016/11` partition by(pt_date) as select * from mongo.perftrace.`analysis_day` where pt_date>='20161101' and pt_date<'20161201';
create table dfs.tmp.`log/2016/12` partition by(pt_date) as select * from mongo.perftrace.`analysis_day` where pt_date>='20161201' and pt_date<'20170101';


drop table dfs.tmp.`log2/2016/01`;
drop table dfs.tmp.`log2/2016/02`;
drop table dfs.tmp.`log2/2016/03`;
drop table dfs.tmp.`log2/2016/04`;
drop table dfs.tmp.`log2/2016/05`;
drop table dfs.tmp.`log2/2016/06`;
drop table dfs.tmp.`log2/2016/07`;
drop table dfs.tmp.`log2/2016/08`;
drop table dfs.tmp.`log2/2016/09`;
drop table dfs.tmp.`log2/2016/10`;
drop table dfs.tmp.`log2/2016/11`;
drop table dfs.tmp.`log2/2016/12`;






create table dfs.tmp.`log2/2016/01`  as select * from mongo.perftrace.`analysis_day` where pt_date>='20160101' and pt_date<'20160201';
create table dfs.tmp.`log2/2016/02`  as select * from mongo.perftrace.`analysis_day` where pt_date>='20160201' and pt_date<'20160301';
create table dfs.tmp.`log2/2016/03`  as select * from mongo.perftrace.`analysis_day` where pt_date>='20160301' and pt_date<'20160401';
create table dfs.tmp.`log2/2016/04`  as select * from mongo.perftrace.`analysis_day` where pt_date>='20160401' and pt_date<'20160501';
create table dfs.tmp.`log2/2016/05`  as select * from mongo.perftrace.`analysis_day` where pt_date>='20160520' and pt_date<'20160601';
create table dfs.tmp.`log2/2016/06`  as select * from mongo.perftrace.`analysis_day` where pt_date>='20160601' and pt_date<'20160701';
create table dfs.tmp.`log2/2016/07`  as select * from mongo.perftrace.`analysis_day` where pt_date>='20160701' and pt_date<'20160801';
create table dfs.tmp.`log2/2016/08`  as select * from mongo.perftrace.`analysis_day` where pt_date>='20160801' and pt_date<'20160901';
create table dfs.tmp.`log2/2016/09`  as select * from mongo.perftrace.`analysis_day` where pt_date>='20160901' and pt_date<'20161001';
create table dfs.tmp.`log2/2016/10`  as select * from mongo.perftrace.`analysis_day` where pt_date>='20161001' and pt_date<'20161101';
create table dfs.tmp.`log2/2016/11`  as select * from mongo.perftrace.`analysis_day` where pt_date>='20161101' and pt_date<'20161201';
create table dfs.tmp.`log2/2016/12`  as select * from mongo.perftrace.`analysis_day` where pt_date>='20161201' and pt_date<'20170101';


create table dfs.tmp.`log3/2016/01-04`  as select * from mongo.perftrace.`analysis_day` where pt_date>='20160101' and pt_date<'20160501';
create table dfs.tmp.`log3/2016/05-08`  as select * from mongo.perftrace.`analysis_day` where pt_date>='20160520' and pt_date<'20160901';
create table dfs.tmp.`log3/2016/09-12`  as select * from mongo.perftrace.`analysis_day` where pt_date>='20160901' and pt_date<'20170101';


create table dfs.tmp.`log4/2016/01-04`  as select * from mongo.perftrace.`analysis_day` where pt_date>='20160101' and pt_date<'20160501';
create table dfs.tmp.`log4/2016/05-12`  as select * from mongo.perftrace.`analysis_day` where pt_date>='20160520' and pt_date<'20170101';



create table dfs.tmp.`log5/2016/01-04`  as select pt_user,pt_service,pt_code,pt_ip,pt_date,pt_count,pt_user_ip from mongo.perftrace.`analysis_day` where pt_date>='20160101' and pt_date<'20160501';
create table dfs.tmp.`log5/2016/05-12`  as select pt_user,pt_service,pt_code,pt_ip,pt_date,pt_count,pt_user_ip from mongo.perftrace.`analysis_day` where pt_date>='20160520' and pt_date<'20170101';

create table dfs.tmp.`log6/2016`  as select pt_user,pt_service,pt_code,pt_ip,pt_date,pt_count,pt_user_ip from mongo.perftrace.`analysis_day` where (pt_date>='20160101' and pt_date<'20160501') or (pt_date>='20160520' and pt_date<'20170101');

select * from dfs.tmp.`log6/2016` where pt_date='20160601' limit 10;

# 目录查询
https://drill.apache.org/docs/querying-directories/
https://drill.apache.org/docs/query-directory-functions/

# 创建分区表
https://drill.apache.org/docs/create-table-as-ctas/
https://drill.apache.org/docs/partition-by-clause/


# 查看文件
show files;
show files in dfs.tmp.`log2/2016`;

# 空处理
https://drill.apache.org/docs/text-files-csv-tsv-psv/


# 学习博客
https://blog.gmem.cc/apache-drill-study-note
https://www.yuanmas.com/info/n4ObRv9MOw.html