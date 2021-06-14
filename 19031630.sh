#!/bin/bash
#Declaring function
# this WelcomeUser function is used to display the logged in username and ID and the date the program is running
WelcomeUser(){
	echo ""
	echo "--------------------------------------------------------------------"
	echo "Welcome to the selection game!!!"
	echo "You are logged in as:" $1
	echo "Your logged in user ID is:" $2	
	echo "Program is starting at "$( date)
	echo "--------------------------------------------------------------------"
	echo ""
}
#this SelectCountry function is used to display country names and codes for the user to select the country for moving to further round
#this function calls SelectTeam function
SelectCountry(){
	echo "--------------------------------------------------------------------"
        echo "WELCOME TO LEVEL ONE"
        echo "HINT: Here you have to guess the best football team in the world"
        echo "-------------------------GOOD LUCK-------------------------------"
        echo "*****************************************************************"
        echo "HERE ARE THE FIVE BEST INTERNATIONAL FOOTBALL TEAMS "
        echo ""
        echo "_______________________"
        echo "|S.N |Countries |Code |"
        echo "......................."
        echo "|1   |Brazil    |BRZ  |"
        echo "|2   |Argentina |ARG  |"
        echo "|3   |Nepal     |NEP  |"
        echo "|4   |China     |CHI  |"
        echo "|5   |England   |ENG  |"
        echo "......................."
        echo ""
        echo "--------------------------------------------------------------------"
        SelectTeam
}
#SelectTeam function is used to set the best country in the world  i.e. Brazil and error messages are coded  if the user inputs any country codes except brazil
#this function calls playerlist function
SelectTeam(){
	nationSelect=""
	until [[ $nationSelect == BRZ ]]
	do
		echo ""
		echo -e "Please enter the country code of your guessed team: \c"
		echo ""
	read nationSelect
	case $nationSelect in
	"BRZ") echo "Congratulations! You made the correct guess. Brazil have won world cup five times"
	;;
	"ARG") echo "Sorry! You guessed wrong answer . Please try again."
	;;
	"CHI") echo "Sorry! You guessed wrong answer . Please try again."
	;;
	"NEP") echo "Sorry! You guessed wrong answer . Please try again."
	;;
	"ENG") echo "Sorry! You guessed wrong answer . Please try again."
	;;
	*) echo "It seems you did not enter the correct country code, please input the correct country code of your guessed team"
	echo ""
	esac
	done
	echo ""
	PlayerList
}
# PlayerList function is used to display player name and player code so that the user can select three player codes and move on next round
#Error messages are displayed from this function if the user enters wrong player code or enters less or  more than three player code and duplicate entries are also checked
#this function calls PlayerChoosen function by passing 3 parameters
PlayerList(){
	echo "--------------------------------------------------------------------"
	echo "WELCOME TO LEVEL TWO"
	echo "Here are the list of five best football players of the world"
	echo "__________________________"
	echo "|S.N |Players       |Code|"
	echo ".........................."
  	echo "|1   |Lionel Messi  |LM  |"
 	echo "|2   |Neymar Junior |NJ  |"
 	echo "|3   |Kiran Chemjog |KC  |"
	echo "|4   |Zheng Zhi     |ZZ  |"
	echo "|5   |Harry Kane    |HK  |"
	echo ".........................."
	echo ""
	echo "HINT: HERE YOU HAVE TO CHOOSE THREE OF THE BEST PLAYERS"
  	echo ""
    	echo -e "Please enter the players code(BY SEPARATING THEM WITH SPACE): \c"
	read FP1 FP2 FP3
	choose=($FP1 $FP2 $FP3)
	numOfArg=${#choose[@]}
	if [[ ${#choose[@]} -eq 3 ]]
	then
        	if [ $FP1 = $FP2 ] || [ $FP1 = $FP3 ] || [ $FP2 = $FP3 ]
        	then
        		echo -e "ERROR INPUT!"
        		echo -e "YOU ENTERED THE SAME PLAYER CODE TWICE! PLEASE TRY AGAIN"
        		echo -e ""
        		PlayerList
        	else
        		for n in $choose
        		do
        			if [[ $n == "LM" || $n == "NJ" || $n == "KC" || $n == "ZZ" || $n == "HK" ]]
        			then
        	 			continue 	
        	 		else
        	 			echo ""
        	 			echo "INVALID PLAYER CODE! PLEASE ENTER VALID PLAYER CODE."
        	 			PlayerList
        	 		fi
        	   	done
        	fi
        	PlayerChoosen 3
        else
        	echo ""
        	echo -e "ERROR"
        	echo -e "PLEASE ENTER THREE PLAYER CODE SEPARATED BY SPACE"
       PlayerList
       fi
 }
#this function is used to select one out of three players that are passed from PlayerList function
#the three players LM, NJ and KC are linked to their respective files
#the player ZZ and HK dont have their files so they dont display their details
PlayerChoosen(){
	if [ $1 == 3 ] 
	then
		echo ""
		echo "CONGRATULATIONS! YOU HAVE MADE TO LEVEL 3"
		echo "Among the three best players. Choose your one favorite player"
		PS3="Select the player: "
		select player in $FP1 $FP2 $FP3 
		do
			case $player in
			"LM")
			     cat LM
			     break
			  ;;
			 "NJ")
			     cat NJ
			     break
			  ;;
			  "KC")
			     cat KC
			     break
			  ;;
			  "ZZ")
			     echo "Sorry! there is currently no details of the player"
			     break
			  ;;
			  "HK")
			     echo "Sorry! there is currently no details of the player"
			     break
			  ;;
			  *)
			  	echo "Invalid input"
			  	PlayerChoosen 3
			  ;;
                     esac
                done
               Contd
           else
                 echo ""
                 echo "Warning!! Please enter valid input"
                 PlayerList
           fi
}
#this function is called after the user successfully completes all the levels
#yes input causes the program to repeat whereas any other keys results in termination of the program
Contd(){
	echo ""
	echo -e "Do you want to continue this again? If you want than enter 'yes' and 'no or any key'  to exit: \c"
	echo ""
	read answer
	if [ $answer == yes ]
	then
		SelectCountry
	else
		exit
	fi
}
#the secret code is also made  and incase of 4 consecutive failed attempts the program terminates immediately
#it asks for the user name and ID while starting the program
#It calls the function SelectCountry and WelcomeUser
Secretcode=1234
if [ $# == 2 ]
then
	a=0
   	while [[ $a -lt 4 ]]
   	do
		echo -e "Enter the secret key:  \c"
		read  -s secretKey
		if [[ $secretKey == $Secretcode ]]
		then
			WelcomeUser $1 $2
			SelectCountry
		break
		
		else
			echo "Wrong! Please enter the valid secret Key $SecretKey."
			((a++))
		fi
       done
else
	echo "Please enter First Name and ID number for starting the program"
fi 

