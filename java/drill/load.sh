#!/bin/bash

# 配置
APP_HOME=/opt/app
WORKSPACE="dfs.tmp"
TARGET="select pt_user,pt_service,pt_code,pt_ip,pt_user_ip,pt_date,pt_count from mongo.perftrace.analysis_day";


# 切割
function splits(){
	str=$1;	token=$2;
	arr=(${str//$token/ })
	echo "${arr[*]}";
}

# 文件
function getPath(){
	file=$1;date=$2;
	table=`date -d "$date" +$file/%Y/%m/%d`;
	echo $table;
}

# 日期
function getDate(){
	offset=$1;date=$2;saveby=$3;
	date=${date:-`date +%Y%m%d`};
	saveby=${saveby:-day};
	date=`date -d "$offset $saveby $date" +%Y%m%d`;
	echo $date;
}

# 执行SQL
function command(){
	workspace=$1;file=$2;date=$3;saveby=$4;
	table='';
	where='';
	if [[ $saveby == "year"  ]]
	then
		table=`date -d "$date" +$file/%Y`;
		start=`getDate 0 $date day`;
		end=`getDate 1 $start year`;
		where="where pt_date>=$start and pt_date<$end";
	elif [[ $saveby == "month"  ]] 
	then 
		table=`date -d "$date" +$file/%Y/%m`;
		start=`getDate 0 $date day`;
		end=`getDate 1 $start month`;
		where="where pt_date>=$start and pt_date<$end";
	else
		table=`date -d "$date" +$file/%Y/%m/%d`;
		start=`getDate 0 $date day`;
		end=`getDate 1 $start day`;
		where="where pt_date=$date";
	fi
	create="create table $workspace.\`$table\` as $TARGET $where";
	drop="drop table if exist $workspace.\`$table\`";
	drill $drop;
	drill $create;
	
}

function drill(){
	echo $*;
	#$APP_HOME/drill/bin/sqlline -u jdbc:drill:drillbit=localhost <<< $*;
}


# 参数
function getParam(){
	args=$1;target=$2;default=$3;
	res=$default;
	for i in ${args[*]}; do
		tokens=`splits $i =`;tokens=(${tokens[*]});
		key=${tokens[0]};
		val=${tokens[1]};
		if [[ $key == $target ]]
		then
			res=$val;break;
		fi
	done
	echo $res;
}


# 主函数
function main(){

	day=`getDate "-2"`;
	date=`getParam "${args[*]}" date $day`;
	file=`getParam "${args[*]}" file res`;
	saveby=`getParam "${args[*]}" saveby day`;
		
	echo "date=$date saveby=$saveby file=$file";
	
	tokens=`splits $date -`;tokens=(${tokens[*]});
	start=${tokens[0]};
	end=${tokens[1]:-`getDate 1 $start`};

	while [[ $start < $end  ]]
	do   
		command $WORKSPACE $file $start $saveby;
		start=`getDate "+1" $start $saveby`;
	done
}


# 接口
# load.sh date=20160101-20170101 file=/log_day   saveby=day
# load.sh date=20160101-20170101 file=/log_year  saveby=year
# load.sh date=20160101-20170101 file=/log_month saveby=month

main $@
