#!/bin/bash
#This is a shebang. It tells Linux which interpreter to use.
#!/bin/bash is the standard linux command interpreter  



#make a folder for year and month
mkdir -p ~/journals/$(date +%Y)/$(date +%m)
# S() means run this command and put the result here


#-e tells echo to interpret escape codes
#\e[32 switches the color
#\e[0m resets back to normal color 
echo -e "\e[36m Opening journal...Happy Journaling :)\e[0m"

sleep 3

JOURNAL=~/journals/$(date +%Y)/$(date +%m)/$(date +%Y-%m-%d).txt

micro $JOURNAL
#open a text file with todays date 


echo "Word Count: $(wc -w < $JOURNAL)"

echo "Journal Closed. Thanks for your thoughts!"
sleep 3
 

