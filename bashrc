# linux version
ts2(){

words=""
for word in $@; 
do
    words="$words$word "
done

curl -s \
        "http://fanyi.youdao.com/translate?smartresult=dict&smartresult=rule&smartresult=ugc&sessionFrom=dict.top" \
     -d \
	"type=AUTO& i=$words&doctype=json&xmlVersion=1.4&keyfrom=fanyi.web&ue=UTF-8&typoResult=true&flag=false" \
        | sed -r -n 's/.*tgt":"([^"]+)".*/\1/p' ;

return 0;
}

ts(){
result=`curl -s \
        "http://dict.cn/ws.php?utf8=true&q=$1" `;

echo $result | sed -r -n 's/.*<def>([^<]+)<\/def>.*/\1/p'; 

#examples
echo $result \
    | sed -r -n 's/.*def> (<sent><orig>.*<\/sent>).*/\1/p' \
    | sed 's/&lt;em&gt;//g' \
    | sed 's/&lt;\/em&gt;//g' \
    | sed 's/<trans>/\n/g' \
    | sed 's/<orig>/\n/g' \
    | sed 's/<[^<>]*>//g';

return 0;

}

# Mac Version
# notic: ^M^L = Ctrl+v Ctrl+Enter Ctrl+v Ctrl+l
ts(){                                                                       
result=`curl -s \
        "http://dict.cn/ws.php?utf8=true&q=$1" `;

echo $result | sed -E -n 's/.*<def>([^<]+)<\/def>.*/\1/p'; 

#examples
echo $result \
    | sed -E -n 's/.*def> (<sent><orig>.*<\/sent>).*/\1/p' \
    | sed 's/&lt;em&gt;//g' \
    | sed 's/&lt;\/em&gt;//g' \
    | sed 's/<trans>/^M^L/g' \
    | sed 's/<orig>/^M^L/g' \
    | sed 's/<[^<>]*>//g' ;

return 0;

}

