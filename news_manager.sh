TOKEN=""
ID=""
URL="https://api.telegram.org/bot$TOKEN/sendMessage"
TOPIC_ID=""
#Location of the HTML code from where the script searches keyword and cuts out
news="" 
#Location of a txt file where the bot writes sent URLs or whatever is searched and sent, to prevent sending same message over and over, trust me, its important
last_news=""

Source URL from where to get the HTML code
page=""

#Get the html of the website and save it into a file
curl -o $news $page

#Cut html out and extract the link, once done send it via telegram
a=$(grep -o -w -P '.{0,0}    -CODE SNIPPED TO BE SEARCHED GOES HERE-   ' $news | head -1 | cut -d '"' -f2- | cut -d '"' -f2- | cut -d '"' -f2- | cut -f1 -d '"' )

#Check if the message is new or old
if ( grep -q $a $last_news ); then 
#News story already sended, skip
        echo knwon new
else
#	if ( $a -ge 5 ); then
	b="$a"
	curl -s -X POST $URL -d chat_id=$ID -d text="$b" -d message_thread_id=$TOPIC_ID
        echo NEW
        echo $a >> $last_news
	sleep 10
#	fi
fi

#Not the cleanest code, but this was a prototype for the bots I use, but my finished bots are private, so Ill just share this early version of it :)

