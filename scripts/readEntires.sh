#!/bin/bash

echo -e "\e[33m=======PAST ENTRIES=======\e[0m"
find ~/journals -name "*.txt" | xargs -I{} basename {} .txt | sort


echo -e "Enter the date you want to read (YYYY-MM-DD):"
read DATE
YEAR=$(echo $DATE | cut -d'-' -f1)
MONTH=$(echo $DATE | cut -d'-' -f2)

if [ -f ~/journals/$YEAR/$MONTH/$DATE.txt ]; then
	echo -e "\e[33m Fetching Entry...\e[0m"
	micro ~/journals/$YEAR/$MONTH/$DATE.txt
else 
	echo -e "\e[31mNO entry found for $DATE\e[0m"
	sleep 2
fi

