# Swarm集群

# 集群配置
$managers=1
$workers=2

# 网络配置
$network="share"

# Docker配置
$subnet="192.168.10.1/24"
$http_proxy=""
#$http_proxy="http://172.17.18.80:80"
$no_proxy="localhost"
$mirror="https://3qjmpcfe.mirror.aliyuncs.com"
$registry="registry.cn-hangzhou.aliyuncs.com:80"


# 创建
function create($args){
    echo "====创建集群===="
	
	echo "======> 创建管理节点 ..."
	for($i=1;$i -le $managers;$i++){
		echo "======> 创建swarm-manager$i 节点 ..."
		docker-machine create -d hyperv `
                    --engine-opt ("bip="+$subnet)`
                    --engine-env ("HTTP_PROXY="+$http_proxy) `
                    --engine-env ("HTTPS_PROXY="+$http_proxy) `
                    --engine-env ("NO_PROXY="+$no_proxy) `
                    --engine-insecure-registry=$registry `
                    --engine-registry-mirror=$mirror `
                    --hyperv-virtual-switch $network swarm-manager$i
	}
	
	echo "======> 创建工作节点 ..."
	for($i=1;$i -le $workers;$i++){
		echo "======> 创建swarm-worker$i 节点 ..."
				docker-machine create -d hyperv `
                    --engine-opt ("bip="+$subnet)`
                    --engine-env ("HTTP_PROXY="+$http_proxy) `
                    --engine-env ("HTTPS_PROXY="+$http_proxy) `
                    --engine-env ("NO_PROXY="+$no_proxy) `
                    --engine-insecure-registry=$registry `
                    --engine-registry-mirror=$mirror `
                    --hyperv-virtual-switch $network swarm-worker$i
	}
	
	echo "======> 节点列表 ..."
	docker-machine ls --filter name="swarm-*"
	
	echo "======> 初始Swarm集群 ..."
	$manager1ip = docker-machine ip swarm-manager1
	docker-machine ssh swarm-manager1 "docker swarm init --listen-addr $manager1ip --advertise-addr $manager1ip"

	echo "======> 生成Tocken ..."
	$managertoken=docker-machine ssh swarm-manager1 "docker swarm join-token manager -q"
	$workertoken=docker-machine ssh swarm-manager1 "docker swarm join-token worker -q"
	echo "======> 生成Manager tocken: $managertoken"
	echo "======> 生成Worker  tocken: $workertoken"
	
	echo "======> 添加管理节点 ..."
	for($i=2;$i -le $managers;$i++){
		echo "======> 节点swarm-manager$i 添加至集群 ..."
		docker-machine ssh swarm-manager$i "docker swarm join --token $managertoken $manager1ip"
	}
	docker-machine ssh swarm-manager1 "docker node ls"
	
	echo "======> 添加工作节点 ..."
	for($i=1;$i -le $workers;$i++){
		echo "======> 节点swarm-worker$i 添加至集群 ..."
		docker-machine ssh swarm-worker$i "docker swarm join --token $workertoken $manager1ip"
	}
	docker-machine ssh swarm-manager1 "docker node ls"
	
	echo "====创建完成===="
	
}
# 登录
function sshe(){
    $lists=lists
    if($lists -ne $null){
	    echo "====登录集群===="
	    docker-machine ssh swarm-manager1
    }else{
        echo "集群为空"
    }
}
# 销毁
function claer(){
    $lists=lists
    if($lists -ne $null){
        echo "====销毁集群===="
	    docker-machine rm -f $lists
    }else{
        echo "集群为空"
    }
}
# 启动
function strat(){
    $lists=lists
    if($lists -ne $null){
        echo "====启动集群===="
	    docker-machine start $lists
    }else{
        echo "集群为空"
    }
}
# 停止
function stop(){
	$lists=lists
    if($lists -ne $null){
        echo "====停止集群===="
	    docker-machine stop $lists
    }else{
        echo "集群为空"
    }
}
# 重启
function restart(){
	$lists=lists
    if($lists -ne $null){
        echo "====重启集群===="
	    docker-machine restart $lists
    }else{
        echo "集群为空"
    }
}
# 状态
function status(){
    $lists=lists
    if($lists -ne $null){
	    echo "====节点状态===="
	    docker-machine ls --filter name="swarm-*"	
    }else{
        echo "集群为空"
    }
}
# 节点
function lists(){
    return (docker-machine ls --filter name="swarm-*" -q)
}
# 节点
function nodes(){
    docker-machine ls --filter name="swarm-*"
}
# 帮助
function help(){
	echo "====帮助信息===="
	echo "Usage: swarm [ssh|create|clear|nodes|start|stop|restart|status|nodes|help]"
}
# 主函数
function main($arg){
	$cmd=$arg[0]
	switch($cmd){
		
		"ssh"     {sshe;break}
		"stop"    {stop;break}
		"start"   {strat;break}
        "nodes"   {nodes;break}
		"clear"   {claer;break}
		"status"  {status;break}
		"create"  {create $arg;break}
		"restart" {restart;break}
		
		default   {help;break}
	}
}
main $args