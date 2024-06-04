#!/bin/bash

# 폴더 경로를 입력받습니다.
#read -p "directory path: " directory

# 이동할 디렉토리를 입력받습니다.
#read -p "이동할 디렉토리를 입력하세요: " destination_directory

# 폴더 내의 파일명을 추출합니다.
#file_list=$(ls "$directory")
file_list=$(ls ./)

# 추출한 파일들을 순회하며 이동합니다.
for file in $file_list
do
        #echo "$file"
        extension="${file##*.}"
        #echo "$extension"
		#echo "$file"
        if [ "$extension" = "log" ]; then
			mv $file $file.gz
			gzip -d $file.gz
			sed -i -e "s/\$/,/" $file
			cat $file >> total
               
                


        fi
done
