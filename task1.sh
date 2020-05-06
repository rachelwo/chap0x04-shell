#!usr/bin/env bash
function help
{
	echo "-q 对jpeg格式图片进行图片质量压缩"
	echo "-c 对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率"
	echo "-w 对图片批量添加自定义文本水印"
	echo "-p 统一添加文件名前缀"
	echo "-s 统一添加文件名后缀"
	echo "-t 将png/svg图片统一转换为jpg格式图片"
	echo "-h 内置帮助文档"
}
function qu {
	for i in *.jpg;
	do
		convert -quality "$1" "$i" ../new/"qu$1$i" 
	done
}

function compress {
	for i in *;
	do
		convert -resize "$1" "$i" ../new/"$1$i"
	done
}

function watermark {
	for i in *;
	do
		convert "$i" -gravity southeast -fill black -pointsize 16 -draw "text 5,5 'rachelwo'" ../new/"W$i"
	done
}
function preffix
{
	for i in *;
	do
		cp "$i" "$1$i"
	done
}
function suffix {
	for i in *;
	do
		file="$i"
		filename=${file%.}
		extention=${file##.}
		cp "$i" "$filename$1.$extention"
	done
}
function transform {
	mogrify -path ../new -format jpg *.svg
	mogrify -path ../new -format jpg *.png
}
until [ "$#" -eq 0 ]
do
	case "$1" in 
		"-q")
			qu $2
			shift 2
			;;
		"-c")
			compress $2
			shift 2
			;;
		"-w")
			watermark
			shift 1
			;;
		"-p")
			preffix "$2"
			shift 1
			;;
		"s")
			suffix "$2"
			shift 2
			;;
		"t")
			transform
			shift 1
			;;
		"-h")
			help
			shift 1
			;;
	esac
done
