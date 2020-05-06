#!/usr/bin/env bash
function help
{
	echo "-h 统计访问来源主机TOP 100和分别对应出现的总次数"
	echo "-i 统计访问来源主机TOP 100 IP和分别对应出现的总次数"
	echo "-u 统计最频繁被访问的URL TOP 100"
	echo "-r 统计不同响应状态码的出现次数和对应百分比"
	echo "-c 分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数"
	echo "-C 给定URL输出TOP 100访问来源主机"
	echo "-H 内置帮助文档"
}
function host
{
	sed -e '1d' web_log.tsv|awk -F '\t' '{a[$1]++} END {for(i in a) {print i,a[i]}}'|sort -nr -k2|head -n 100
}
function IP
{
	sed -e '1d' web_log.tsv|awk -F '\t' '{if($1~/^(([0-2]*[0-9]+[0-9]+)\.([0-2]*[0-9]+[0-9]+)\.([0-2]*[0-9]+[0-9]+))$/) print $1}'|awk '{a[$1]++} END {for(i in a){print i,a[i]}}'|sort -nr -k2|head -n 100
}
function url
{
	sed -e '1d' web_log.tsv | awk -F '\t' '{a[$5]++} END {for(i in a){print i,a[i] }}' |  sort -nr -k2 | head -n 100
}
function response
{
	 sed -e '1d' web_log.tsv | awk -F '\t' '{a[$6]++} END {for(i in a){print i,a[i] }}' |  sort -nr -k2 | head -n 100
    sed -e '1d' web_log.tsv | awk -F '\t' '{a[$6]++} END {for(i in a){print i,a[i] }}' |  sort -nr -k2 | awk '{arr[$1]=$2;sums+=$2} END {for (k in arr) print k,arr[k]/sums*100,"%"}'
}
function code4xx
{
     sed -e '1d' web_log.tsv | awk -F '\t' ' {if($6~/^403/) {a[$6":"$1]++}} END {for(i in a){print i,a[i] }}' | sort -nr -k2 | head -n 10
     sed -e '1d' web_log.tsv | awk -F '\t' ' {if($6~/^404/) {a[$6":"$1]++}} END {for(i in a){print i,a[i] }}' | sort -nr -k2 | head -n 10

}
function certainUrl
{
     (sed -e '1d' web_log.tsv|awk -F '\t' '{if($5=="'$1'") a[$1]++} END {for(i in a){print i,a[i]}}'|sort -nr -k2|head -n 10)
}
case $1 in
	-h)
		host
		;;
	-i)
		IP
		;;
	-r)
		response
		;;
	-c)
		code4xx
		;;
	-C)
		certainUrl "$2"
		;;
	-H)
		help
		;;
esac
