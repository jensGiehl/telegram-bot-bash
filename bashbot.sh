#!/bin/bash

if [[ -z "$TELEGRAM_BOTNAME"  || -z "$TELEGRAM_CHAT_ID" ]]; then
   echo -e "Please set \033[0;31mTELEGRAM_BOTNAME"\033[0m and \033[0;31mTELEGRAM_CHAT_ID"\033[0m as enviorment variable"
   exit 1
fi


URL='https://api.telegram.org/bot'$TELEGRAM_BOTNAME


MSG_URL=$URL'/sendMessage'
PHO_URL=$URL'/sendPhoto'
DOCUMENT_URL=$URL'/sendDocument'
STICKER_URL=$URL'/sendSticker'

FILE_URL='https://api.telegram.org/file/bot'$TELEGRAM_BOTNAME'/'
declare -A USER MESSAGE URLS CONTACT LOCATION CHAT

urlencode() {
	echo "$*" | sed 's:%:%25:g;s: :%20:g;s:<:%3C:g;s:>:%3E:g;s:#:%23:g;s:{:%7B:g;s:}:%7D:g;s:|:%7C:g;s:\\:%5C:g;s:\^:%5E:g;s:~:%7E:g;s:\[:%5B:g;s:\]:%5D:g;s:`:%60:g;s:;:%3B:g;s:/:%2F:g;s:?:%3F:g;s^:^%3A^g;s:@:%40:g;s:=:%3D:g;s:&:%26:g;s:\$:%24:g;s:\!:%21:g;s:\*:%2A:g'
}


send_normal_message() {
	text="$1"
	until [ $(echo -n "$text" | wc -m) -eq 0 ]; do
		res=$(curl -s "$MSG_URL" -d "chat_id=$TELEGRAM_CHAT_ID" -d "text=$(urlencode "${text:0:4096}")")
		text="${text:4096}"
	done
}

send_markdown_message() {
	text="$1"
	until [ $(echo -n "$text" | wc -m) -eq 0 ]; do
		res=$(curl -s "$MSG_URL" -d "chat_id=$TELEGRAM_CHAT_ID" -d "text=$(urlencode "${text:0:4096}")" -d "parse_mode=markdown" -d "disable_web_page_preview=true")
		text="${text:4096}"
	done
}

send_html_message() {
	text="$1"
	until [ $(echo -n "$text" | wc -m) -eq 0 ]; do
		res=$(curl -s "$MSG_URL" -F "chat_id=$TELEGRAM_CHAT_ID" -F "text=$(urlencode "${text:0:4096}")" -F "parse_mode=html")
		text="${text:4096}"
	done
}

send_file() {
	[ "$1" = "" ] && return
	local chat_id=$TELEGRAM_CHAT_ID
	local file=$1
	echo "$file" | grep -qE $FILE_REGEX || return
	local ext="${file##*.}"
	case $ext in
        	mp3|flac)
			CUR_URL=$AUDIO_URL
			WHAT=audio
			STATUS=upload_audio
			local CAPTION="$3"
			;;
		png|jpg|jpeg|gif)
			CUR_URL=$PHO_URL
			WHAT=photo
			STATUS=upload_photo
			local CAPTION="$3"
			;;
		webp)
			CUR_URL=$STICKER_URL
			WHAT=sticker
			STATUS=
			;;
		mp4)
			CUR_URL=$VIDEO_URL
			WHAT=video
			STATUS=upload_video
			local CAPTION="$3"
			;;

		ogg)
			CUR_URL=$VOICE_URL
			WHAT=voice
			STATUS=
			;;
		*)
			CUR_URL=$DOCUMENT_URL
			WHAT=document
			STATUS=upload_document
			local CAPTION="$3"
			;;
	esac
	send_action $chat_id $STATUS
	res=$(curl -s "$CUR_URL" -F "chat_id=$chat_id" -F "$WHAT=@$file" -F "caption=$CAPTION")
}


