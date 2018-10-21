#!/bin/sh
set tot
set tar
set CLASSROOM
set chk
set WEEKEND
set SLOT

get_time(){
	cat COURSE_TIME.tmp | sed -n "$1,$1p"
}
get_name(){
	cat COURSE_NAME.tmp | sed -n "$1,$1p"
}
get_location(){
	cat COURSE_LOCATION.tmp | sed -n "$1,$1p"
}
preprocess(){
	[ -f course.json ] || curl 'https://timetable.nctu.edu.tw/?r=main/get_cos_list' --data 'm_acy=107&m_sem=1&m_degree=3&m_dep_id=17&m_group=**&m_grade=**&m_class=**&m_option=**&m_crsname=**&m_teaname=**&m_cos_id=**&m_cos_code=**&m_crstime=**&m_crsoutline=**&m_costype=**' > course.json
	cat course.json | awk 'BEGIN {FS="\",\""} {for(i=2; i<=NF; i++) {print $i}}' | grep "cos_ename" | cut -c13- | sed 's/ /_/g' > COURSE_NAME.tmp
	cat course.json | awk 'BEGIN {FS="\",\""} {for(i=2; i<=NF; i++) {print $i}}' | grep "cos_time" | cut -c12- | awk 'BEGIN {FS="-|,"} {for(i=1; i<=NF; i++) {if ($i ~ /^[1-7]/) {printf "%s", $i}}} {printf "\n"}' > COURSE_TIME.tmp
	cat course.json | awk 'BEGIN {FS="\",\""} {for(i=2; i<=NF; i++) {print $i}}' | grep "cos_time" | cut -c12- | awk 'BEGIN {FS="-|,"} {printf "_@" } {for(i=0; i<NF; i++) {if ($i ~ /^[A-Z]/) {printf "%s,", $i}}} {printf $NF "\n"}' > COURSE_LOCATION.tmp
	
	tot=$(cat COURSE_TIME.tmp | wc -l)

	if [ ! -f COURSE_INFO.tmp ]; then
		touch COURSE_INFO.tmp
		i=1
		while [ $i -le ${tot} ]; do
			COURSE_NAME=$(get_name $i)
			COURSE_TIME=$(get_time $i)
			echo "$i ${COURSE_TIME}-${COURSE_NAME}" >> COURSE_INFO.tmp
			i=$(($i+1))
		done
	fi
	
}

set time

to_int(){
	if [ $1 = "M" ];then time="0"
	elif [ $1 = "N" ];then time="1"
	elif [ $1 = "A" ];then time="2"
	elif [ $1 = "B" ];then time="3"
	elif [ $1 = "C" ];then time="4"
	elif [ $1 = "D" ];then time="5"
	elif [ $1 = "X" ];then time="6"
	elif [ $1 = "E" ];then time="7"
	elif [ $1 = "F" ];then time="8"
	elif [ $1 = "G" ];then time="9"
	elif [ $1 = "H" ];then time="10"
	elif [ $1 = "Y" ];then time="11"
	elif [ $1 = "I" ];then time="12"
	elif [ $1 = "J" ];then time="13"
	elif [ $1 = "K" ];then time="14"
	elif [ $1 = "L" ];then time="15"
	fi
}
to_str(){
	if [ $1 -eq 0 ];then time="M"
	elif [ $1 -eq 1 ];then time="N"
	elif [ $1 -eq 2 ];then time="A"
	elif [ $1 -eq 3 ];then time="B"
	elif [ $1 -eq 4 ];then time="C"
	elif [ $1 -eq 5 ];then time="D"
	elif [ $1 -eq 6 ];then time="X"
	elif [ $1 -eq 7 ];then time="E"
	elif [ $1 -eq 8 ];then time="F"
	elif [ $1 -eq 9 ];then time="G"
	elif [ $1 -eq 10 ];then time="H"
	elif [ $1 -eq 11 ];then time="Y"
	elif [ $1 -eq 12 ];then time="I"
	elif [ $1 -eq 13 ];then time="J"
	elif [ $1 -eq 14 ];then time="K"
	elif [ $1 -eq 15 ];then time="L"
	fi
}
showclass(){
	printf "first_line" > table.tmp
	i=1
	while [ $i -le $((132)) ];do
		cat TABLE.tmp | sed -n "$(($i)),$(($i))p" | awk 'BEGIN {FS="@"} {print $2}' >> table.tmp
		i=$(($i+1))
	done
}
showname(){
	printf "" > table.tmp
	i=1
	while [ $i -le $((132)) ];do
		cat TABLE.tmp | sed -n "$(($i)),$(($i))p" | awk 'BEGIN {FS="@"} {print $1}' >> table.tmp
		i=$(($i+1))
	done
}
Display() {
	if [ ${CLASSROOM} = "True" ];then
		showclass
	else
		showname
	fi
	if [ ${WEEKEND} = "False" ];then
		printf "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-" > DISPLAY.tmp
	else
		printf "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-" > DISPLAY.tmp
	fi
	printf "\n" >> DISPLAY.tmp 

	printf "   |   Mon   |   Tue   |   Wed   |   Thu   |   Fri   |" >> DISPLAY.tmp
	if [ ${WEEKEND} = "True" ]; then
		printf "   Sat   |   Sun   |" >> DISPLAY.tmp
	fi
	printf "\n" >> DISPLAY.tmp 



	i=0
	while [ $i -le 15 ]; do

		if [ ${SLOT} = "False" ]; then
			if [ $i -eq 0 ] || [ $i -eq 1 ] || [ $i -eq 6 ] || [ $i -eq 11 ] || [ $i -eq 15 ]; then
				i=$(($i+1))	
				continue
			fi
		fi 

		if [ ${WEEKEND} = "True" ];then
			printf "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-" >> DISPLAY.tmp
		else
			printf "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-" >> DISPLAY.tmp
		fi
		printf "\n" >> DISPLAY.tmp
		to_str $i

		j=0
		while [ $j -le 7 ]; do
			Mon=`cat TABLE.tmp | sed -n "$((($i*7)+2)),$((($i*7)+2))p" | cut -c$((($j*7)+1))-$((($j*7)+7))`
			Tue=`cat TABLE.tmp | sed -n "$((($i*7)+3)),$((($i*7)+3))p" | cut -c$((($j*7)+1))-$((($j*7)+7))`
			Wed=`cat TABLE.tmp | sed -n "$((($i*7)+4)),$((($i*7)+4))p" | cut -c$((($j*7)+1))-$((($j*7)+7))`
			Thu=`cat TABLE.tmp | sed -n "$((($i*7)+5)),$((($i*7)+5))p" | cut -c$((($j*7)+1))-$((($j*7)+7))`
			Fri=`cat TABLE.tmp | sed -n "$((($i*7)+6)),$((($i*7)+6))p" | cut -c$((($j*7)+1))-$((($j*7)+7))`
			Sat=`cat TABLE.tmp | sed -n "$((($i*7)+7)),$((($i*7)+7))p" | cut -c$((($j*7)+1))-$((($j*7)+7))`
			Sun=`cat TABLE.tmp | sed -n "$((($i*7)+8)),$((($i*7)+8))p" | cut -c$((($j*7)+1))-$((($j*7)+7))`
			
			if [ ${WEEKEND} = "True" ]; then
				if [ $j -eq 3 ]; then
					printf " %-1s | %-7s | %-7s | %-7s | %-7s | %-7s | %-7s | %-7s |\n" ${time} ${Mon:="_"} ${Tue:="_"} ${Wed:="_"} ${Thu:="_"} ${Fri:="_"} ${Sat:="_"} ${Sun:="_"} >> DISPLAY.tmp
				else
					printf "   | %-7s | %-7s | %-7s | %-7s | %-7s | %-7s | %-7s |\n" ${Mon:="_"} ${Tue:="_"} ${Wed:="_"} ${Thu:="_"} ${Fri:="_"} ${Sat:="_"} ${Sun:="_"} >> DISPLAY.tmp
				fi
			else
				if [ $j -eq 3 ]; then
					printf " %-1s | %-7s | %-7s | %-7s | %-7s | %-7s |\n" ${time} ${Mon:="_"} ${Tue:="_"} ${Wed:="_"} ${Thu:="_"} ${Fri:="_"} >> DISPLAY.tmp
				else
					printf "   | %-7s | %-7s | %-7s | %-7s | %-7s |\n" ${Mon:="_"} ${Tue:="_"} ${Wed:="_"} ${Thu:="_"} ${Fri:="_"} >> DISPLAY.tmp
				fi
			fi
			j=$(($j+1))
		done
		i=$(($i+1))
	done
	
	if [ ${WEEKEND} = "True" ];then
		printf "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-" >> DISPLAY.tmp
	else
		printf "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-" >> DISPLAY.tmp
	fi

	dialog --textbox DISPLAY.tmp 50 80
	result=$?
	main_page
}
accept() {
	dialog --title "Accept" --ok-label "OK" --msgbox "Accept" 10 20
	main_page
}
reject() {
	dialog --title "Reject" --ok-label "OK" --textbox COLLISION.tmp 30 50
	main_page
}
set chk
check() {
	COURSE_TIME=$(get_time $1)
	echo "Find collisions" >COLLISION.tmp
	while [ "${COURSE_TIME}" != "" ]; do
		a=$(echo ${COURSE_TIME} | cut -c1-1)
		COURSE_TIME=$(echo ${COURSE_TIME} | cut -c2-)
		while [ "$(echo ${COURSE_TIME} | grep "^[A-Z]")" != "" ]; do
			para=$(echo ${COURSE_TIME} | cut -c1-1)
			to_int ${para}

			current=$(cat TABLE.tmp | sed -n "$(((${time}*7)+$a+1)),$(((${time}*7)+$a+1))p")
			echo ${current}
			if [ ${current} != "_" ]; then
				chk="F"
				echo "$a${para} ${current} " >> COLLISION.tmp
			fi
			COURSE_TIME=$(echo ${COURSE_TIME} | cut -c2-)	
		done
	done
}
set_course() {
	tar=$(cat input.tmp)
	chk="T"
	check ${tar}
	if [ ${chk} = "T" ];then
	COURSE_NAME=$(get_name ${tar})
	COURSE_TIME=$(get_time ${tar})
	COURSE_LOCATION=$(get_location ${tar})
	echo "${COURSE_TIME} ${COURSE_NAME}${COURSE_LOCATION}" >> CURRENT_COURSE.tmp
	while [ "${COURSE_TIME}" != "" ]; do
	a=$(echo ${COURSE_TIME} | cut -c1-1)
	COURSE_TIME=$(echo ${COURSE_TIME} | cut -c2-)
	while [ "$(echo ${COURSE_TIME} | grep "^[A-Z]")" != "" ]; do
		to_int $(echo ${COURSE_TIME} | cut -c1-1)
			
		cat TABLE.tmp | sed -n "1,$(((${time}*7)+$a))p" > tmp
		echo "${COURSE_NAME}${COURSE_LOCATION}" >> tmp 
		cat TABLE.tmp | sed -n "$(((${time}*7)+$a+2)),150p" >> tmp
		mv tmp TABLE.tmp
				
		COURSE_TIME=$(echo ${COURSE_TIME} | cut -c2-)
	done
	done
		accept
	else
		reject
	fi
}
add_course(){
	dialog --title "ADD COURSE" --menu "" 15 61 ${tot} \
	$(cat COURSE_INFO.tmp) 2>input.tmp
	result=$?

	if [ ${result} -eq 0 ]; then
		set_course
	fi
	main_page
}
reset(){
	echo "first_line" > TABLE.tmp

	i=0
	while [ $i -le $(($tot)) ];do
		echo "_" >> TABLE.tmp
		i=$(($i+1))
	done
	rm CURRENT_COURSE.tmp
	touch CURRENT_COURSE.tmp
	main_page
}
main_page() {
	dialog --title "MENU" --cancel-label "EXIT" --menu "" 16 45 4 \
	"1" "Timetable" \
	"2" "Add Course" \
	"3" "Reset" \
	"4" "Option" \
	2> input.tmp
	result=$?
	tar=$(cat input.tmp)
	
	if [ ${result} -eq 0 ]; then
		case ${tar} in
			1)
				Display
			;;
			2)
				add_course
			;;
			3)
				reset
			;;
			4)
				option
			;;
		esac
	else
		exit
	fi

}
option(){
	dialog --title "MENU" --cancel-label "EXIT" --menu "" 16 45 7 \
	"1" "Show Classroom" \
	"2" "Show Course Name" \
	"3" "Hide Weekend" \
	"4" "Show Weekend" \
	"5" "Hide Slot" \
	"6" "Show Slot" \
	2> input.tmp
	result=$?
	tar=$(cat input.tmp)
	
	if [ ${result} -eq 0 ]; then
		case ${tar} in
			1)
				CLASSROOM="True"
			;;
			2)
				CLASSROOM="False"
			;;
			3)
				WEEKEND="False"
			;;
			4)
				WEEKEND="True"
			;;
			5)
				SLOT="False"
			;;
			6)
				SLOT="True"
			;;
		esac
	else
		exit
	fi
	main_page
}
build() {
	echo "first_line" > TABLE.tmp

	i=0
	while [ $i -le $(($tot)) ];do
		echo "_" >> TABLE.tmp
		i=$(($i+1))
	done
	rm CURRENT_COURSE.tmp
	touch CURRENT_COURSE.tmp
}
welcome(){
	if [ ! -f CURRENT_COURSE.tmp ] || [ ! -f TABLE.tmp ];then
		build
	fi
	CLASSROOM="False"
	WEEKEND="False"
	SLOT="False"
	main_page
}

preprocess
welcome