#!/usr/bin/env bash
age=$(awk -F '\t' '{print $6}' worldcupplayer.txt)
pos=$(awk -F '\t' '{print $5}' worldcupplayer.txt)
name=$(awk -F '\t' '{print $9}' worldcupplayer.txt)
num=0
le20=0
be2030=0
by30=0
old=0
young=100
oldname=" "
youngname=" "
for i in ${age} ;
	do  
       		if [ "$i"  -lt 20 ]; then
	       		le20=$(( le20+1 ))
       		fi
       		if [[ "$i" -ge 20 && $i -le 30 ]]; then
	       		be2030=$(( be2030+1 ))
       		fi
      		if [ "$i" -gt 30 ]; then
	      		by30=$(( by30+1 ))
      		fi 
      		if [ "$i" -lt "$young" ]; then
	      		young=$i
	      		youngname=$(awk -F '\t' 'NR=='$(( num+1 ))'{print $9}' worldcupplayer.txt)
      		fi
      		if [ "$i" -gt "$old" ]; then
	      		old=$i
	      		oldname=$(awk 'NR=='$(( num+1 ))'{print $9}' worldcupplayer.txt) 
      		fi
      		num=$(( num+1 ))
	done
num=$(( num-1 ))
p20=$(awk 'BEGIN{printf "%.2f\n",'$le20*100/$num'}')
p2030=$(awk 'BEGIN{printf "%.2f\n",'$be2030*100/$num'}')
p30=$(awk 'BEGIN{printf "%.2f\n",'$by30*100/$num'}')
echo "小于20 $le20 $p20%"
echo "2030之间 $be2030 $p2030%"
echo "大于30 $by30 $p30%"
echo "最年轻"
echo "$young"
echo "$youngname"
echo "最年长"
echo "$old"
echo "$oldname"
declare -A arr
for n in $pos;
do
	if [ "$n" != 'Position' ];then
	
		if [[ !${arr["$n"]} ]];then
			let arr["$n"]+=1
		else 
			arr["$n"]=0
		fi
	fi
done
for j in "${!arr[@]}"
do
	echo "$j $(awk 'BEGIN{printf "%.2f",'${arr["$j"]}*100/$num'}')%"
done
min=100
max=0
minn=''
maxn=''
for na in $name;
do
	if [ ${#na} -gt $max ];then
		max=${#na}
		maxn="$na"
	fi
	if [ ${#na} -lt $min ];then
		min=${#na}
		minn="$na"
	fi
	
done
echo "$max '$maxn'"
echo "$min '$minn'"
